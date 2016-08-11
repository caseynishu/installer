#! /bin/sh
# lintpkg.sh
# script to build Debian package for Weaved Installer
# sorts out Lintian errors/warnings into individual
# text files
pkg=weavedconnectd
pkgFolder=weavedconnectd_1.3-07

gzip -9 "$pkgFolder"/usr/share/doc/$pkg/*.man
sudo chown root:root "$pkgFolder"/usr/share/doc/$pkg/*.gz

echo "Menu"
echo "1) armhf"
echo "2) armel"
read archMenu

# set architecture
controlFile="$pkgFolder"/DEBIAN/control

if [ $archMenu -eq 1 ]; then
    arch="_armhf"
     sed 's/Architecture: arm.*/Architecture: armhf/' < "$controlFile" > /tmp/control
elif [ $archMenu -eq 2 ]; then
    arch="_armel"
    sed 's/Architecture: arm.*/Architecture: armel/' < "$controlFile" > /tmp/control
fi

sudo chmod a+w "$controlFile"
sudo cp /tmp/control "$controlFile"
sudo chmod 644 "$controlFile"

# now build the deb file, then rename it to add architecture
dpkg-deb --build "$pkgFolder"

version=$(grep -i version "$controlFile" | awk '{ print $2 }')

mv "$pkgFolder".deb "$pkg"_"$version$arch".deb

# scan result for errors and warnings
lintian -EviIL +pedantic "$pkg"_"$version$arch".deb  > lintian-result.txt
grep E: lintian-result.txt > lintian-E.txt
grep W: lintian-result.txt > lintian-W.txt
grep I: lintian-result.txt > lintian-I.txt
grep X: lintian-result.txt > lintian-X.txt
rm lintian-result.txt
ls -l *.txt
cat lintian-E.txt

