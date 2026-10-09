#!/bin/bash

set -euo pipefail

OS="$(uname -s)"

# ── Ensure git (needed to clone) ──────────────────────────────────────────────
if ! command -v git &>/dev/null; then
  if [ "$OS" = "Linux" ]; then
    echo "Installing git..."
    sudo apt-get update
    sudo apt-get install -y git
  else
    echo "git not found. Run 'xcode-select --install' first." >&2
    exit 1
  fi
fi

# ── Clone dotfiles ────────────────────────────────────────────────────────────
DOTFILE_DIR="$HOME/ghq/github.com/miyakoshi-3854/dotfiles"

if [ ! -d "$DOTFILE_DIR" ]; then
  echo "Cloning dotfiles..."
  mkdir -p "$(dirname "$DOTFILE_DIR")"
  git clone "https://github.com/miyakoshi-3854/dotfiles.git" "$DOTFILE_DIR"
else
  echo "dotfiles: already cloned"
fi

cd "$DOTFILE_DIR"

# ── apt packages (Linux) ──────────────────────────────────────────────────────
if [ "$OS" = "Linux" ]; then
  echo "Installing apt packages..."
  sudo apt-get update
  grep -vE '^\s*(#|$)' apt.txt | xargs sudo apt-get install -y
fi

# ── Install Homebrew ──────────────────────────────────────────────────────────
load_brew() {
  local brew
  for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$brew" ]; then
      eval "$("$brew" shellenv)"
      return
    fi
  done
}

load_brew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_brew
else
  echo "Homebrew: already installed"
fi

# ── brew bundle ───────────────────────────────────────────────────────────────
echo "Running brew bundle..."
brew bundle --file="$DOTFILE_DIR/Brewfile"

# ── Symlinks ──────────────────────────────────────────────────────────────────
link() {
  local src="$DOTFILE_DIR/$1"
  local dest="$HOME/$1"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    echo "backup: $backup"
  fi
  ln -sfn "$src" "$dest"
  echo "linked: $dest"
}

link .zshenv
link .zshrc
link .config/git/config
link .config/gh/config.yml
link .config/mise/config.toml
link .config/gwq/config.toml
link .config/starship/config.toml

# ── Git identity ──────────────────────────────────────────────────────────────
GIT_LOCAL_CONFIG="$HOME/.config/git/config.local"
if [ ! -e "$GIT_LOCAL_CONFIG" ]; then
  echo ""
  read -rp "Git user.name: " git_user_name
  read -rp "Git user.email: " git_user_email
  cat >"$GIT_LOCAL_CONFIG" <<EOF
[user]
    name = $git_user_name
    email = $git_user_email
EOF
  echo "created: $GIT_LOCAL_CONFIG"
else
  echo "Git identity: already configured"
fi

# ── mise install ──────────────────────────────────────────────────────────────
echo "Running mise install..."
mise install

echo ""
echo "Done!"
