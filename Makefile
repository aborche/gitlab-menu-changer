PKGNAME=gitlab-menu-changer

all:
	chmod 755 package/DEBIAN/postinst
	dpkg-deb --build package .

check:
	test -e $(PKGNAME)*.deb
	dpkg-deb -I $(PKGNAME)*.deb

install:
	if [ $$(id -u) -ne 0 ]; then echo WARNING: You are not root.; fi
	dpkg -i $(PKGNAME)*.deb
	dpkg --triggers-only $(PKGNAME)

checkinstall:
	dpkg --verify $(PKGNAME)
	cmp package/DEBIAN/postinst /var/lib/dpkg/info/$(PKGNAME).postinst
	grep "^/opt/gitlab/embedded/service/gitlab-rails/lib/sidebars/your_work/panel.rb $(PKGNAME)$$" /var/lib/dpkg/triggers/File

clean:
	rm -f $(PKGNAME)*.deb
	

