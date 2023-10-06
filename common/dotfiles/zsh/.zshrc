if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ $- != *i* ]] && return

rebuild () { sudo nixos-rebuild --flake .#"$1" switch }

alias ls='exa -l --color=always --group-directories-first'
alias lsa='exa -al --color=always --group-directories-first'

alias mv=mv -i
alias cp=cp -i
alias rm=rm -i

alias shell='nix-shell shell.nix --command zsh'

autoload -U compinit; compinit
zstyle ':completion:*' menu select

_comp_options+=(globdots)

source $XDG_CONFIG_HOME/zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
source $XDG_CONFIG_HOME/zsh/.p10k.zsh
