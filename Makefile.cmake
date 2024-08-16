# vim: set ft=make :

.PHONY: appimage clean default debug package release

default:
	@echo "targets: appimage (Linux only), clean, debug, package, release"

appimage:
	cmake -H. -Bbuilds/appimage -DCMAKE_INSTALL_PREFIX=/usr
	cd builds/appimage && make install DESTDIR=../AppDir
	if [ "$(DSGEN)" = "" ]; then \
		cd builds/appimage && make DBMS= appimage; \
	else \
		mkdir -p builds/AppDir/opt; \
		unzip -d builds/AppDir/opt "$(DSGEN)"; \
		mv builds/AppDir/opt/DSGen* builds/AppDir/opt/dsgen; \
		builds/AppDir/usr/bin/dbt7-build-dsgen --patch-dir=patches \
				builds/AppDir/opt/dsgen; \
		sed -i -e "s#/usr#././#g" builds/AppDir/opt/dsgen/tools/dsdgen \
				builds/AppDir/opt/dsgen/tools/dsqgen; \
		export DBMS=$(DBMS); \
		cd builds/appimage && make DBMS=$(DBMS) appimage; \
	fi

clean:
	-rm -rf builds

debug:
	cmake -H. -Bbuilds/debug -DCMAKE_BUILD_TYPE=Debug
	cd builds/debug && make

package:
	git checkout-index --prefix=builds/source/ -a
	cmake -Hbuilds/source -Bbuilds/source
	cd builds/source && make package_source

release:
	cmake -H. -Bbuilds/release
	cd builds/release && make
