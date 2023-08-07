# Clone Upstream
git clone https://gitlab.freedesktop.org/mesa/mesa -b mesa-23.1.5
cp -rvf ./debian ./mesa/
cd ./mesa
touch debian/changelog
#echo -e "linux-firmware ("$(date '+%Y%m%d')".git-99pika"$(date '+%M')") lunar; urgency=medium\n\n  * New Upstream Release\n\n -- Ward Nakchbandi <hotrod.master@hotmail.com> Sat, 01 Oct 2022 14:50:00 +0200" > debian/changelog
echo -e "mesa (23.3-git.$(git rev-parse HEAD)-99pika"$(date '+%M')") lunar; urgency=medium\n\n  * New Git Release\n\n -- Ward Nakchbandi <hotrod.master@hotmail.com> Sat, 01 Oct 2022 14:50:00 +0200" > debian/changelog

# Get build deps
apt-get build-dep ./ -y

# Build package

dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./mesa-vulkan*.deb ./output/
