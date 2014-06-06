# libde265

LIBDE265_VERSION := 0.7
LIBDE265_URL := https://github.com/strukturag/libde265/releases/download/v$(LIBDE265_VERSION)/libde265-$(LIBDE265_VERSION).tar.gz

PKGS += libde265
ifeq ($(call need_pkg,"libde265 >= 0.7"),)
PKGS_FOUND += libde265
endif

$(TARBALLS)/libde265-$(LIBDE265_VERSION).tar.gz:
	$(call download,$(LIBDE265_URL))

.sum-libde265: libde265-$(LIBDE265_VERSION).tar.gz

libde265: libde265-$(LIBDE265_VERSION).tar.gz .sum-libde265
	$(UNPACK)
	$(APPLY) $(SRC)/libde265/0001-add-stdc++-to-pkg-config.diff
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.libde265: libde265
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) -O3" CXXFLAGS="$(CXXFLAGS) -O3" ./configure $(HOSTCONF) --disable-dec265 --disable-sherlock265
	cd $< && $(MAKE) install
	touch $@
