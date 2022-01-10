F='/etc/initramfs-tools/scripts/init-bottom/overlay'

wget -qO $F https://raw.githubusercontent.com/romandobra/stateless-debian/main/overlay

chmod +x $F

echo overlay >> /etc/initramfs-tools/modules

update-initramfs -u

echo '#OVERLAY_MODE=ram' > /etc/overlay
