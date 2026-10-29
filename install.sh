#!/bin/zsh
# Mac setup: symlinks configs from this repo into place. Safe to re-run.
set -e
DIR="${0:A:h}"
CFG="$HOME/.config"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d%H%M%S)"

link() {  # link <repo path> <target>
  local src="$DIR/$1" dst="$2"
  mkdir -p "${dst:h}"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mkdir -p "$BACKUP"; mv "$dst" "$BACKUP/"; echo "   backed up ${dst:t} -> $BACKUP"
  fi
  ln -sfn "$src" "$dst"
  echo "   $dst -> $1"
}

echo "==> Homebrew packages"
command -v brew >/dev/null || { echo "Install Homebrew first: https://brew.sh"; exit 1; }
brew bundle --file="$DIR/Brewfile"

echo "==> Configs"
link nvim                          "$CFG/nvim"
link starship/starship.toml        "$CFG/starship.toml"
link starship/starship-light.toml  "$CFG/starship-light.toml"
link zsh/zshrc.zsh                 "$CFG/zsh/zshrc.zsh"
link zsh/koda-mode.zsh             "$CFG/zsh/koda-mode.zsh"
link iterm2/Koda.json              "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Koda.json"

echo "==> ~/.zshrc"
touch "$HOME/.zshrc"
cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d%H%M%S)"
# remove the older inline setup now handled by zsh/zshrc.zsh
sed -i '' '/# >>> dev-setup >>>/,/# <<< dev-setup <<</d' "$HOME/.zshrc"
sed -i '' '/^# Koda light\/dark switching$/d;/koda-mode.zsh/d' "$HOME/.zshrc"
grep -q 'zsh/zshrc.zsh' "$HOME/.zshrc" 2>/dev/null || \
  printf '\n# dotfiles\nsource "$HOME/.config/zsh/zshrc.zsh"\n' >> "$HOME/.zshrc"

echo "==> Spotify (spicetify)"
if command -v spicetify >/dev/null; then
  spicetify >/dev/null 2>&1 || true
  link spicetify/Koda "$CFG/spicetify/Themes/Koda"
  spicetify config current_theme Koda color_scheme dark >/dev/null
  spicetify apply >/dev/null 2>&1 || spicetify backup apply || true
fi

echo "==> VS Code"
command -v code >/dev/null && code --install-extension "$DIR/vscode/koda-theme.vsix" --force || \
  echo "   'code' not found, install vscode/koda-theme.vsix manually"

echo "==> iTerm2 default profile -> Koda"
KODA_GUID="6B0DA0E4-0C0D-4A11-9C0D-C0DA00000001"
if pgrep -xq iTerm2; then
  nohup zsh -c "while pgrep -xq iTerm2; do sleep 2; done; defaults write com.googlecode.iterm2 'Default Bookmark Guid' -string $KODA_GUID" >/dev/null 2>&1 &!
  echo "   becomes default after you quit iTerm2 once (Cmd+Q)"
else
  defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$KODA_GUID"
fi

echo "Done. Open a new terminal."
