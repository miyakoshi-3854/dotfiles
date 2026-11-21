tap "d-kuro/tap"

brew "git"
brew "mise"
brew "starship"
brew "gh"
brew "ghq"
brew "d-kuro/tap/gwq", trusted: true
brew "fzf"
brew "tree"
brew "ast-grep"
brew "actionlint"
brew "shellcheck"
brew "poppler"
brew "ffmpeg"
brew "awscli"
brew "libpq" # keg-only: psql is put on PATH by mise's [env] _.path

if OS.mac?
  tap "homebrew/autoupdate" # `brew autoupdate` (started by install.sh)

  # Docker runs in a colima VM on macOS.
  # On Linux (WSL2), Docker Engine is installed natively from Docker's apt repository.
  brew "colima", restart_service: :changed
  brew "docker"
  brew "docker-compose" # needs "cliPluginsExtraDirs" in ~/.docker/config.json

  # GUI apps (casks are not available on Linux)
  # All apps update themselves, so `brew upgrade` skips them.
  cask "session-manager-plugin"
  cask "cursor"
  cask "ghostty"
  cask "karabiner-elements" # its pkg installer asks for the sudo password
  cask "zed"
  cask "zen"
end
