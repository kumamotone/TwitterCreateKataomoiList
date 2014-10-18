# coding: utf-8
require "twitter" 

### gemのバージョンが4.xxと5.xxだと結構使えるメソッドの名前とかが違うので
### 現行のバージョンで動かない場合は実装を書きなおすかv4.xxを入れてください
### 参考:
### http://lance104.hatenablog.jp/entry/2014/03/10/234257

client = Twitter.configure do |config|
  config.consumer_key = ""     ## 要設定
  config.consumer_secret = "" ## 要設定
  config.oauth_token = "" ## 要設定
  config.oauth_token_secret = "" ## 要設定
end

username = '' ## 要設定
listname = 'kataomoi' ## 要設定
slicecount = 20

### 片思いユーザの一覧を取得します

friend = Twitter.friend_ids(username)
follower = Twitter.follower_ids(username)
kataomoi = friend.ids - follower.ids

### listnameで設定したリスト名のリストを削除して作りなおします
### Twitterクライアント等で作成してもいいです

Twitter.list_destroy(listname)
Twitter.list_create(listname, {:mode => 'private'})

### slicecount人ずつlistnameで設定したリスト名のリストに追加していきます
### あんまりslicecountを大きくするとBad Request
### とかいって怒られることがあったので
### こうしました

kataomoi.each_slice(slicecount) do |slice|
  Twitter.list_add_members(listname, slice)
  print ("ok")
end

### 作成したリストのユーザをリムーブします
### 人数によってはRate limit exceededで怒られることが
### あるので適当にやりなおしたり，Twitterクライアントとかで
### リストにアクセスしてぽちぽちリムってください
### なにより一括リムーブできるサービスは結構あります

### 取り返しの付かない作業なので
### 一応コメントアウトしています
### 念のため片思いったー (http://easy.chillout.jp/)
### とかで作成されたリストと片思い人数が合ってるか確認してもらってもいいです

# kataomoi.each do |id|
#  user = Twitter.user(id)
#  Twitter.friendship_destroy(user.id)
#  print ("removed:")
#  puts user.screen_name
# end
