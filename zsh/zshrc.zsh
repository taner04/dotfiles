# Sourced from ~/.zshrc:  source "$HOME/.config/zsh/zshrc.zsh"
BREW_PREFIX=$(brew --prefix)

# Completions
FPATH=$BREW_PREFIX/share/zsh-completions:$FPATH
autoload -Uz compinit && compinit

# Tools
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Aliases
alias ls='eza --icons --git'
alias ll='eza -la --icons --git'
alias cat='bat --paging=never'
alias lg='lazygit'

# Light/dark switching (Starship, autosuggestion color, spotify-theme)
source "$HOME/.config/zsh/koda-mode.zsh"

# Plugins (syntax highlighting must stay last)
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
