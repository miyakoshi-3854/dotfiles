# dotfiles

Personal dotfiles for WSL2 / macOS.

## Directory Structure

```
dotfiles/
├── .config/
│   ├── gh/config.yml
│   ├── ghostty/
│   │   ├── config
│   │   └── themes/OneHunter-Material
│   ├── git/config
│   ├── gwq/config.toml
│   ├── mise/config.toml
│   └── starship/config.toml
├── .zshenv
├── .zshrc
├── Brewfile
├── apt.txt
└── install.sh
```

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/miyakoshi-3854/dotfiles/main/install.sh | bash && source ~/.zshrc
```

This single command will:

1. Clone this repo (installs `git` via apt on Linux if missing)
2. (Linux only) Install base packages listed in `apt.txt`
3. Install [Homebrew](https://brew.sh) (if not already installed)
4. Install CLI tools (and GUI apps on macOS) via `brew bundle` (`Brewfile`)
5. (macOS only) Start `brew autoupdate` to upgrade Homebrew packages daily
6. Install [Claude Code](https://claude.com/claude-code) via the official installer (auto-updates; `~/.local/bin/claude`)
7. Symlink config files to `$HOME`
8. Prompt for your Git `user.name` / `user.email` and save them to `~/.config/git/config.local` (untracked, included from `.config/git/config`)
9. Install language runtimes via `mise install`

### Package management

| File | Manager | Scope |
|------|---------|-------|
| `apt.txt` | apt | Base packages for Linux (build tools, zsh, etc.) |
| `Brewfile` | Homebrew | CLI tools (shared by macOS and Linux), GUI apps (macOS only) |
| `.config/mise/config.toml` | mise | Language runtimes |

### CLI tools (Brewfile)

| Tool | Description |
|------|-------------|
| [git](https://git-scm.com) | Version control |
| [mise](https://mise.jdx.dev) | Language runtime manager |
| [starship](https://starship.rs) | Shell prompt |
| [gh](https://cli.github.com) | GitHub CLI |
| [ghq](https://github.com/x-motemen/ghq) | Git repository manager |
| [gwq](https://github.com/d-kuro/gwq) | Git worktree manager |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) | Directory listing |

### GUI apps (Brewfile, macOS only)

Installed as Homebrew casks. All apps update themselves, so `brew upgrade` skips them (use `brew upgrade --greedy` to force).

| App | Description |
|-----|-------------|
| [Ghostty](https://ghostty.org) | Terminal emulator (One Hunter Material colors, matching Cursor's terminal) |
| [Zed](https://zed.dev) | Code editor |
| [Zen](https://zen-browser.app) | Web browser |

### Languages (mise)

| Tool | Version |
|------|---------|
| [Node.js](https://nodejs.org) | LTS |
| [TypeScript](https://www.typescriptlang.org) | latest |
| [pnpm](https://pnpm.io) | latest |
| [Python](https://www.python.org) | latest |
| [uv](https://docs.astral.sh/uv/) | latest |

C compilers (`gcc`, `make`) come from `build-essential` in `apt.txt` on Linux, and from Xcode Command Line Tools on macOS.

## Notes

- `wc` (`gwq-fzf`) creates a new worktree and automatically copies all `.env` files from the original worktree into it. Be aware that this includes any secrets stored in those files.
