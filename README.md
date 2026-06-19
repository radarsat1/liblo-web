Steps for release:

* Download artifacts from ${RELEASE} build.
* Unpack into a temporary directory `liblo-release`.
* Publish tarball and dylib on Github Releases.
* Go to `../liblo/doc`; then `make`
* Here: `./build.sh`
* Open `htdocs/index.html` and check all links.

Add release files to local dir and scp it

```shell
export RELEASE=0.36
cd ../liblo-web
mkdir ${RELEASE}
mv ../liblo-release/liblo-${RELEASE}.tar.gz  ../liblo-release/liblo.7.dylib ${RELEASE}/
scp -r ${RELEASE} radarsat1@web.sf.net:/home/frs/project/liblo/liblo/
```

Clear up the liblo-website dir
```shell
rm -rf ${RELEASE}
```

Archive website
```shell
tar -cjf ${RELEASE}_site.tar.bz2 *
scp ${RELEASE}_site.tar.bz2 radarsat1@web.sf.net:
rm ${RELEASE}_site.tar.bz2 # clear again
```

Update website
```shell
rsync -rvP cgi-bin htdocs radarsat1@web.sf.net:/home/project-web/liblo/
```

Then logged into SourceForge and made it the default download.
