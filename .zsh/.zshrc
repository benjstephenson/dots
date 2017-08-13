#
# Environment for interactive sessions
#

if [[ "$ZSH_DEBUG" ]]; then
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>/tmp/zsh_startup.$$
  setopt xtrace prompt_subst
fi

fpath=(
  $ZDOTDIR/functions
  $ZDOTDIR/compdef
  $fpath
)

for rc in $ZDOTDIR/zshrc.d/*; do
  source $rc
done
unset rc

prompt sorin

if [[ "$ZSH_DEBUG" ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/bste/.sdkman"
[[ -s "/home/bste/.sdkman/bin/sdkman-init.sh" ]] && source "/home/bste/.sdkman/bin/sdkman-init.sh"
#source "/home/bste/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME=$SDKMAN_CANDIDATES_DIR/java/current
# vim:fdm=marker
