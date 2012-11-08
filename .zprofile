
typeset -U path cdpath fpath manpath

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/texbin:/Applications/CMake\ 2.8-8.app/Contents/bin:/Applications/Xcode.app/Contents/Developer/usr:/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/local/texlive/2012/bin/x86_64-darwin:/Applications/Xcode.app/Contents/Developer/usr/binbin:$PATH

export MANPATH=/usr/local/share/man:/usr/X11/share/man:/usr/local/texlive/2012/man:$MANPATH

#PKG_CONFIG_PATH=$usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
#export PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}

DYLD_FALLBACK_LIBRARY_PATH=$/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH
export INCLUDE_PATH=/usr/local/include/opencv:/usr/local/include/opencv2:$INCLUDE_PATH
