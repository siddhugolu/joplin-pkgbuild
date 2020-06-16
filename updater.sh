#/bin/env bash

# Update version

PKGNAME="joplin"

UPDATEVERSION=$1
URL=https://github.com/laurent22/joplin/archive/v1.0.218.tar.gz

# Download the latest version tar file
NEWURL=`echo $URL | sed "s/v1.0.218.tar.gz/v${UPDATEVERSION}.tar.gz/g"`
OLDSOURCE=joplin-1.0.218.tar.gz
NEWSOURCE=joplin-${UPDATEVERSION}.tar.gz

# wget -c -O $NEWSOURCE $NEWURL

# Update joplin.desktop file and source tar.gz file, get new sha256sum
CURSUM=$(sha256sum ${PKGNAME}.desktop | awk '{print$1}')
CURSUM2=$(sha256sum ${OLDSOURCE} | awk '{print$1}')

sed -i "s/Version=.*/Version=${UPDATEVERSION}/g" ${PKGNAME}.desktop

sleep 3

NEWSUM=$(sha256sum ${PKGNAME}.desktop | awk '{print$1}')
NEWSUM2=$(sha256sum ${NEWSOURCE} | awk '{print$1}')

# Update PKGBUILD
sed -i "s/pkgver=.*/pkgver=${UPDATEVERSION}/g" PKGBUILD
sed -i "s/${CURSUM}/${NEWSUM}/g" PKGBUILD
sed -i "s/${CURSUM2}/${NEWSUM2}/g" PKGBUILD
