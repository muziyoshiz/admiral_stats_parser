# -*- coding: utf-8 -*-
# 海域情報
class AreaCaptureInfo
  # 海域番号と海域名の対応関係
  AREA_NAMES = {
    1 => '鎮守府海域',
    2 => '南西諸島海域',
    3 => '北方海域',
    4 => '西方海域',
  }

  # サブ海域番号と海域名の対応関係
  AREA_SUB_NAMES = {
    1 => {
      1 => '鎮守府正面海域',
      2 => '南西諸島沖',
      3 => '製油所地帯沿岸',
      4 => '南西諸島防衛戦',
    },
    2 => {
      1 => 'カムラン半島',
      2 => 'バシー島沖',
      3 => '東部オリョール海',
      4 => '沖ノ島海域',
    },
    3 => {
      1 => 'モーレイ海哨戒',
      2 => 'キス島撤退作戦',
      3 => 'アルフォンシーノ方面進出',
      4 => '北方海域艦隊決戦',
    },
    4 => {
      1 => 'ジャム島攻略作戦',
      2 => 'カレー洋制圧戦',
    },
  }

  # 海域番号
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

  # 海域を表す数値を、海域名に変換して返します。
  def area_id_to_s
    AREA_NAMES.include?(@area_id) ? AREA_NAMES[@area_id] : @area_id.to_s
  end

  # サブ海域を表す数値を、海域名に変換して返します。
  def area_sub_id_to_s
    return "#{@area_id}-#{@area_sub_id}" unless AREA_SUB_NAMES.include?(@area_id)

    if AREA_SUB_NAMES[@area_id].include?(@area_sub_id)
      AREA_SUB_NAMES[@area_id][@area_sub_id]
    else
      "#{@area_id}-#{@area_sub_id}"
    end
  end
end
