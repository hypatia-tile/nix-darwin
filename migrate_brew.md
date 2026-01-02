# tools to be migrated from brew to Nix

## brew packages

- [ ] ack
- [ ] adwaita-icon-theme
- [ ] aom
- [ ] arduino-cli
- [ ] asciidoctor
- [ ] at-spi2-core
- [ ] autoconf
- [ ] automake
- [ ] azure-cli
- [ ] bash
- [x] bat
- [ ] bats-core
- [ ] berkeley-db@5
- [ ] brotli
- [ ] ca-certificates
- [ ] cairo
- [ ] capstone
- [ ] certifi
- [ ] cmake
- [ ] coreutils
- [ ] cppcheck
- [ ] cunit
- [ ] dav1d
- [ ] dbus
- [ ] deno
- [ ] desktop-file-utils
- [ ] direnv
- [ ] docker-compose
- [ ] doxygen
- [ ] dtc
- [ ] elm
- [ ] fd
- [ ] fontconfig
- [ ] freetype
- [ ] fribidi
- [ ] gcc
- [ ] gd
- [ ] gdk-pixbuf
- [ ] gettext
- [ ] gh
- [ ] ghcup
- [ ] ghostscript
- [ ] giflib
- [ ] girara
- [ ] git
- [ ] git-lfs
- [ ] glew
- [ ] glfw
- [ ] glib
- [ ] gmp
- [ ] gnupg
- [ ] gnutls
- [ ] go
- [ ] gpgme
- [ ] gpgmepp
- [ ] gradle
- [ ] graphite2
- [ ] graphviz
- [ ] gsettings-desktop-schemas
- [ ] gtk+3
- [ ] gtk-mac-integration
- [ ] gts
- [ ] harfbuzz
- [ ] hicolor-icon-theme
- [ ] highway
- [ ] icu4c@76
- [ ] icu4c@77
- [ ] imagemagick
- [ ] imath
- [ ] intltool
- [ ] iproute2mac
- [ ] isl
- [ ] jasper
- [ ] jbig2dec
- [ ] jpeg-turbo
- [ ] jpeg-xl
- [ ] json-c
- [ ] json-glib
- [ ] kotlin
- [ ] lazygit
- [ ] leptonica
- [ ] libarchive
- [ ] libassuan
- [ ] libavif
- [ ] libb2
- [ ] libde265
- [ ] libdeflate
- [ ] libepoxy
- [ ] libevent
- [ ] libgcrypt
- [ ] libgit2
- [ ] libgpg-error
- [ ] libheif
- [ ] libidn
- [ ] libidn2
- [ ] libksba
- [ ] liblqr
- [ ] libmagic
- [ ] libmpc
- [ ] libnghttp2
- [ ] libnotify
- [ ] libomp
- [ ] libpng
- [ ] libpthread-stubs
- [ ] libraw
- [ ] librsvg
- [ ] libslirp
- [ ] libsodium
- [ ] libssh
- [ ] libssh2
- [ ] libtasn1
- [ ] libtiff
- [ ] libtool
- [ ] libunistring
- [ ] libusb
- [ ] libvmaf
- [ ] libx11
- [ ] libxau
- [ ] libxcb
- [ ] libxdmcp
- [ ] libxext
- [ ] libxfixes
- [ ] libxft
- [ ] libxi
- [ ] libxrender
- [ ] libxtst
- [ ] libyaml
- [ ] libzip
- [ ] little-cms2
- [ ] llvm
- [ ] lua
- [ ] lua-language-server
- [ ] luarocks
- [ ] lz4
- [ ] lzo
- [ ] m4
- [ ] make
- [ ] maven
- [ ] meson
- [ ] mpdecimal
- [ ] mpfr
- [ ] ncurses
- [ ] netpbm
- [ ] nettle
- [ ] ninja
- [ ] nodebrew
- [ ] npth
- [ ] nspr
- [ ] nss
- [ ] oniguruma
- [ ] openexr
- [ ] openjdk
- [ ] openjdk@17
- [ ] openjdk@21
- [ ] openjpeg
- [ ] openjph
- [ ] openssl@3
- [ ] p11-kit
- [ ] pandoc
- [ ] pango
- [ ] pcre
- [ ] pcre2
- [ ] pinentry
- [ ] pipx
- [ ] pixman
- [ ] pkgconf
- [ ] poppler
- [ ] python-packaging
- [ ] python@3.12
- [ ] python@3.13
- [ ] python@3.14
- [ ] qemu
- [ ] readline
- [ ] ripgrep
- [ ] ruby
- [ ] rust
- [ ] rustup
- [ ] shared-mime-info
- [ ] snappy
- [ ] sphinx-doc
- [ ] sqlite
- [ ] swagger-codegen
- [ ] swi-prolog
- [ ] tesseract
- [ ] tinyxml2
- [ ] tmux
- [ ] tree
- [ ] unbound
- [ ] unixodbc
- [ ] utf8proc
- [ ] vde
- [ ] webp
- [ ] wget
- [ ] x265
- [ ] xorgproto
- [ ] xz
- [ ] z3
- [ ] zathura
- [ ] zstd
- [ ] alacritty
- [ ] android-commandlinetools
- [ ] anki
- [ ] aws-vault
- [ ] aws-vault-binary
- [ ] basictex
- [ ] claude-code
- [ ] cleanmymac
- [ ] docker
- [ ] docker-desktop
- [ ] dotnet-sdk
- [ ] github
- [ ] intellij-idea
- [ ] iterm2
- [ ] kitty
- [ ] microsoft-auto-update
- [ ] microsoft-office
- [ ] microsoft-teams
- [ ] powershell
- [ ] skim
- [ ] vagrant
- [ ] visual-studio-code
- [ ] warp
- [ ] wireshark
- [ ] wireshark-app
- [ ] xquartz

## PATH before migration

/nix/var/nix/profiles/default/bin
/run/current-system/sw/bin
/Users/kazukishinohara/script
/Users/kazukishinohara/Library/Android/sdk/platform-tools
/Users/kazukishinohara/Library/Android/sdk/tools/bin
/Users/kazukishinohara/.nix-profile/bin
/Users/kazukishinohara/.ghcup/bin
/Users/kazukishinohara/.nodebrew/current/bin
/Users/kazukishinohara/.local/bin
/Users/kazukishinohara/.elan/bin
/opt/homebrew/opt/rustup/bin
/opt/homebrew/opt/ruby/bin
/opt/homebrew/opt/openjdk/bin
/opt/homebrew/opt/make/libexec/gnubin
/opt/homebrew/opt/llvm/bin
/opt/homebrew/bin
/opt/homebrew/sbin
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin

