NAME=clr-rpm-config
VERSION = $(shell cat VERSION)
TAGVER = $(shell cat VERSION | sed -e "s/\([0-9\.]*\).*/\1/")

ifeq ($(VERSION), $(TAGVER))
        TAG = $(TAGVER)
else
        TAG = "HEAD"
endif

all:

clean:
	rm -f *~ 

install:
	mkdir -p $(DESTDIR)/usr/lib/rpm/clr
	cp -pr * $(DESTDIR)/usr/lib/rpm/clr/
	rm -f $(DESTDIR)/usr/lib/rpm/clr/Makefile
	rm -f $(DESTDIR)/usr/lib/rpm/clr/clr-rpm-config.spec
	mkdir -p $(DESTDIR)/usr/lib/rpm/fileattrs
	mv $(DESTDIR)/usr/lib/rpm/clr/*.attr $(DESTDIR)/usr/lib/rpm/fileattrs

tag-archive:
	git tag -a $(VERSION)

create-archive:
	git archive --format=tar.gz --prefix=clr-rpm-config-$(VERSION)/ HEAD > clr-rpm-config-$(VERSION).tar.gz
	@echo "The final archive is in $(NAME)-$(VERSION).tar.gz"

archive: tag-archive create-archive
.PHONY: dist
dist: create-archive
