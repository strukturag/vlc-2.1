# libde265

LIBDE265_VERSION := 0.6
LIBDE265_URL := https://github.com/strukturag/libde265/releases/download/v$(LIBDE265_VERSION)/libde265-$(LIBDE265_VERSION).tar.gz

$(TARBALLS)/libde265-$(LIBDE265_VERSION).tar.gz:
	$(call download,$(LIBDE265_URL))

.sum-libde265: libde265-$(LIBDE265_VERSION).tar.gz
	$(warning $@ not implemented)
	touch $@

libde265: libde265-$(LIBDE265_VERSION).tar.gz .sum-libde265
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.libde265: libde265
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) --disable-dec265 --disable-sherlock265
	cd $< && $(MAKE) install
	touch $@
