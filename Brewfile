tap "d-kuro/tap"

brew "git"
brew "mise"
brew "starship"
brew "gh"
brew "ghq"
brew "d-kuro/tap/gwq", trusted: true
brew "fzf"
brew "tree"
brew "poppler"
brew "ffmpeg"
brew "awscli"
brew "libpq" # keg-only: psql is put on PATH by mise's [env] _.path
brew "colima", restart_service: :changed
brew "docker"
brew "docker-compose" # needs "cliPluginsExtraDirs" in ~/.docker/config.json

# GUI apps (macOS only; casks are not available on Linux)
# All apps update themselves, so `brew upgrade` skips them.
if OS.mac?
  tap "homebrew/autoupdate" # `brew autoupdate` (started by install.sh)

  cask "session-manager-plugin"
  cask "cursor"
  cask "ghostty"
  cask "zed"
  cask "zen"
end
