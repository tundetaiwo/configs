# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/opt/homebrew/bin:$PATH"
alias vim=nvim

# Remap 'jj' to Escape in Zsh with Vim bindings
bindkey -v   # Ensure vim mode is enabled

# Function to map 'jj' to Escape
bindkey -M viins 'jj' vi-cmd-mode

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias ls='ls -la'
alias cls='clear'
plugins=(web-search)
