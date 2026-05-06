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

## コード生成

モデルを変更した場合は再実行が必要：

```bash
dart run build_runner build --delete-conflicting-outputs
```
