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
echo README.html && pandoc -s $LIBLO_PATH/README.md -o htdocs/README.html
echo README-platforms.html && pandoc -s $LIBLO_PATH/build/README.md -o htdocs/README-platforms.html

# NEWS
echo NEWS.html
perl -p -0 -w -e "s/----------\n/\n# /g" $LIBLO_PATH/NEWS \
  | perl -p -w -e "s/# $//" \
  | perl -p -w -e "s/(-----)[-]*//" \
  | perl -p -w -e "s/\- Steve/\\\- Steve/" \
  | perl -p -0 -w -e "s/(\w*):\n/\$1:\n\n/g" \
  | perl -p -0 -w -e "s/0\.5\)\n\*/\)\n\n\*/g" \
  | perl -p -w -e "s/        (\w)/\- \$1/" \
  | pandoc -s -o htdocs/NEWS.html

# ChangeLog
echo ChangeLog.html
pandoc -s $LIBLO_PATH/ChangeLog -o htdocs/ChangeLog.html
