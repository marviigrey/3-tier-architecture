#confirm the attached volume/disk on our web-server
lsblk
#confirm number of partition
df -h
#create partition for each disk 
fdisk /dev/xvdf
fdisk /dev/xvdg  
fdisk /dev/xvdh
#confirm each volume has a partition
lsblk
#install lvm2 to confirm available partition
sudo yum install lvm2
#we turn each disk to physical volumes using pvcreate
sudo pvcreate /dev/xvdf1
sudo pvcreate /dev/xvdg1
sudo pvcreate /dev/xvdh1
#confirm physical volumes
sudo pvs
#add all newly created physical volume into a volume group(VG) with the name webdata-vg

sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1
#verify that the volume group has been created.
sudo vgs
#we create two logical volumes for storing app data and the logs of our app
sudo lvcreate -n apps-lv -L 14G webdata-vg
sudo lvcreate -n logs-lv -L 14G webdata-vg
#verify our entire setup
sudo lvs
sudo vgdisplay -v  
lsblk
#Use mkfs.ext4 to format the logical volumes with ext4 filesystem
sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
sudo mkfs -t ext4 /dev/webdata-vg/logs-lv
#create seperate directories to store website files and data logs
sudo mkdir -p /var/www/html
sudo mkdir -p /home/recovery/logs
#mount and sync the logical volumes with the web site data directories
sudo mount /dev/webdata-vg/apps-lv /var/www/html/
sudo rsync -av /var/log/. /home/recovery/logs/
sudo mount /dev/webdata-vg/logs-lv /var/log
sudo rsync -av /home/recovery/logs/. /var/log
#display the uid of our log and app,copy them
sudo blkid
#mount the uid for app and log into the fstab config file
#example UUID=2b68b35d-7f7e-4d2d-9c9d-5f6e621ebff6    /var/log     ext4  defaults        0       0
#example UUID=c9cde407-2c16-48a4-b455-31a0eece9c67    /var/www/html ext4 defaults        0       0 
vi /etc/fstab
sudo blkid
#Test the configuration and reload the daemon
sudo mount -a
sudo systemctl daemon-reload
#verify setup
df -h
