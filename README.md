# dotfiles

Personal dotfiles for WSL2 / macOS.

## Directory Structure

```
dotfiles/
├── .claude/
│   └── CLAUDE.md
├── .codex/
│   └── AGENTS.md -> ../.claude/CLAUDE.md
├── .config/
│   ├── gh/config.yml
│   ├── ghostty/
│   │   ├── config
│   │   └── themes/OneHunter-Material
│   ├── git/config
│   ├── gwq/config.toml
│   ├── karabiner/karabiner.json
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
7. Install [Codex CLI](https://github.com/openai/codex) via the official installer (offers "Update now" at startup; `~/.local/bin/codex`)
8. Symlink config files to `$HOME`
9. Prompt for your Git `user.name` / `user.email` and save them to `~/.config/git/config.local` (untracked, included from `.config/git/config`)
10. Install language runtimes via `mise install`

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
| [ast-grep](https://ast-grep.github.io) | Structural code search and rewrite |
| [actionlint](https://github.com/rhysd/actionlint) | GitHub Actions workflow linter |
| [shellcheck](https://www.shellcheck.net) | Shell script linter |

### GUI apps (Brewfile, macOS only)

Installed as Homebrew casks. All apps update themselves, so `brew upgrade` skips them (use `brew upgrade --greedy` to force).

| App | Description |
|-----|-------------|
| [Cursor](https://cursor.com) | AI code editor |
| [Ghostty](https://ghostty.org) | Terminal emulator (One Hunter Material colors, matching Cursor's terminal) |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org) | Keyboard remapper (Caps Lock → F18 for input source toggle, left Control + IJKL → arrow keys) |
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

- `.claude/CLAUDE.md` is linked to `~/.claude/CLAUDE.md` (user-level instructions for Claude Code): it tells Claude to use the tools installed here (ghq, gwq, gh, ast-grep, etc.).
- `.codex/AGENTS.md` is a symlink to `.claude/CLAUDE.md` and is linked to `~/.codex/AGENTS.md`, so Codex CLI gets the same instructions. Edit `.claude/CLAUDE.md`.
- `wn` (`gwq-fzf`) creates a new worktree and automatically copies all `.env*` files (e.g. `.env`, `.env.local`; `*.example` and `node_modules` are skipped) from the original worktree into it. Be aware that this includes any secrets stored in those files.
- `.config/karabiner` is linked as a whole directory (macOS only): Karabiner-Elements saves `karabiner.json` by replacing the file, which would break a file symlink. Changes made in the Karabiner GUI show up as diffs in this repo.
- After installing Karabiner-Elements, allow its background items, driver extension, and Input Monitoring in System Settings. To make Caps Lock toggle the input source, set System Settings → Keyboard → Keyboard Shortcuts → Input Sources → "Select the previous input source" to F18 (press Caps Lock).
