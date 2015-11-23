#!/bin/bash
PACKAGE_LIST="basesystem-minimal distro-release-OpenMandriva urpmi"
MIRROR="http://abf-downloads.rosalinux.ru/"
DISTRO="openmandriva2014.0"
ARCH="x86_64"
TMP_PATH="/tmp/chroot_omv"

generate_chroot(){
if [ ! -d "$TMP_PATH" ]; then
mkdir -p $TMP_PATH
else
sudo rm -rf $TMP_PATH/*
fi

sudo urpmi.addmedia --urpmi-root $TMP_PATH main_release $MIRROR/$DISTRO/repository/$ARCH/main/release
sudo urpmi.addmedia --urpmi-root $TMP_PATH main_release_updates $MIRROR/$DISTRO/repository/$ARCH/main/updates
sudo urpmi --no-verify-rpm --no-suggests --root $TMP_PATH --urpmi-root $TMP_PATH $PACKAGE_LIST

}

docker_import(){
echo "import image"
tar -C $TMP_PATH -c . | docker import - openmandriva2014.0
}
generate_chroot
