# mise, and the tools it manages (starship, gh, ghq, gwq, fzf), live under ~/.local/bin.
# macOS zsh doesn't add this to PATH by default, so it must be set explicitly here.
export PATH="$HOME/.local/bin:$PATH"

# starship's default config path is ~/.config/starship.toml, not ~/.config/starship/config.toml.
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
