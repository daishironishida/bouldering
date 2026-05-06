# ボルダリング進捗管理アプリ

クライミングジムごとに課題のクリア状況を管理するFlutterアプリ。
ローカルストレージのみで動作し、iOS・Android・Webブラウザに対応。

## 主な機能

- ジムの追加・削除
- ジムごとにグレード（級）と課題数をカスタマイズ
- グリッド表示で課題のクリア状況を一覧確認
- クリア記録（日時）の追加・編集・削除
- ホールド替え履歴の管理（世代管理）

## 使用パッケージ

| パッケージ | 用途 |
|---|---|
| [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | 状態管理 |
| [go_router](https://pub.dev/packages/go_router) | 画面遷移（URL ベース、Web 対応） |
| [hive](https://pub.dev/packages/hive) / [hive_flutter](https://pub.dev/packages/hive_flutter) | ローカルストレージ（JSON 文字列として保存） |
| [freezed_annotation](https://pub.dev/packages/freezed_annotation) / [freezed](https://pub.dev/packages/freezed) | イミュータブルなデータモデル生成 |
| [json_annotation](https://pub.dev/packages/json_annotation) / [json_serializable](https://pub.dev/packages/json_serializable) | JSON シリアライズ生成 |
| [uuid](https://pub.dev/packages/uuid) | ID 生成 |
| [build_runner](https://pub.dev/packages/build_runner) | コード生成実行ツール |

## 起動方法

### 前提条件

- Flutter SDK 3.x 以上がインストール済みであること

### セットアップ

```bash
# 依存パッケージのインストール
flutter pub get

# コード生成（初回・モデル変更時）
dart run build_runner build --delete-conflicting-outputs
```

### 実行

```bash
# Webブラウザ
flutter run -d chrome --web-port 8080

# iOSシミュレータ
flutter run -d ios

# Androidエミュレータ
flutter run -d android
```
