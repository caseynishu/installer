#! /bin/sh
# lintpkg.sh
# script to build Debian package for Weaved Installer
# sorts out Lintian errors/warnings into individual
# text files

pkg=weavedconnectd
pkgFolder=weavedconnectd_1.3-07_x86
gzip -9 "$pkgFolder"/usr/share/doc/$pkg/*.man
sudo chown root:root "$pkgFolder"/usr/share/doc/$pkg/*.gz
dpkg-deb --build "$pkgFolder"
lintian -EviIL +pedantic "$pkgFolder".deb  > lintian-result.txt
grep E: lintian-result.txt > lintian-E.txt
grep W: lintian-result.txt > lintian-W.txt
grep I: lintian-result.txt > lintian-I.txt
grep X: lintian-result.txt > lintian-X.txt
rm lintian-result.txt
ls -l *.txt
