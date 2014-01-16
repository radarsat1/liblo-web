#!/bin/sh

LIBLO_PATH=$1
if [ x$LIBLO_PATH = x ]; then
  LIBLO_PATH=../liblo
fi
if ! [ -d "$LIBLO_PATH" ]; then
  echo Please specify path to the liblo source.
  exit 1
fi

if ! [ -e $LIBLO_PATH/doc/doxygen-build.stamp ]; then
  echo Documentation not built in $LIBLO_PATH
  exit 1
fi

if ! [ -e $LIBLO_PATH/ChangeLog ]; then
  echo No ChangeLog found in $LIBLO_PATH
  exit 1
fi

if ! pandoc -v >/dev/null 2>&1; then
  echo Error running pandoc, is it available?
  exit 1
fi

echo
echo -- Building liblo website based on $LIBLO_PATH

echo
echo -- Replacing Doxygen docs...
rm -rvf htdocs/docs && cp -vr $LIBLO_PATH/doc/html htdocs/docs

echo
echo -- Replacing example sources...
rm -rvf htdocs/examples/*.c && cp -v $LIBLO_PATH/examples/*.c htdocs/examples/

echo
echo -- Generating html from various markdown files...
pandoc -s $LIBLO_PATH/README.md -o htdocs/README.html
pandoc -s $LIBLO_PATH/build/README.md -o htdocs/README-platforms.html
pandoc -s $LIBLO_PATH/NEWS -o htdocs/NEWS.html
pandoc -s $LIBLO_PATH/ChangeLog -o htdocs/ChangeLog.html
