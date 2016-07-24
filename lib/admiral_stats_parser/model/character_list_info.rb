# -*- coding: utf-8 -*-
class CharacterListInfo
  # 図鑑No.
  attr_accessor :book_no

  # Lv.
  attr_accessor :lv

  # 艦種
  attr_accessor :ship_type

  # 艦種順でソートする際に使うキー
  attr_accessor :ship_sort_no

  # 艦娘の改造度合いを表す数値
  # （未改造の艦娘と、改造済みの艦娘が、別のデータとして返される）
  # 0: 未改造
  # 1: 改
  attr_accessor :remodel_lv

  # 艦名
  attr_accessor :ship_name

  # 艦娘のステータス画像（横長の画像）のファイル名
  attr_accessor :status_img
end
