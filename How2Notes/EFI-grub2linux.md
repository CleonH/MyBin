$ efibootmgr   
BootCurrent: 0000
Timeout: 1 seconds
BootOrder: 0000,0005,0006,0002,0001,0003,0004
Boot0000* Windows Boot Manager
Boot0001* UEFI:CD/DVD Drive
Boot0002* Windows Boot Manager
Boot0003* UEFI:Removable Device
Boot0004* UEFI:Network Device
Boot0005* linux-arch-manjaro-grub32
Boot0006* EFI-shell-ia32-v2

$ sudo efibootmgr -Bb 000X
$ sudo efibootmgr --bootorder 0005,0006,0007,0001,0002,0003,0004   

$ sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo su
$ (sudo)efibootmgr --create --disk /dev/mmcblk1p1 --loader /EFI/refind/refind_ia32.efi --label "rEFInd-bootloader"
$ (sudo)efibootmgr --create --disk /dev/mmcblk1p1 --loader /EFI/manjaro/grub2mjr.efi --label "linux-arch-manjaro-grub32"

