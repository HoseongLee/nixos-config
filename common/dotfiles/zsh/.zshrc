if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ $- != *i* ]] && return

eval "$(direnv hook zsh)"

rebuild () { sudo nixos-rebuild --flake .#"$1" switch }

alias ls='eza -l --color=always --group-directories-first'
alias lsa='eza -al --color=always --group-directories-first'

alias CS447='ssh root@172.10.5.148'
alias CS524='ssh student@172.10.9.55'

alias mv=mv -i
alias cp=cp -i
alias rm=rm -i

autoload -U compinit; compinit
zstyle ':completion:*' menu select

_comp_options+=(globdots)

source $XDG_CONFIG_HOME/zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
source $XDG_CONFIG_HOME/zsh/.p10k.zsh
