#!/usr/bin/env sh
#
# Defines runtime environment
#
export LD_LIBRARY_PATH=/usr/lib/

export LOCAL_ETC="${HOME}/.local/etc"
export LOCAL_BIN="${HOME}/.local/bin"
export LOCAL_LIB="${HOME}/.local/lib"
export LOCAL_SRC="${HOME}/.local/src"
export LOCAL_VAR="${HOME}/.local/var"

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="${HOME}/.local/run"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

export SVDIR="${LOCAL_VAR}/service"
export SVROOT="${LOCAL_ETC}/sv"
export PERL_HOME="${LOCAL_VAR}/perl"

command -v perl >/dev/null && [ -e "${PERL_HOME}/lib/perl5/local/lib.pm" ] && {
  eval "$(perl -I"${PERL_HOME}/lib/perl5" -Mlocal::lib="${PERL_HOME}")"
}

export GOPATH="${LOCAL_SRC}/go"

export ARCH="x86_64"
export ARCHFLAGS="-arch x86_64"

export LANG="en_GB.UTF-8"
export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export PERLDOC_PAGER="more"
export LESS="-g -i -M -R -S -w -K -z-4 --lesskey-file=${XDG_CONFIG_HOME}/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/.lesshst"
export GREP_COLORS="mt=30;43"

export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export NO_AT_BRIDGE=1
export QT_STYLE_OVERRIDE="GTK+"

[ -r "${LOCAL_ETC}/xorg/xenvironment" ] && . "${LOCAL_ETC}/xorg/xenvironment"

[ "$TERM" = "xterm" ] && {
  export TERM="xterm-256color"
}

# Update PATH
path_prepend() {
  case ":$PATH:" in
    *":$1:"*) return ;; # already added
    *) PATH="$1:$PATH";;
  esac
}

[ -d "$LOCAL_LIB" ] && {
  for dir in "$LOCAL_LIB"/* "$LOCAL_LIB"; do
    [ -d "$dir" ] && path_prepend "$dir"
    [ -d "$dir/contrib" ] && path_prepend "$dir/contrib"
  done
}

[ -d "$LOCAL_BIN" ] && {
  for dir in "$LOCAL_BIN"/* "$LOCAL_BIN"; do
    [ -d "$dir" ] && path_prepend "$dir"
  done
}

unset dir
unset -f path_prepend

export PATH="$PATH:/usr/local/sbin:/usr/local/bin"
export MANPATH="$MANPATH:/usr/local/share/man:/usr/share/man"
