#constraints

set_property  -dict {PACKAGE_PIN  N18  IOSTANDARD LVCMOS25} [get_ports CLK_IN]; 
set_property  -dict {PACKAGE_PIN  P19  IOSTANDARD LVCMOS25} [get_ports RESET]; 

set_property  -dict {PACKAGE_PIN  P2   IOSTANDARD LVCMOS18} [get_ports AD_SDATA]; 
set_property  -dict {PACKAGE_PIN  R2   IOSTANDARD LVCMOS18} [get_ports AD_RESET]; 
set_property  -dict {PACKAGE_PIN  P1   IOSTANDARD LVCMOS18} [get_ports AD_SEN]; 
set_property  -dict {PACKAGE_PIN  R1   IOSTANDARD LVCMOS18} [get_ports AD_SCLK]; 
set_property  -dict {PACKAGE_PIN  AA1  IOSTANDARD LVCMOS18} [get_ports AD_SDOUT]; 
set_property  -dict {PACKAGE_PIN  Y11  IOSTANDARD LVCMOS18} [get_ports AD_CTRL[0]]; 
set_property  -dict {PACKAGE_PIN  AB10 IOSTANDARD LVCMOS18} [get_ports AD_CTRL[1]]; 
set_property  -dict {PACKAGE_PIN  AA10 IOSTANDARD LVCMOS18} [get_ports AD_CTRL[2]]; 

set_property  -dict {PACKAGE_PIN  AA9  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[0]];
set_property  -dict {PACKAGE_PIN  AA8  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[0]];
set_property  -dict {PACKAGE_PIN  T5   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[1]];
set_property  -dict {PACKAGE_PIN  U5   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[1]];
set_property  -dict {PACKAGE_PIN  W6   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[2]];
set_property  -dict {PACKAGE_PIN  Y6   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[2]];
set_property  -dict {PACKAGE_PIN  AA6  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[3]];
set_property  -dict {PACKAGE_PIN  AB6  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[3]];
set_property  -dict {PACKAGE_PIN  AA5  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[4]];
set_property  -dict {PACKAGE_PIN  AB5  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[4]];
set_property  -dict {PACKAGE_PIN  W5   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_P[5]];
set_property  -dict {PACKAGE_PIN  Y4   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DA_N[5]];

set_property  -dict {PACKAGE_PIN  AA3  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[0]];
set_property  -dict {PACKAGE_PIN  AB2  IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[0]];
set_property  -dict {PACKAGE_PIN  Y3   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[1]];
set_property  -dict {PACKAGE_PIN  Y2   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[1]];
set_property  -dict {PACKAGE_PIN  W1   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[2]];
set_property  -dict {PACKAGE_PIN  Y1   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[2]];
set_property  -dict {PACKAGE_PIN  V3   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[3]];
set_property  -dict {PACKAGE_PIN  W2   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[3]];
set_property  -dict {PACKAGE_PIN  U2   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[4]];
set_property  -dict {PACKAGE_PIN  V2   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[4]];
set_property  -dict {PACKAGE_PIN  T1   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_P[5]];
set_property  -dict {PACKAGE_PIN  U1   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_DB_N[5]];

set_property  -dict {PACKAGE_PIN  T4   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_CLKOUT_P];
set_property  -dict {PACKAGE_PIN  U3   IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports AD_CLKOUT_N];

set_property  -dict {PACKAGE_PIN  AA11 IOSTANDARD LVDS} [get_ports Local_CLKOUT_P];
set_property  -dict {PACKAGE_PIN  AB11 IOSTANDARD LVDS} [get_ports Local_CLKOUT_N];

set_property  -dict {PACKAGE_PIN  W15  IOSTANDARD LVCMOS33} [get_ports DA_CLKA];
set_property  -dict {PACKAGE_PIN  Y16  IOSTANDARD LVCMOS33} [get_ports DA_CLKB];
set_property  -dict {PACKAGE_PIN  AA18 IOSTANDARD LVCMOS33} [get_ports DA_WRTA];
set_property  -dict {PACKAGE_PIN  AB18 IOSTANDARD LVCMOS33} [get_ports DA_WRTB];

set_property  -dict {PACKAGE_PIN  W16  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[0]];
set_property  -dict {PACKAGE_PIN  V15  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[1]];
set_property  -dict {PACKAGE_PIN  U15  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[2]];
set_property  -dict {PACKAGE_PIN  U16  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[3]];
set_property  -dict {PACKAGE_PIN  V17  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[4]];
set_property  -dict {PACKAGE_PIN  T15  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[5]];
set_property  -dict {PACKAGE_PIN  T16  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[6]];
set_property  -dict {PACKAGE_PIN  R16  IOSTANDARD LVCMOS33} [get_ports DA_DBPA[7]];

set_property  -dict {PACKAGE_PIN  AA14 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[0]];
set_property  -dict {PACKAGE_PIN  AB15 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[1]];
set_property  -dict {PACKAGE_PIN  AA15 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[2]];
set_property  -dict {PACKAGE_PIN  AB16 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[3]];
set_property  -dict {PACKAGE_PIN  Y14  IOSTANDARD LVCMOS33} [get_ports DA_DBPB[4]];
set_property  -dict {PACKAGE_PIN  AA16 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[5]];
set_property  -dict {PACKAGE_PIN  AB17 IOSTANDARD LVCMOS33} [get_ports DA_DBPB[6]];
set_property  -dict {PACKAGE_PIN  W14  IOSTANDARD LVCMOS33} [get_ports DA_DBPB[7]];


#IO bank
set_property  -dict {PACKAGE_PIN  B18  IOSTANDARD LVCMOS33} [get_ports SCK];
set_property  -dict {PACKAGE_PIN  A19  IOSTANDARD LVCMOS33} [get_ports CS];
set_property  -dict {PACKAGE_PIN  C19  IOSTANDARD LVCMOS33} [get_ports MOSI];
set_property  -dict {PACKAGE_PIN  A20  IOSTANDARD LVCMOS33} [get_ports MISO];
set_property  -dict {PACKAGE_PIN  B20  IOSTANDARD LVCMOS33} [get_ports DRDY];


#set_property  -dict {PACKAGE_PIN  A21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[5]];
#set_property  -dict {PACKAGE_PIN  D19  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[6]];
#set_property  -dict {PACKAGE_PIN  B21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[7]];
#set_property  -dict {PACKAGE_PIN  B22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[8]];
#set_property  -dict {PACKAGE_PIN  C20  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[9]];
#set_property  -dict {PACKAGE_PIN  C22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[10]];
#set_property  -dict {PACKAGE_PIN  D22  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[11]];
#set_property  -dict {PACKAGE_PIN  D21  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[12]];
#set_property  -dict {PACKAGE_PIN  D20  IOSTANDARD LVCMOS33} [get_ports IO_BANK0[13]];