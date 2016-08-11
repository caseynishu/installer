#! /bin/sh
# lintpkg.sh
# script to build Debian package for Weaved Installer
# sorts out Lintian errors/warnings into individual
# text files

pkg=weavedconnectd
pkgFolder=weavedconnectd_1.3-07

echo "Menu"
echo "1) armhf"
echo "2) armel"
read archMenu

if [ $archMenu -eq 1 ]; then
    arch="_armhf"
elif [ $archMenu -eq 2 ]; then
    arch="_armel"
fi

gzip -9 "$pkgFolder"/usr/share/doc/$pkg/*.man
sudo chown root:root "$pkgFolder"/usr/share/doc/$pkg/*.gz

# set architecture
if [ $archMenu -eq 1 ]; then
     sed 's/"Architecture: arm.*"/"Architecture: armhf"/' < "$pkgFolder"/DEBIAN/control > /tmp/control
elif [ $archMenu -eq 2 ]; then
     sed 's/"Architecture: arm.*"/"Architecture: armel"/' < "$pkgFolder"/DEBIAN/control > /tmp/control
fi

controlFile="$pkgFolder"/DEBIAN/control
sudo chmod a+w "$controlFile"
sudo mv /tmp/control "$controlFile"
sudo chmod 644 "$controlFile"

# now build the deb file, then rename it to add architecture
dpkg-deb --build "$pkgFolder"

version=$(grep -i version "$controlFile" | awk '{ print $2 }')

mv "$pkgFolder".deb "$pkg$version$arch".deb

# scan result for errors and warnings
lintian -EviIL +pedantic "$pkg$version$arch".deb  > lintian-result.txt
grep E: lintian-result.txt > lintian-E.txt
grep W: lintian-result.txt > lintian-W.txt
grep I: lintian-result.txt > lintian-I.txt
grep X: lintian-result.txt > lintian-X.txt
rm lintian-result.txt
ls -l *.txt
cat lintian-E.txt

