#! /bin/bash
set -e

# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa
cp -rvf ./debian ./mesa/
cd ./mesa
sed -i ' 1 s/.*/& - PikaOS YellowBirb Vulkan Only Mesa /' ./VERSION
touch debian/changelog
echo -e "mesa (23.3.git."$(git rev-parse --short HEAD)"-99pika"$(date '+%Y%m%d')") lunar; urgency=medium\n\n  * New GIT Release\n\n -- Ward Nakchbandi <hotrod.master@hotmail.com> Sat, 01 Oct 2022 14:50:00 +0200" > debian/changelog

# Get build deps
apt-get build-dep ./ -y

# Build package

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./mesa-vulkan*.deb ./output/
