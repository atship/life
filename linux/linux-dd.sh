#备份mbr
dd if=/dev/sda of=~/mbr.bin bs=512 count=1

#恢复mbr
dd if=~/mbr.bin of=/dev/sda bs=512 count=1
