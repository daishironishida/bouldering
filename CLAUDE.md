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

## コード生成

モデルを変更した場合は再実行が必要：

```bash
dart run build_runner build --delete-conflicting-outputs
```
