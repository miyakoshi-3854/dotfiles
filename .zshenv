# CLI tools (mise, starship, gh, ghq, gwq, fzf) are installed by Homebrew.
# The brew prefix differs per platform: Apple Silicon, Intel macOS, Linux.
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew" ]; then
    eval "$("$brew" shellenv)"
    break
  fi
done
unset brew

# User-local binaries (e.g. uv tool installs) live under ~/.local/bin.
# macOS zsh doesn't add this to PATH by default, so it must be set explicitly here.
export PATH="$HOME/.local/bin:$PATH"

# starship's default config path is ~/.config/starship.toml, not ~/.config/starship/config.toml.
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
