# SPI 相关

在CS拉高再拉低后，发送一个finish

Ping

finish 换页，拉高一个脉冲（时钟周期），Ready表示这页有没有数据

时钟使用？

第八个上升沿 byteReceived 为 1 的时候更新data，存入RAM，addr + 1，使能拉高读取后，在下一个sck上升沿到来之前，byteReceived一直为1，这时等到byteReceived置零后，wea才可能继续

wea 一直置高，知道ssel 信号拉高，发送finisha，然后把wea拉低，直到ssel拉低

一个sck之后，byteReceived才置为0；

![1562414354119](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562414354119.png)

![1562479051669](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562479051669.png)

Ref: ADuCM datasheet 

Mode 0下，从设备上升沿采样，下降沿输出。



![1562479111547](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562479111547.png)

Master设备在上升沿接受MISO的数据，上升沿采样，下降沿输出



## 时序问题

dataNeeded = ssel_active && bitcnt == 3'b000

if(sck_risingEdge && dataNeeded)

addrb <= addrb + 1;

dataTosend 比 addrb 慢两个时钟周期

dataTosendBuffer 仅在bitcnt == 3'b000时更新 一个时钟周期

# PING PONG RAM

readya 可以写入

readyb 可以读取

远离SPI的口必须不能是8位

从RAM里一次读出1 Byte，Enable后赋值给一个dataToSend，在bitcnt == 0的时候（八个SCK下降沿之后）（dataNeeded） addrb1 + 1 然后继续。

直到 CS 拉高（上升沿） 把addrb1 置零， 给一个周期的finishb1的拉高信号

等待第八个

RAM 和给定的地址差两拍。先给地址，在把地址赋值给寄存器。这两个操作各需要一拍子。

![1562572799835](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562572799835.png)

## 关于几个端口ready信号的问题

初始数据 ： a口输入为1，b口输出为0，只有检测到两个端口的指针不在同一页的时候才会ready



| a0   | 0    |
| ---- | ---- |
| b0   | 0    |
| a1   | 0    |
| b1   | 0    |

所以整个流程就是

第一次交易：CS信号拉低再拉高后，a口翻页，b口不变，二者都是ready状态，CS拉高后开始准备b口的数据，按照输入的addra的地址，b口进行输出，输出的数据进入DSP模块。连接到RAM1的a口（处于ready状态），因为读取有两个时钟的延时，所以取第三个时钟开始的数据。存到RAM1中。当数据全部存入后，给RAM1 a口一个finish信号，等待下一个CS的到来。

CS刚拉高

| a0   | 1    |
| ---- | ---- |
| b0   | 0    |
| a1   | 0    |
| b1   | 0    |

第二次CS拉低之前，从RAM0至RAM1数据传输结束(addra0的counter遍历后)。这里因为RAM读取需要两个时钟周期的延时，所以我们先将第一个数据存在要发送的寄存器里。（MISO部分）

| a0   | 1    |
| ---- | ---- |
| b0   | 0    |
| a1   | 1    |
| b1   | 0    |

第二次交易：CS信号拉低，两个端口都处于ready状态，继续向a口中写入数据（右半页），CS拉高后换页，同时b口也换页。a0与b0在CS上升沿换页（第一次上升沿b0不换页）。

a1在两次交易期间换页。 b1在CS上升沿换页（第一次不换页c0）

| a0   | 0    |
| ---- | ---- |
| b0   | 1    |
| a1   | 0    |
| b1   | 1    |



## 新版子 xc7k70t

# DSP

DSP里面只有组合逻辑

但是读多少，读取的地址都是DSP给出的

DSP不应该和SPI相连

但是什么时候读取数据与Chip Select相关，需要检测上升沿，也需要时钟

![1562746352708](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562746352708.png)

这里wea1 = readyb0 && readya1

至于什么时候addrb0与addra1的地址reset，可以是DSP需要的数据全部读取完毕，或者是readyb0 不是ready了，一般要前者

读取要慢两拍子，wea1和b1的地址要打两拍

![1562746674850](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562746674850.png)

前八个数据

12，EA，0B，13，25，9A，87，82

9-16

10001100	8C
11011010	DA
00001100	0C
00010100	14
00011100	1C
01011111	5F
10000110	86
00000000	00

![1562747129868](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562747129868.png)

![1562759408451](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562759408451.png)

write enable 与地址统一了

![1562759991090](https://github.com/Ryushane/SPI-with-PINGPONG-RAM/blob/master/Picture/1562759991090.png)

多了一拍