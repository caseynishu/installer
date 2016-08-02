#! /bin/bash
# lintpkg.sh
# script to build Debian package for Weaved Installer
# sorts out Lintian errors/warnings into individual
# text files
# also copies deb file to web server source folder
# in order to easily transfer to target device on
# LAN using wget
#
target=192.168.2.63

pkg=remot3it
version=1.3-07
arch=armhf
pkgFolder="$pkg"_"$version"_"$arch"
echo "pkgFolder=$pkgFolder"
gzip -9 "$pkgFolder"/usr/share/doc/$pkg/*.man
sudo chown root:root "$pkgFolder"/usr/share/doc/$pkg/*.gz

# clean up and recreate md5sums file
cd "$pkgFolder"
sudo chmod 777 DEBIAN
# ls -l
find -type f ! -regex '.*?DEBIAN.*' -exec md5sum "{}" + | grep -v md5sums > md5sums
sudo chmod 775 DEBIAN
sudo mv md5sums DEBIAN
sudo chmod 644 DEBIAN/md5sums
sudo chown root:root DEBIAN/md5sums
cd ..

#------ now build everything
dpkg-deb --build "$pkgFolder"

#------ run lintian to find erros and warnings
lintian -EviIL +pedantic "$pkgFolder".deb  > lintian-result.txt
grep E: lintian-result.txt > lintian-E.txt
grep W: lintian-result.txt > lintian-W.txt
grep I: lintian-result.txt > lintian-I.txt
grep X: lintian-result.txt > lintian-X.txt
rm lintian-result.txt
ls -l *.txt
# sudo cp "$pkgFolder".deb /var/www
# scp ./$pkgFolder.deb pi@$target:/tmp/$pkgFolder.deb
cat lintian-E.txt
cat lintian-W.txt
