# stateless-debian
To make any Debian-based system a "stateless" one.
You can experiment with your system as much as you want - install/remove software, change settings etc. All the changes will "disappear" at the next boot.

**WARNING: Experimental! Mind your risks!**

## How it works
When your system boots to initramfs, it runs an `overlay` script just before the final `/root` mount.
This script then checks if your system has a file named `/etc/overlay` and sources it if so. There you can find a setting for the next boot. Uncomment the `#OVERLAY_MODE=ram` line and change the settings as needed. Default behavior is to ask the user the mode he wants this time.

Possible settings:
* `none` - This way your system will boot as usual.
* `ram` - Your hard drive will be mounted at the `/run/overlay` point, and on top of that there will be RAM [overlayfs](https://en.wikipedia.org/wiki/OverlayFS) mount. This means that all your changes to the system partition (e.g. new apt installs, settings etc) for this boot will be stored in RAM. After you reboot your system, it will have the same state as before. This applies only for your system partition.
* `toram` - Your system partition's content will be copied to RAM and system will boot from there (you need your RAM to be more than twice bigger than the system you are going to boot, means if you have 500Mb of your boot partition content, then your RAM should be bigger than 1Gb).
* `(anything else)` - Drop to initramfs shell.

## One line install:
It is **unsafe** to blindly run scripts from the internet! Only do that if you trust this publisher or if you have nothing to lose!

`wget -qO - https://raw.githubusercontent.com/romandobra/stateless-debian/main/install.sh | sudo bash`.

The `install.sh` script will do the following:
* Download and install the `overlay` script
* Add `overlay` module to your `/etc/initramfs-tools/modules`
* Update initramfs
* Make a new file `/etc/overlay` with this content: `#OVERLAY_MODE=ram`

## Enjoy and be free to ask questions in the Issues tab!
