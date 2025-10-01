# ModularAuth - プロジェクト構造

## ルートディレクトリ構成

### コアファイル
- `app.gemspec`: Gemの仕様定義とメタデータ
- `Gemfile`: 開発依存関係の管理
- `Rakefile`: ビルドタスクの定義
- `README.md`: プロジェクトの概要と使用方法
- `LICENSE`: MITライセンス
- `CHANGELOG.md`: バージョン変更履歴

### 設定ファイル
- `compose.yaml`: Docker Compose設定（開発環境用）
- `CODE_OF_CONDUCT.md`: コントリビューター向け行動規範

## サブディレクトリ構造

### `lib/` - メインライブラリ
```
lib/
├── app.rb                    # メインモジュール定義
├── modular_auth/
│   ├── version.rb           # バージョン情報
│   ├── configuration.rb     # 設定管理
│   ├── modules/             # 認証モジュール
│   │   ├── base.rb         # ベースモジュールクラス
│   │   ├── password.rb     # パスワード認証
│   │   ├── jwt.rb          # JWT認証
│   │   ├── oauth.rb        # OAuth認証
│   │   ├── totp.rb         # 多要素認証
│   │   └── registry.rb     # モジュール登録管理
│   ├── middleware/          # Rackミドルウェア
│   │   ├── authentication.rb
│   │   ├── session_manager.rb
│   │   └── module_router.rb
│   ├── core/                # コア機能
│   │   ├── session.rb      # セッション管理
│   │   ├── crypto.rb       # 暗号化処理
│   │   └── validator.rb    # バリデーション
│   ├── adapters/            # 外部システム統合
│   │   ├── rails.rb        # Rails統合
│   │   ├── sinatra.rb      # Sinatra統合
│   │   └── rack.rb         # 純粋Rack統合
│   └── utils/               # ユーティリティ
│       ├── logger.rb
│       └── helpers.rb
```

### `spec/` - テストファイル
```
spec/
├── spec_helper.rb           # テスト設定
├── app_spec.rb             # メインモジュールのテスト
├── modules/                 # モジュールのテスト
│   ├── password_spec.rb
│   ├── jwt_spec.rb
│   ├── oauth_spec.rb
│   ├── totp_spec.rb
│   └── registry_spec.rb
├── middleware/              # ミドルウェアのテスト
│   ├── authentication_spec.rb
│   ├── session_manager_spec.rb
│   └── module_router_spec.rb
├── core/                    # コア機能のテスト
│   ├── session_spec.rb
│   ├── crypto_spec.rb
│   └── validator_spec.rb
├── adapters/                # アダプターのテスト
│   ├── rails_spec.rb
│   ├── sinatra_spec.rb
│   └── rack_spec.rb
└── integration/             # 統合テスト
    ├── full_flow_spec.rb
    └── performance_spec.rb
```

### `bin/` - 実行可能ファイル
```
bin/
├── console                 # 対話的Ruby環境
└── setup                  # 開発環境セットアップ
```

### `sig/` - 型定義ファイル
```
sig/
└── app.rbs                # RBS型定義
```

## コード組織パターン

### モジュール構造
- **App**: メインモジュール（名前空間）
- **App::Modules**: 認証モジュールの実装
- **App::Middleware**: Rackミドルウェア
- **App::Core**: コア機能（セッション、暗号化、バリデーション）
- **App::Adapters**: 外部フレームワーク統合
- **App::Utils**: ユーティリティ機能

### モジュールアーキテクチャ
各認証方式は独立したモジュールクラスとして実装：
- **Base Module**: 共通インターフェースの定義
- **Concrete Modules**: 具体的な認証方式の実装
- **Module Registry**: モジュールの登録と管理
- **Module Router**: 適切なモジュールの選択と実行

### ミドルウェアアーキテクチャ
- **Authentication Middleware**: 認証処理のエントリーポイント
- **Session Manager**: セッション管理とセキュリティ
- **Module Router**: 適切なモジュールの選択と実行

## ファイル命名規則

### クラスファイル
- **スネークケース**: `password_module.rb`
- **対応クラス名**: `PasswordModule`
- **モジュール階層**: `App::Modules::PasswordModule`

### テストファイル
- **対象ファイル名 + _spec**: `password_module_spec.rb`
- **統合テスト**: `integration/` ディレクトリ内
- **フィクスチャ**: `fixtures/` ディレクトリ内

### 設定ファイル
- **YAML設定**: `config/modules.yml`
- **Ruby設定**: `config/initializers/modular_auth.rb`
- **環境別設定**: `config/environments/`

## インポート組織

### 依存関係の順序
1. **標準ライブラリ**: `require 'json'`
2. **内部モジュール**: `require_relative 'app/version'`
3. **外部依存なし**: ゼロ依存設計

### モジュール内インポート
```ruby
# メインモジュール
require_relative 'app/version'
require_relative 'app/configuration'

# 認証モジュール
require_relative 'app/modules/base'
require_relative 'app/modules/password'
```

## 主要アーキテクチャ原則

### 単一責任の原則
- 各モジュールは一つの認証方式のみを担当
- ミドルウェアは認証フローの制御のみ
- コア機能は特定の責務のみを担当

### 開放閉鎖の原則
- 新しい認証方式の追加は既存コードの変更なし
- モジュールインターフェースの拡張による機能追加
- プラグインシステムによる機能拡張

### 依存関係逆転の原則
- 高レベルモジュールは低レベルモジュールに依存しない
- 抽象化（モジュールインターフェース）に依存
- 具象クラスは抽象化を実装

### 設定駆動設計
- 認証フローは設定ファイルで制御
- ランタイムでの設定変更に対応
- 環境別設定のサポート

### ゼロ依存設計
- 外部gemに依存しない独立した実装
- 標準ライブラリのみを使用
- 軽量で高速な動作

### テスタビリティ
- 各コンポーネントの独立したテスト
- モックとスタブの活用
- 統合テストによる全体動作の検証
