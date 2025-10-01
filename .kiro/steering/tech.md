# ModularAuth - 技術スタック

## アーキテクチャ
ModularAuthは、Rackベースのミドルウェアアーキテクチャを採用し、独自実装のモジュールシステムとプラグインアーキテクチャを組み合わせた軽量な認証フレームワークです。

### コアアーキテクチャ
- **Rackミドルウェア**: リクエスト/レスポンスサイクルでの認証処理
- **モジュールシステム**: 認証ロジックの分離と再利用性
- **プラグインアーキテクチャ**: 機能の段階的な追加とカスタマイズ
- **設定駆動**: 宣言的な設定による柔軟な認証フロー制御
- **ゼロ依存**: 外部gemに依存しない独立した実装

## バックエンド技術

### コア依存関係
- **Ruby**: 3.1.0以上（最新の言語機能を活用）
- **Rack**: 2.0以上（ミドルウェア基盤）
- **標準ライブラリ**: 外部依存なしで標準ライブラリのみ使用

### 認証関連実装
- **JWT**: 独自実装のJSON Web Token処理
- **パスワードハッシュ**: 標準ライブラリによるハッシュ化
- **OAuth2**: 独自実装のOAuth認証フロー
- **TOTP**: 独自実装の多要素認証（TOTPベース）
- **セッション管理**: 独自実装のセッション管理システム

### データベースサポート
- **ORM非依存**: 任意のORMと統合可能
- **ActiveRecord**: Rails ORM統合（オプション）
- **Sequel**: その他のORMサポート（オプション）
- **NoSQL**: MongoDB、Redis等のサポート（オプション）

## 開発環境

### 必須ツール
- **Ruby**: 3.1.0以上
- **Bundler**: 依存関係管理
- **Rake**: ビルドタスク管理
- **Git**: バージョン管理

### 開発支援ツール
- **RSpec**: テストフレームワーク
- **RuboCop**: コード品質管理
- **IRB**: 対話的Ruby環境
- **Pry**: 高度なデバッグ環境（オプション）

### ビルド・テスト環境
- **GitHub Actions**: CI/CDパイプライン
- **AppVeyor**: Windows環境でのテスト
- **CodeClimate**: コード品質分析
- **SimpleCov**: テストカバレッジ分析

## 共通コマンド

### 開発環境セットアップ
```bash
# 依存関係のインストール
bundle install

# 開発環境のセットアップ
bin/setup

# 対話的環境の起動
bin/console
```

### テスト実行
```bash
# 全テストの実行
bundle exec rspec

# 特定のテストファイルの実行
bundle exec rspec spec/specific_test_spec.rb

# カバレッジ付きテスト実行
bundle exec rspec --format documentation
```

### コード品質チェック
```bash
# RuboCopによる静的解析
bundle exec rubocop

# 自動修正
bundle exec rubocop -a

# 特定ファイルのチェック
bundle exec rubocop lib/app.rb
```

### Gem管理
```bash
# Gemのビルド
bundle exec rake build

# ローカルインストール
bundle exec rake install

# リリース
bundle exec rake release
```

## 環境変数

### 必須設定
- `RUBY_VERSION`: 使用するRubyバージョン（3.1.0以上）

### 開発環境設定
- `RAILS_ENV`: Rails環境（development, test, production）
- `DATABASE_URL`: データベース接続URL（テスト用）

### 認証設定
- `MODULAR_AUTH_JWT_SECRET`: JWT署名用の秘密鍵
- `MODULAR_AUTH_OAUTH_CLIENT_ID`: OAuthクライアントID
- `MODULAR_AUTH_OAUTH_CLIENT_SECRET`: OAuthクライアントシークレット
- `MODULAR_AUTH_TOTP_ISSUER`: TOTP発行者名
- `MODULAR_AUTH_SESSION_SECRET`: セッション暗号化用の秘密鍵

## ポート設定

### 開発環境
- **Rails Server**: 3000（デフォルト）
- **RSpec Server**: 3001（テスト用）

### テスト環境
- **RSpec Server**: 3001（統合テスト用）
- **Mock OAuth Server**: 3002（OAuthテスト用）

## パフォーマンス要件

### メモリ使用量
- **基本動作**: 20MB以下（軽量設計）
- **複数モジュール**: 50MB以下
- **大量セッション**: 100MB以下

### レスポンス時間
- **認証処理**: 50ms以下（高速処理）
- **セッション検証**: 20ms以下
- **モジュール切り替え**: 5ms以下

### スケーラビリティ
- **同時接続**: 2000接続以上
- **セッション管理**: 20,000セッション以上
- **モジュール数**: 100種類以上
- **ゼロ依存**: 外部gemの影響を受けない安定したパフォーマンス
