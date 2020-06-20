# Copyright (c) 2020, Germán Fuentes Capella

SHELL := zsh
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

.PHONY: help init clean serve spell

help:
> @grep '^.PHONY: .*' Makefile | cut -d ":" -f 2 | sed -e 's/^[ \t]*//'

init:
> @$(MAKE) -f Makefile clean
> mkdir -p themes
> if [ ! -d themes/hugo-theme-console ]; then cd themes ; git clone https://github.com/mrmierzejewski/hugo-theme-console.git hugo-theme-console; fi
> if [ "$$(ls themes/hugo-theme-console/)" = "" ]; then git submodule init && git submodule update; fi

clean:
> if [ ! -d public ]; then rm -Rf public; fi

serve:
> hugo server

spell:
> find content/en/post -name index.md -exec aspell --personal=./.dictionary.txt -c {} \;

new-post:
> hugo new --kind post post/$(POST)

img-resize:
> convert $(IMGIN) -resize 50x50% $(IMGOUT)

img-light:
> convert $(IMGIN) -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB $(IMGOUT)
