# FreeBSD 14 - Install GNOME



Once you install the FreeBSD 14 on a bare-bone style, you have to do something extra for having a GUI handy.



1. Install some dependencies

   ```
   pkg update && pkg upgrade
   pkg install bash nano sudo git curl wget neofetch
   ```

   

2. If there is only a `root` user, please create a common user, say `alfazen`, and add the user into `wheel`, `video` and `operator` groups during creation (DM me for default password).

   ```
   adduser
   ```

   

3. Optionally add the common user to `wheel`, `video`, `operator` groups if forgetting to join such in previous step:

   ```
   pw groupmod video -m alfazen
   pw groupmod wheel -m alfazen
   pw groupmod operator -m alfazen
   ```

   

4. Add the common user to `sudoers` group by editing `/usr/local/etc/sudoers`:

   ```
   ## User privilege specification
   alfazen ALL=(ALL:ALL) ALL
   ```

   and uncomment the 3 lines:

   ```
   # %wheel ALL=(ALL:ALL) ALL
   # %wheel ALL=(ALL:ALL) NOPASSWD: ALL
   # %sudo ALL=(ALL:ALL) ALL 
   ```

   

5. Install graphics card driver of VMware or Nvidia, or AMD, or Intel.

   ```
   ## For Vmware
   pkg install -y open-vm-tools xf86-video-vmware xf86-input-vmmouse xf86-input-mouse xf86-input-keyboard
   ```

   

6. Install GNOME meta package, a full set of apps.

   ```
   # 2 folders for Gnome icons and themes
   mkdir /usr/share/icons/hicolor /usr/share/icons/HoghContrast
   
   ## GNOME packages
   pkg install -y xorg gnome firefox vlc
   ## GNOME-LITE packages - Alternative
   pkg install -y xorg gnome-lite  firefox vlc gnome-terminal
   ```

   This is very long process as it will download quite some packages from Internet.

   

7. A few Configuration

   * Configure the `/etc/rc.conf` by injecting the following:

     ```
     sysrc sshd_enable="YES"
     sysrc dbus_enable="YES"
     sysrc gdm_enable="YES"
     sysrc moused_enable="YES"
     sysrc linux_enable="YES"
     #sysrc moused_port="/dev/psm0"
     #sysrc nfs_client_enable="YES"
     #sysrc autofs_enable="YES"
     #sysrc kld_list="fusefs"
     #sysrc cupsd_enable="YES"
     ```
     
   * Optionally configure the `/etc/fstab` by adding in the following row:
   
     ```
     echo 'proc    /proc    procfs  rw  0  0' >> /etc/fstab
     ```
     
     
   
8. Then reboot the computer and log back in at a GUI.

  ```
  reboot
  ```

  

  