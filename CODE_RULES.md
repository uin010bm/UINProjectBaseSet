# ProjectCodeRules

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
### ■ コメントの形式
enum、struct、property、function、などのまとまりの前にはMARKを挿入すること。

ex: `// MARK: - public functions`

VVDocumenterを利用してドキュメントを追加する。
```
///  関数説明
///
///  - parameter 引数名:  説明
///  - parameter 引数名:  説明
///  - returns: 説明
```
　
-----------------------
### ■ 記述順序
import  
enum  
struct  
global property  
class  
　　enum  
　　struct  
　　singleton  
　　static property  
　　private property  
　　public property  
　　static func  
　　class func  
　　initializer  
　　deinitializer  
　　viewdelegate  
　　private func  
　　public func  
extension
　
　
--------------------------
### ■ 変数
　- 型の予測がつかないNumberには型を明示する  
　`var int: Int`  
　`var float: Float`

　- global変数の場合は冒頭に k を付与  
　`public let kGlobalLet: Int = 0`

　- 不可変の let 変数の場合は冒頭を 大文字 にする  
　`private let InternalLet: Float = 0.1`

　- booleal型変数の場合は冒頭に is を付加する  
```
var isEnable = {
　// do something
　return true
}
```

　- load後に必ず格納される変数には Optional型 を利用しない  
　`var mustSetting: String!`

　- Array / Dictionary の作成は下記の形式に統一する  
　`var elements = [Int]()`  
　`var namesOfIntegers = [Int: String]()`
　
　
--------------------------
### ■ 関数
　- 名前で具体的な処理内容をわかるようにする  

　- 作成関連の関数には冒頭に create を付加する  
　`func createAdjustedImage()`  

　- 設定関連の関数には冒頭に setup を付加する  
　`func setupPropertys()`  

　- ローカルから何かを取得する場合は load を付加する  
　`func loadUserImage()`  

　- ネットワークから何かを取得する場合は冒頭に download を付加する  
　`func downloadUserName`  

　- 引数を設定する場合は極力末尾に With** / At** / To** / For** を付加する  
　`func scaleWithSize(size: CGSize)`  
　`func deleteCharactorAtCount(count: Int)`  
　`func getStartingStringToIndex(count: Int)`  
　`func addShadowForView(view: UIView)`  

　- 変数に何かを設定する場合は冒頭に set を付加する  
　`func setCount(count: Int)`

　- 変数から何かを取得する場合・関数から何かを取得する場合は get を付加する  
　`func getAdjustedImage()`  

　- ローカルに何かを保存する場合は冒頭に save を付加する  
　`func saveUserPassword(pass: String)`  

　- 何かを変化させる場合は冒頭に convert を付加する  
　`func convertImageSize(size: CGSize)`  

　- 通信関連の関数には冒頭に要求形式 get / post / delete… と request を付加する（getRequest***）  
　`func getRequestUseInfo()`  

　- boolean型をreturnする場合には冒頭に check を付加する  
　`func checkTapEnabled()`
　
　
---------------------------
### ■ モデル形式
　・Singleton - アプリ内で共通のパラメータを参照するときはsingletonにする  

　・命名規則  
　　**Client** - あるシステムを使うためのクラス  
　　**Manager** - あるシステムのパラメータを含む管理をするためのクラス  
　　**Service** - ある返却値を提供するためのクラス  
　　**Model** - あるデータを管理するためのクラス  
　
　
---------------------------
### ■ KeyObserver
　・基本的に一つのプロパティに対して設定する  
　・StructをKeyとしたObserverの登録はしない  
 （内部プロパティの変更があった場合でも呼ばれてしまうため）  
　
---------------------------
### ■ NotificationCenter
　・アプリデリゲートはプロジェクトApplicationクラス内に定義し、指定のNotificationを利用する  
　・基本的にdidloadで登録し、deinitにて削除を行う  
　
---------------------------
### ■ Delegate
　・protocolは移譲元に書く  
　・複数クラスで利用するprotocolはBaseProtocolを定義し、subProtocolを作る  
　・極力protocolのfuncの第一引数には移譲元クラス名を指定し、key名にもクラス名を反映する  
　・delegate先classでは Extension に該当protocolの実装を記述する  
　
---------------------------
### ■ NotificationCenter or Delegate？
　・基本的に言葉通り「知らせる」処理にはNotiを、「処理の移譲」にはDelegateを使う。  
　・ただし下記条件を満たす場合、Notiを使う。  
　　- 複数クラスへ処理を移譲する場合  
　　- クラスが2階層移譲離れている場合  
　
---------------------------
### ■ Extension
　・拡張元クラスと同一の名前でファイルを作成し、記述する  
　・Delegate先の実装もExtensionを利用して記述する  
　・すでにあるfunctionの拡張の場合、冒頭にプロジェクト名の略を付加して定義する  
　
---------------------------
### ■ ビルドセッティング
　ビルド別に変更されるパラメータは、ビルドセッティング内に設定する
　
---------------------------
### ■ 言語ローカライズ
　Plist用とSource用のファイルを用意し、[言語].lproj フォルダに格納する
