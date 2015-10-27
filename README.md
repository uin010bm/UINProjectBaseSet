# UINProjectBaseSet
プロジェクトを開始する時のサンプル。
汎用extension, function, baseviewなどを含む。
テストコード、サンプルテストコード、UIテストサンプル有り。

### ■ Spec

##### Xcode:
version 7.0.1
##### Swift:
version 2.0
##### PackageManager:
Alcatraz  
```
$ curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
```
　
-----------------------------
### ■ Pod
#### - cocoapods導入  
```
プロジェクトディレクトリにて下記を実行
$ gem install cocoapods
$ pod setup
```

#### - 導入済みライブラリ
##### ・UIImage+BlurredFrame  
`https://github.com/Adrian2112/UIImage-BlurredFrame`  
Blurイメージの作成  
##### ・BlocksKit  
`https://github.com/zwaldowski/BlocksKit`  
block構文の作成  
##### ・Alamofire  
`https://github.com/Alamofire/Alamofire`  
通信の簡易化  
##### ・SwiftyJSON  
`https://github.com/SwiftyJSON/SwiftyJSON`  
JSON型の追加  
##### ・Reachability  
`https://github.com/tonymillion/Reachability`  
通信状態の取得  
#####  ・OHHTTPStubs - OHHTTPStubs/Swift'  
`https://github.com/AliSoftware/OHHTTPStubs`  
stubリクエスト&レスポンス  
　  
　
-----------------------------
### ■ 汎用Function & extension & client
  
詳細は下記docsを参照  
https://uin010bm.github.io/UINProjectBaseSet/docs/index.html  
　  
#### ・Function.swift
**Log** - DEBUGスキーマ時のみprintを実行  
**ALERT** - Alert表示  
**run_on_background_queue** - バックグラウンドスレッドでblockを実行  
**run_on_main_queue** - メインスレッドでblockを実行  
**delay** - blockの遅延実行  
　
  
#### ・Extension
`/Extension`内に各クラスの拡張メソッドを格納しています。  
　
  
#### ・ApplicationManager.swift
カメラ設定や向き・Notification設定など、デバイスに関わる部分を管理しているクラスです。  
　
  
#### ・Network関連
**`ApiClient.swift`**  
stubの設定やAlamofireのconfig設定、errorハンドリングなどのサンプルを記載しています。  
スキーマ間の apiHost の管理もこちらで。  
　

**`User.swift`**  
データ管理のサンプルです。  
ここではUserというデータを扱う場合のサンプルを記載しています。  
DEBUGスキーマ時にはstubによる仮想コネクトを実施しています。  
返却される値は `/Stub` 内にファイルとして格納しております。  
　
  
#### ・カスタムview
**`PBSBaseXibView.swift`**  
xibの読み込み処理を追記したUIViewのサブクラスです。  
　

**`SampleCustomView.swift`**  
PBSBaseXibViewを利用するサンプルです。  
`SampleCustomView.xib` とひも付けて利用します。  
　  
　  

-----------------------------
### ■ scripts  
commit前に下記を実行し、リソースの並びを整理しましょう。  
`$ ./scripts/sort-Xcode-project-file UINProjectBaseSet.xcodeproj`  
　  
　  
-----------------------------
### ■ Localize  
Project Info にて English / Japanese を定義しています。  
`Resources/` 内に各言語のfileを格納しています。  
`SampleCustomView.swift` にてLocalizeのサンプルを実行しています。  
　  
　  
