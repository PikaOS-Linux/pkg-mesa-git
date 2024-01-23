#! /bin/bash
set -e

# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa ./mesa-git
cp -rvf ./debian ./mesa-git/
cd ./mesa-git
git submodule update --init
sed -i ' 1 s/.*/& - PikaOS YellowBirb Mesa Git /' ./VERSION
touch debian/changelog
echo -e "mesa-git (24.1-100pika"$(date '+%Y%m%d')".git.2."$(git rev-parse --short HEAD)") pikauwu; urgency=medium\n\n  * New GIT Release\n\n -- Ward Nakchbandi <hotrod.master@hotmail.com> Sat, 01 Oct 2022 14:50:00 +0200" > debian/changelog

# Get build deps
apt-get build-dep ./ -y

# Build package

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
