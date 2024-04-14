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

Adding a shared folder to the VM settings, need to mount the shared folder in the VM

```sudo mount -t vboxsf projects projects```

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
