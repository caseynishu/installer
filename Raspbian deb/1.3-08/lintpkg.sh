#! /bin/sh
# lintpkg.sh
# script to build Debian package for remot3.it connectd Installer
# sorts out Lintian errors/warnings into individual
# text files
pkg=connectd
ver=1.3-08
pkgFolder="$pkg"_"$ver"
# set architecture
controlFile="$pkgFolder"/DEBIAN/control

setEnvironment()
{
    sed -i "/Architecture:/c\Architecture: $1" "$controlFile"
    if [ -e "$pkgFolder"/usr/bin/connectd.* ]; then
        rm "$pkgFolder"/usr/bin/connectd.*
    fi
    if [ -e "$pkgFolder"/usr/bin/connectd_schannel.* ]; then
        rm "$pkgFolder"/usr/bin/connectd_schannel.*
    fi
    cp daemons/connectd."$2" "$pkgFolder"/usr/bin
    cp daemons/connectd_schannel."$2" "$pkgFolder"/usr/bin

    sed -i "/PLATFORM=/c\PLATFORM=$2" "$pkgFolder"/usr/bin/connectd_options
}


gzip -9 "$pkgFolder"/usr/share/doc/$pkg/*.man
sudo chown root:root "$pkgFolder"/usr/share/doc/$pkg/*.gz

echo "Menu - select desired architecture below"
echo "1) armhf"
echo "2) armel"
echo "3) i386 (32 bit)"
echo "4) amd64 (64 bit)"
read archMenu


if [ $archMenu -eq 1 ]; then
    arch="armhf"
    PLATFORM=pi
elif [ $archMenu -eq 2 ]; then
    arch="armel"
    PLATFORM=pi
elif [ $archMenu -eq 3 ]; then
    arch="i386"
    PLATFORM=x86
elif [ $archMenu -eq 4 ]; then
    arch="amd64"
    PLATFORM=i686
fi

setEnvironment "$arch" "$PLATFORM"

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

echo "Building Debian package for architecture: $arch"

# su gary

# now build the deb file, then rename it to add architecture
dpkg-deb --build "$pkgFolder"

version=$(grep -i version "$controlFile" | awk '{ print $2 }')


mv "$pkgFolder".deb "$pkg"_"$version"_"$arch".deb

# scan result for errors and warnings
lintian -EviIL +pedantic "$pkg"_"$version"_"$arch".deb  > lintian-result.txt
grep E: lintian-result.txt > lintian-E.txt
grep W: lintian-result.txt > lintian-W.txt
grep I: lintian-result.txt > lintian-I.txt
grep X: lintian-result.txt > lintian-X.txt
rm lintian-result.txt
ls -l *.txt
cat lintian-E.txt

