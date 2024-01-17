# ws-reviews（WSレビューズ）

## サービス概要
演劇のワークショップをレビュー・おすすめするサービスです。
ユーザーは投稿されたおすすめから検索することができます。

## このサービスを作る背景、思い
私がこのアプリを作成したい理由は、大きくふたつ理由があります。
- ハラスメントが発生する場を減らしたい
  ここ数年で舞台の創作現場でのハラスメントが世間に明るみになるようになりました。お芝居の創作現場はダメ出しが行きすぎて無意識に人格否定になってしまったり怒鳴ってしまったりハラスメントが起きやすい場だと思います。それは実際の現場でなくWSでも同じです。WSに参加するにも高いお金を払って参加するので、参加した所感を共有してハラスメントが起きるような危険な場を避けられたらいいなと思いました。（実際の現場の方がハラスメントは起きやすいですが、現場をフィードバックしても同じ座組で組で公演を行なうことは劇団でない場合はほとんどないのでWSを対象としたサービスにしました。）
- 質の良いWSに参加してほしい
  演劇のWSはどのようなWSなのか主催者以外からの情報が少ない状態です。せっかくいい内容のWSがあっても人が集まらないことが多々あります。さらに2020年にコロナ禍になって直接対面が必要なお芝居の練習の場に参加するのが難しくなり、せっかくいい内容のWSが開かれていても参加者が集まりづらくなりました。私もある団体のWSに継続的に参加していたのですが、そこの主催者の人も参加者集めに苦労しています。X（旧Twitter）で参加して良かったとツイートしてくれている人もいるのでそれがもっと見やすい形で残る＋共有できるといいなと思いました。

## 想定されるユーザー層
- 参加したワークショップをおすすめしたい演劇関係者
- 演劇関係のワークショップを探しているが、参加した人の声を聞きたい演劇関係者

## サービスコンセプト
### みんなが高野しのぶさんになる
演劇のWSやオーディションを調べる際に多くの演劇人は高野しのぶさんのブログ（[しのぶの演劇レビュー](https://shinobutakano.com/)）を参考にしています。演劇レビューは高野しのぶさんがダントツで参考にされていると思ってますので、みんなが高野しのぶさんのように参考にされるレビュアーになれればいいなと思ってこのコンセプトを掲げます。

## 差別化、売りのポイント
例えばWSが投稿されているサイトは[CINEMA PLANNERS シネマプランナーズ](https://cinepu.com/)がありますが、こちらは映像関連の募集も入っていますし、オーディション、WS、エキストラ、スタッフの募集など多岐にわたっていますが検索がしづらいと思っています。ですので、私のサービスではより演劇のWSに特化し、さらに開催期間や募集の〆切での検索、キーワードをタグづけして細かく検索できるようにしたいと考えています。
また、既存のサイトでは過去のWSの所感などは載っていないので、過去のWSのレビューも投稿できるようにして今後開催されるWSの参加の参考にしていただければと思っています。

## 実装を予定している機能
### MVP
* ユーザー登録
  Twitter APIを利用して登録する
* ログイン
  Twitter APIを利用してログインする
* ワークショップレビュー、おすすめ投稿機能
  * 必須項目
    * WSについてのURL
    ※虚偽投稿防止のためURLは必須とし、リクエストを送りStatus200が返ってこないと投稿できないようにする
    * レビュー（おすすめ）内容
    * 実施期間（実施期間で過去かどうか判別する）
  * 任意項目
    * タイトル（入力しないとURL先のtitleタグの内容が入る）
    * キーワード（タグ）
    * 場所（都道府県）
    * 募集対象（俳優、演出家、舞台技術、制作その他で選択式にする）
    * 募集期間
    * 料金
* ワークショップレビュー一覧、おすすめ機能
* ワークショップレビュー、おすすめ詳細機能
* ワークショップレビュー、おすすめ検索機能
  マルチ検索・オートコンプリート
    投稿のタイトル、レビュー内容から検索できるようにする
    Stimulus Autocompleteで候補（タグ）が表示されるようにする
* 投稿お気に入り機能
* レコメンド機能（お気に入りからのレコメンド）
　ユーザーのお気に入りに応じてレコメンドの投稿を表示させる（お気に入りの投稿と同じタグのものを1件表示させる）
　

### その後の機能
* お気に入り通知機能
  投稿がお気に入りされたら通知がくる
* 〆切通知機能
  お気に入りに登録した投稿のWSの募集〆切が近づいてきたらLINEに通知がくる
* 誹謗中傷対策（必要が出てきたら）
  * 禁止ワードなどバリデーションをかけて防止する（正規表現を用いて）
  * 誹謗中傷防止のためアカウント登録時のX（旧Twitter）に登録して1ヶ月以上経ってないと投稿できないようにする
* 関連投稿表示機能（同じWSについての投稿表示）
　WSの主催者が同じ投稿を表示させる（URL先の内容から主催者（主催団体）を特定する）
* レコメンド機能（検索条件からのレコメンド）
　ユーザーの検索履歴に応じてレコメンドの投稿を表示させる

## 画面遷移図
https://www.figma.com/file/I75oR0txfRuq7D7yx4Bhnk/ws-revies?type=design&node-id=0-1&mode=design&t=pKQf7lOaVmcmGhEd-0

## ER 図
<img src="./assets/ws-reviews-ER_231020.webp">

## 使用技術
■ サーバサイド: Ruby on Rails 7系
　　Ruby 3.1.4p223 Rails 7.1.2
■ フロントエンド: HotWire
■ CSSフレームワーク: Tailwind Flowbite(Tailwindのライブラリ)
■ WebAPI: Twitter API
■ インフラ:
・ Webアプリケーションサーバ: Heroku
・ データベースサーバ: PostgreSQL
