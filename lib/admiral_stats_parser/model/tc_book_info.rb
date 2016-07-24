# -*- coding: utf-8 -*-
class TcBookInfo
  # 図鑑No.
  attr_accessor :book_no

  # 艦型
  # 未取得の場合は、空文字列
  attr_accessor :ship_class

  # 艦番号（1〜）
  # 未取得の場合は、-1
  attr_accessor :ship_class_index

  # 艦種
  # 未取得の場合は、空文字列
  attr_accessor :ship_type

  # 艦名
  # 未取得の場合は、"未取得"
  attr_accessor :ship_name

  # 一覧に表示する画像のファイル名
  # 未取得の場合は、空文字列
  attr_accessor :card_index_img

  # 取得済み画像のファイル名
  # Array
  # 未取得の場合は、空の Array
  attr_accessor :card_img_list

  # 画像のバリエーション数
  # 未取得の場合は、0
  attr_accessor :variation_num

  # 取得済みの画像数
  # 未取得の場合は、0
  attr_accessor :acquire_num

  # Lv. (From API version 2)
  # 未取得の場合は、0
  attr_accessor :lv

  # 艦娘のステータス画像（横長の画像）のファイル名 (From API version 2)
  # Array
  # 未取得の場合は、空の Array
  attr_accessor :status_img
end
