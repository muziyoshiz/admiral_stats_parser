# -*- coding: utf-8 -*-
# 海域情報
class AreaCaptureInfo
  # 海域番号
  # 1: 鎮守府海域
  # 2: 南西諸島海域
  # 3: 北方海域
  # 4: 西方海域
  attr_accessor :area_id

  # サブ海域番号
  attr_accessor :area_sub_id

  # 作戦時間（秒）
  # 未表示の場合は 0
  attr_accessor :limit_sec

  # 必要GP (From API version 2)
  # 未表示の場合は 0
  attr_accessor :require_gp

  # 追撃戦かどうか（true なら追撃戦）
  attr_accessor :pursuit_map

  # 追撃戦が出現しているかどうか（true なら出現している）
  # 追撃戦の場合は常に false
  attr_accessor :pursuit_map_open

  # 出撃条件の有無（true ならある） (From API version 2)
  attr_accessor :sortie_limit

  # 海域画像のファイル名
  attr_accessor :stage_image_name

  # 作戦名
  attr_accessor :stage_mission_name

  # 作戦内容
  attr_accessor :stage_mission_info

  # 海域クリアボーナス
  # アイテムを表す、以下の文字列のいずれか
  # MEISTER: 特注家具職人
  # BUCKET: 修復バケツ
  # SMALLREC: 伊良湖
  # SMALLBOX: 家具コイン(小)
  # MEDIUMBOX: 家具コイン(中)
  # NONE: ボーナスなし
  # UNKNOWN: 海域が未表示の場合
  attr_accessor :stage_clear_item_info

  # 主な出現アイテム
  # アイテムを表す文字列の配列（要素数は4固定）
  attr_accessor :stage_drop_item_info

  # クリア状態を表す文字列
  # CLEAR: クリア済み
  # NOTCLEAR: 出撃可能だが未クリア
  # NOOPEN: 出撃不可
  attr_accessor :area_clear_state
end
