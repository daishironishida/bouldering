# 開発ガイド

## アプリの起動

### Web（推奨）

```bash
flutter run -d web-server --web-port 8080
```

起動後、Chrome で `http://localhost:8080` を開く。
`flutter run -d chrome` は Flutter が専用の一時プロフィールで Chrome を別インスタンスとして起動するため使わない。

### モバイル

```bash
flutter run -d ios      # iOSシミュレータ
flutter run -d android  # Androidエミュレータ
```

## 並列インスタンスでの開発

複数の Claude Code インスタンスを同時に起動する場合はポートが衝突する。
worktree ごとに `.claude/launch.json` のポートを変えること：

| インスタンス | ポート |
|---|---|
| メイン | 8080 |
| worktree 1 | 8081 |
| worktree 2 | 8082 |

Preview MCP を使わない場合は `--web-port` を省略すれば Flutter が自動で空きポートを選ぶ。

## UI 確認

Flutter web は `preview_screenshot` では黒画面になる。
**Claude in Chrome** MCP 拡張機能を使って `http://localhost:<port>` を直接 Chrome で開いて確認すること。

### Chrome 拡張機能の権限設定

`mcp__Claude_in_Chrome__navigate` などのツールは `.claude/settings.local.json` の allow リストに追加しないとブロックされる。
プロジェクトルートの `.claude/settings.local.json` と各 worktree の `.claude/settings.local.json` の**両方**に以下を追加すること：

```json
"mcp__Claude_in_Chrome__navigate",
"mcp__Claude_in_Chrome__javascript_tool",
"mcp__Claude_in_Chrome__tabs_create_mcp",
"mcp__Claude_in_Chrome__find",
"mcp__Claude_in_Chrome__select_browser"
```

`mcp__Claude_in_Chrome__computer` と `mcp__Claude_in_Chrome__browser_batch` はすでに追加済み。
`computer` ツールは `browser_batch` 内ではなく単体で呼び出すこと（batch 内だと localhost で screenshot がブロックされる場合がある）。

## コード生成

モデルを変更した場合は再実行が必要：

```bash
dart run build_runner build --delete-conflicting-outputs
```
