# Got a Spartan-6 FPGA SP605 Eval kit
So I got a Spartan-6 SP605 Evaluation kit for free, these are discontinued, but I want to see if I can get it up and play around with it.

It has a SFP cage, thats nice, would like to get that working.

Also PCIe Gen1 would be nice to experiment with.

Video DVI/VGA would be interesting.
Among other interfaces.

## Setup
SW and licensing? It seems I have the rev D board, so tool version is ISE Design Suite 13.4 that is latest.

The eval kit should have a node-locked license, so probably need to contact Xilinx support to get that sorted.
The latest ISE 14.7 at least did not need a license to build, the webpack license seemed to work fine.

Seems problematic with ISE, trying the ISE 14.7 win 10, its a VM version. so it should work in windows 10 (11?).

This needs virtual box 5.2
https://www.virtualbox.org/wiki/Download_Old_Builds_5_2

ISE 14.7 win 10 installer does not work on windows 11, claims virtualization is not enabled in BIOS, but I have it enabled so that is not the problem.
I can import the .ova file from the ova folder in the Xilinx install folder.
 
That did not work still complained about virtualization not enabled.
Fond this: https://helpdeskgeek.com/virtualization/how-to-fix-vt-x-is-not-available-verr_vmx-no-vmx-error-in-virtualbox/
And following that setting the hyper-v feature off it looks like the virtual machine starts with ISE 14.7!!!

Re adding the Hyper-v feature for wsl this stopped working, but updating virtualbox to version 7.0.16 the virtual machine started up.

Adding a shared folder to the VM settings, need to mount the shared folder in the VM

```sudo mount -t vboxsf projects projects```

In the shared folder settings one can just mark it as auto mount and its mounted when the virtual machine boots.

Here the mount and share is named projects.

## Links
https://www.xilinx.com/products/boards-and-kits/ek-s6-sp605-g.html#overview


## Example project
see resources here: https://www.xilinx.com/products/boards-and-kits/ek-s6-sp605-g.html#resources

Trying the DDR3 example.
Hmm, did not give me much.


Started a new project to try to get a blinky working.
Seems I managed to make something and compile it into a programming file...
Got blinky running on the board. example code in blinky folder.

## Need to get basics working

### Uart
First I need a uart point so I can get debug data out for next stages.
looking at https://docs.amd.com/v/u/en-US/ug526 there is a usb to uart bridge.


### First loop back serial
Trying to just loop back the input so RX to TX.
That worked as expected with following constraint:
```
NET "uart_tx" LOC = B21 | IOSTANDARD = LVCMOS25        ;
NET "uart_rx" LOC = H17 | IOSTANDARD = LVCMOS25        ;
```

### Next try adding a uart module.
Tried my old UART module in vhdl lib github project and that worked perfect.

### Ethernet
Would like to get the ethernet working, to be able to receive and send data on the ethernet interface.
It seems the mac ip in xilinx is licensed so cant use it.
Found this project that could be interesting to try out if it can be used.
https://github.com/yol/ethernet_mac

Got the MAC over working, using the following constraints.

```
NET "clk_200_pi"         LOC = K21 | IOSTANDARD = LVDS_25;
                                            
#NET "clk" TNM_NET = "net_gclk_0";
#TIMESPEC TS_net_gclk_0 = PERIOD "net_gclk_0" 20 ns;     # over constrained at 20ns, There should be a 27MHz (37ns) oscillator installed here.
         
# SP605 board only                                            
NET "led_o[0]"         LOC = D17 | IOSTANDARD = LVCMOS25        ;
NET "led_o[1]"         LOC = AB4 | IOSTANDARD = LVCMOS25        ;
NET "led_o[2]"         LOC = D21 | IOSTANDARD = LVCMOS25        ;
NET "led_o[3]"         LOC = W15 | IOSTANDARD = LVCMOS25        ;


# phy signals
net "phy_reset_o"   LOC = J22 | IOSTANDARD = LVCMOS25   ;
net "mdc_o"         LOC = R19 | IOSTANDARD = LVCMOS25   ;
net "mdio_io"       LOC = V20 | IOSTANDARD = LVCMOS25   ;

# MII signals

net "gmii_gtx_clk_o"     LOC = AB7 | IOSTANDARD = LVCMOS25   ;
net "mii_tx_clk_i"       LOC = L20 | IOSTANDARD = LVCMOS25   ;
net "mii_tx_er_o"        LOC = U8 | IOSTANDARD = LVCMOS25    ;
net "mii_tx_en_o"        LOC = T8 | IOSTANDARD = LVCMOS25    ;
net "mii_txd_o[0]"       LOC = U10 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[1]"       LOC = T10 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[2]"       LOC = AB8 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[3]"       LOC = AA8 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[4]"       LOC = AB9 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[5]"       LOC = Y9 | IOSTANDARD = LVCMOS25    ;
net "mii_txd_o[6]"       LOC = Y12 | IOSTANDARD = LVCMOS25   ;
net "mii_txd_o[7]"       LOC = W12 | IOSTANDARD = LVCMOS25   ;

net "mii_rx_clk_i"       LOC = P20 | IOSTANDARD = LVCMOS25   ;
net "mii_rx_er_i"        LOC = U20 | IOSTANDARD = LVCMOS25   ;
net "mii_rx_dv_i"        LOC = T22 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[0]"       LOC = P19 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[1]"       LOC = Y22 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[2]"       LOC = Y21 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[3]"       LOC = W22 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[4]"       LOC = W20 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[5]"       LOC = V22 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[6]"       LOC = V21 | IOSTANDARD = LVCMOS25   ;
net "mii_rxd_i[7]"       LOC = U22 | IOSTANDARD = LVCMOS25   ;
```

Connecting this up and connecting the rx to the serial port I see data flowing, so this deffinitly works.

#### Next steps for ethernet would be to get ARP ICMP working
With ARP and ICMP we can test with ping, also sending ip packets to the board.

Would also need to have some ethernet framer and deframer module to strip and encapsulate the raw ethernet packets.

Tok way long but got arp echo working sending arp packets received out on serial port.
The mac rx_fifo does not work with reading on every clock cycle so needed to add a delay and read only every other clock cycle...
