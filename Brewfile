tap "d-kuro/tap"

brew "git"
brew "mise"
brew "starship"
brew "gh"
brew "ghq"
brew "d-kuro/tap/gwq", trusted: true
brew "fzf"
brew "tree"

# GUI apps (macOS only; casks are not available on Linux)
# All apps update themselves, so `brew upgrade` skips them.
if OS.mac?
  tap "homebrew/autoupdate" # `brew autoupdate` (started by install.sh)

  cask "ghostty"
  cask "zed"
  cask "zen"
end
