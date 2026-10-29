# Koda: follow macOS light/dark appearance (Starship + autosuggestion color)
_koda_mode() {
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    export STARSHIP_CONFIG="$HOME/.config/starship.toml"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5A5A5A'
  else
    export STARSHIP_CONFIG="$HOME/.config/starship-light.toml"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#A0A0A0'
  fi
}
_koda_mode
precmd_functions+=(_koda_mode)

# Switch the Spotify theme: spotify-theme light | dark
spotify-theme() {
  spicetify config color_scheme "${1:-dark}" && spicetify apply
}
