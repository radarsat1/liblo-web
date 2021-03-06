#!/bin/bash

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

if ! pygmentize -V >/dev/null 2>&1; then
  echo 'Error running pygmentize, is it available? (debian package "python-pygments")'
  exit 1
fi

export $(grep PACKAGE_VERSION= $LIBLO_PATH/configure | perl -p -w -e "s/\'//g")

echo
echo -- Building liblo website based on $LIBLO_PATH
echo -- Found version $PACKAGE_VERSION
echo

sleep 1

echo
echo -- Replacing Doxygen docs...
echo -e "\e[2m"
rm -rf htdocs/docs && cp -vr $LIBLO_PATH/doc/html htdocs/docs
echo -e "\e[0m"

echo
echo -- Replacing example sources...
echo -e "\e[2m"
rm -rvf htdocs/examples/*.{c,cpp,c.html,cpp.html}
for i in $LIBLO_PATH/examples/*.{c,cpp}; do
	cp -v $i htdocs/examples/
	j=$(basename $i)
	pygmentize -O full,style=colorful,linenos=1 -f html $i \
		| perl -p -w -e "s,(<title>)(</title>),\$1$j\$2," \
		| perl -p -w -e "s,</style>,</style><link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\">," \
		| perl -p -w -e "s,<h2></h2>,<div id=\"content\"><h1>liblo: $j <a href=\"$j\">(raw)</a></h1>," \
		| perl -p -w -e "s,</body>,</div></body>," \
		| perl -p -w -e "s,background:\\s*#\\w+;,," \
		| perl -p -w -e "s,background-color:\\s*#\\w+;?,," \
		> htdocs/examples/$j.html
done
echo -e "\e[0m"

echo
echo -- Generating html from various markdown files...
echo -e "\e[2m"
echo README.html && pandoc -s $LIBLO_PATH/README.md \
  | perl -p -w -e 's,</title>,</title><link rel=stylesheet type=text/css href=style.css>,g' \
  | perl -p -w -e 's,<body>,<body><div id="content">,g' \
  | perl -p -w -e 's,</body>,</div></body>,g' \
  > htdocs/README.html
echo README-platforms.html && pandoc -s $LIBLO_PATH/build/README.md \
  | perl -p -w -e 's,</title>,</title><link rel=stylesheet type=text/css href=style.css>,g' \
  | perl -p -w -e 's,<body>,<body><div id="content">,g' \
  | perl -p -w -e 's,</body>,</div></body>,g' \
  > htdocs/README-platforms.html

# NEWS
echo NEWS.html
perl -p -0 -w -e "s/----------\n/\n# /g" $LIBLO_PATH/NEWS \
  | perl -p -w -e "s/# $//" \
  | perl -p -w -e "s/(-----)[-]*//" \
  | perl -p -w -e "s/\- Steve/\\\- Steve/" \
  | perl -p -0 -w -e "s/(\w*):\n/\$1:\n\n/g" \
  | perl -p -0 -w -e "s/0\.5\)\n\*/\)\n\n\*/g" \
  | perl -p -w -e "s/        (\w)/\- \$1/" \
  | pandoc -s \
  | perl -p -w -e 's,</title>,</title><link rel=stylesheet type=text/css href=style.css>,g' \
  | perl -p -w -e 's,<body>,<body><div id="content">,g' \
  | perl -p -w -e 's,</body>,</div></body>,g' \
  > htdocs/NEWS.html

# ChangeLog
echo ChangeLog.html
perl -p -0 -w -e "s/>\n/>\n\n/g" $LIBLO_PATH/ChangeLog \
  | perl -p -w -e 's/\t\* /  - /' \
  | pandoc -s \
  | perl -p -w -e 's,</title>,</title><link rel=stylesheet type=text/css href=style.css>,g' \
  | perl -p -w -e 's,<body>,<body><div id="content">,g' \
  | perl -p -w -e 's,</body>,</div></body>,g' \
  > htdocs/ChangeLog.html

echo -e "\e[0m"

echo
echo -- Generating index.html from index.template...
echo -e "\e[2m"

echo index.html
cat index.template \
  | perl -p -w -e "s/\\\$stable_version/$PACKAGE_VERSION/g" \
  | perl -p -w -e "s,\\\$stable_link,http://downloads.sourceforge.net/liblo/liblo-$PACKAGE_VERSION.tar.gz,g" \
  | cat >htdocs/index.html

C1=#554444
C2=#998877
C3=#ddaa77
C4=#eeeeee
C5=#ccbbbb

echo style.css
cat style.template \
  | perl -p -w -e "s/\\\$C1/$C1/g" \
  | perl -p -w -e "s/\\\$C2/$C2/g" \
  | perl -p -w -e "s/\\\$C3/$C3/g" \
  | perl -p -w -e "s/\\\$C4/$C4/g" \
  | perl -p -w -e "s/\\\$C5/$C5/g" \
  | cat >htdocs/style.css

echo -e "\e[0m"
