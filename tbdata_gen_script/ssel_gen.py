import numpy as np

# 假设每次ssel在延时10个SCK周期后拉下，持续64个SCK周期
sck_period = 100
ssel_delay = 10*sck_period
ssel_duration = 64*sck_period
ssel_num = 10

# ssel_size = ssel_num* (ssel_duration + ssel_delay)
# ssel = np.zeros(1,ssel_size)

high = np.ones(ssel_delay)
low = np.zeros(ssel_duration)

ssel_signal = np.concatenate((high,low), axis = None)
ssel = np.zeros(0)

for i in range (ssel_num):
    ssel = np.concatenate((ssel,ssel_signal),axis = None)

ssel_f = np.concatenate((ssel, np.ones(100*sck_period)), axis = None)

np.savetxt('ssel_data.txt', ssel_f, fmt='%1d', delimiter='')
# f=open('ssel_data.txt', 'w')
# f.write(ssel)
# f.close()
