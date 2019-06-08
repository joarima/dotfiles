
typeset -U path cdpath fpath manpath

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/X11:/usr/texbin:/Applications/CMake\ 2.8-8.app/Contents/bin:/Applications/Xcode.app/Contents/Developer/usr:/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/local/texlive/2012/bin/x86_64-darwin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/Cellar:$PATH

export MANPATH=/usr/local/share/man:/usr/X11/share/man:/usr/local/texlive/2012/man:$MANPATH

#PKG_CONFIG_PATH=$usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
#export PKG_CONFIG_PATH
#export PKG_CONFIG_PATH=/usr/local/Cellar/pkg-config/0.27.1/bin/pkgconfig:${PKG_CONFIG_PATH}
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/Cellar/pkg-config/0.27.1/bin/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
#export PKG_CONFIG_PATH=/usr/local/Cellar/opencv/2.4.3/lib/pkgconfig

DYLD_FALLBACK_LIBRARY_PATH=$/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH
export INCLUDE_PATH=/usr/local/include:$INCLUDE_PATH
