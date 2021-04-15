# これは何か

[調整さん](https://chouseisan.com) の候補日程作成がだるかったのでそれをさくっと出力するツール。

# こんな感じ

```
[pharaohkj]$ be ruby main.rb
main.rb 2020-01-01 7 19-22
7/27(月) 10:00〜
7/27(月) 19:00〜
7/28(火) 10:00〜
7/28(火) 19:00〜
7/29(水) 10:00〜
7/29(水) 19:00〜
7/30(木) 10:00〜
7/30(木) 19:00〜
7/31(金) 10:00〜
7/31(金) 19:00〜
8/1(土) 10:00〜
8/1(土) 19:00〜
8/2(日) 10:00〜
8/2(日) 19:00〜
```

# どうやって使うか

`bundle install` などして `bundle exec ruby main.rb <開始したい日付> <その日付からn日分> <候補にしたい時間>` を実行します。

具体的には `bundle exec ruby main.rb 2020-01-01 10 10-13-17-21` とすれば、2020年1月1日から10日分の10時・13時・17時・21時の候補日が表示されます。

引数を省略したら明日から7日分、19時と22時になる。

