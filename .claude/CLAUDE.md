# 開発環境で使うツール

ここに書いたツールはすべてインストール済み。汎用的なやり方（find, git clone, git worktree add, WebFetch など）より優先して使う。

## 対話モードで止まる操作は使わない

fzf やシェルを起動して入力を待つと、Claude からは操作できずに止まる。

- `gwq add -i`、`gwq add -s`、`gwq cd`（`cd.launch_shell = true` なのでシェルが起動する）
- パターンなし、または複数に一致するパターンでの `gwq get` / `gwq remove`（fzf が開く）
- エイリアス `r` / `wn`（fzf と read を使う人間向けの関数）

## リポジトリ: ghq

- root は `~/ghq`。パスは `~/ghq/github.com/<owner>/<repo>`
- リポジトリを探すときは `ghq list -p | grep <name>`（find で探さない）
- clone は `ghq get <owner>/<repo>`（git clone は使わない）

## worktree: gwq

`git worktree add` や Claude Code 組み込みの worktree は使わず、gwq で作る。

- 作成: リポジトリの中で `gwq add -b <branch>`
  - 配置は `~/ghq/github.com/<owner>/<repo>=<branch>`（ブランチ名の `/` と `:` は `-` になる）
  - 作成後、元の worktree から `.env*` ファイル（`*.example` を除く、`node_modules` 配下は除く）を同じ相対パスにコピーする。人間用の `wn` コマンドが同じことをしているため、ないと動かない
- 一覧: `gwq list`（全リポジトリ分は `gwq list -g`、機械的に読むときは `--json`）
- パス取得: `git worktree list --porcelain` から解決する（`gwq get` は複数一致すると fzf が開く）
- 削除: 一意に一致するパターンを指定して `gwq remove <pattern>`。先に `-d`（dry-run）で対象を確認する。ブランチも消すときは `-b`

## GitHub: gh

GitHub 上の情報は gh で取る。github.com を WebFetch で読まない。

- PR: `gh pr view` / `gh pr diff` / `gh pr checks`
- CI の失敗: `gh run view <id> --log-failed`
- レビューコメントなど上記で取れないもの: `gh api`

## コード検索・書き換え: ast-grep

関数呼び出し、import、型など、コードの構造に沿った検索や一括置換は正規表現ではなく ast-grep で行う。

- 検索: `ast-grep run -p '<pattern>' -l <lang> [path]`
- 置換: `ast-grep run -p '<pattern>' -r '<rewrite>' -l <lang> [path]` で差分を確認してから `-U` で適用
- `$NAME` が1ノード、`$$$ARGS` が複数ノードに一致する

## 検証: 編集したら実行する

- `.github/workflows/*.yml` を編集したら `actionlint`
- シェルスクリプトを書いた・編集したら `shellcheck <file>`

## タスク実行: just / mise

ビルドやテストの方法を探すときは、まずプロジェクトに定義されたタスクを見る。

- `justfile` があれば `just --list` で確認して `just <recipe>` で実行
- mise のタスクは `mise tasks` で確認して `mise run <task>` で実行
- どちらもなければ `package.json` の scripts など
