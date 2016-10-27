# 限定海域情報
class EventInfo
  # 海域番号と海域名の対応関係
  EVENT_AREA_NAMES = {
      1000 => '敵艦隊前線泊地殴り込み',
  }

  # サブ海域番号と海域名の対応関係
  EVENT_AREA_SUB_NAMES = {
      1000 => {
          1 => '前哨戦',
          2 => '警戒線突破',
          3 => '',
          4 => '',
          5 => '',
          6 => '',
          7 => '',
          8 => '',
          9 => '',
          10 => '',
      },
  }

  # 海域番号
  # 期間限定海域「敵艦隊前線泊地殴り込み」では、共通して 1000
  attr_accessor :area_id

  # サブ海域番号
  # 期間限定海域「敵艦隊前線泊地殴り込み」では、1 〜 10
  attr_accessor :area_sub_id

  # 難易度
  # "HEI": 丙
  # "OTU": 乙
  attr_accessor :level

  # 海域の種類
  # ボス戦は "BOSS"
  # 掃討戦は "SWEEP"
  # それ以外は "NORMAL"
  attr_accessor :area_kind

  # 作戦時間（秒）
  # 未表示の場合は 0
  attr_accessor :limit_sec

  # 必要GP
  # 未表示の場合は 0
  attr_accessor :require_gp

  # 出撃条件の有無（true ならある）
  attr_accessor :sortie_limit

  # 海域画像のファイル名
  attr_accessor :stage_image_name

  # 作戦名
  # 未表示の場合は "？"
  attr_accessor :stage_mission_name

  # 作戦内容
  # 未表示の場合は "？"
  attr_accessor :stage_mission_info

  # 海域撃破ボーナス(EventInfoReward)のリスト
  attr_accessor :reward_list

  # 主な出現アイテム
  # アイテムを表す文字列の配列（要素数は4固定）
  attr_accessor :stage_drop_item_info

  # クリア状態を表す文字列
  # CLEAR: クリア済み
  # NOTCLEAR: 出撃可能だが未クリア
  # NOOPEN: 出撃不可
  attr_accessor :area_clear_state

  # 海域ゲージの状態？
  # "NORMAL": 初回攻略前
  # "BREAK": 攻略後
  attr_accessor :military_gauge_status

  # 海域ゲージの最大値？
  # E-1 攻略開始前は 1000、攻略後も 1000
  attr_accessor :ene_military_gauge_val

  # 海域ゲージの現在値？
  # E-1 攻略開始前は 1000、攻略後は 0
  attr_accessor :military_gauge_left

  # ボスのランク？
  # E-4 のみ "ONI"
  # それ以外は "NONE"
  attr_accessor :boss_status

  # 周回数？
  # E-1 攻略開始前は 1、攻略後も 1
  attr_accessor :loop_count

  # 海域を表す数値を、海域名に変換して返します。
  def area_id_to_s
    EVENT_AREA_NAMES.include?(@area_id) ? EVENT_AREA_NAMES[@area_id] : @area_id.to_s
  end

  # サブ海域を表す数値を、海域名に変換して返します。
  def area_sub_id_to_s
    return "#{@area_id}-#{@area_sub_id}" unless EVENT_AREA_SUB_NAMES.include?(@area_id)

    if EVENT_AREA_SUB_NAMES[@area_id].include?(@area_sub_id)
      EVENT_AREA_SUB_NAMES[@area_id][@area_sub_id]
    else
      "#{@area_id}-#{@area_sub_id}"
    end
  end

  # 海域撃破ボーナス
  class EventInfoReward
    # 初回攻略時か2回目以降かを表すフラグ
    # "FIRST": 初回
    # "SECOND": 2回目以降
    attr_accessor :reward_type

    # 表示順（0 〜）
    attr_accessor :data_id

    # ボーナスの種類
    # "NONE": 未公開状態
    # "RESULT_POINT": 戦果
    # "ROOM_ITEM_ICON": 家具コイン
    # "EQUIP": 装備
    # "STRATEGY_POINT": 戦略ポイント
    attr_accessor :kind

    # 数値（戦果の場合はポイント数、家具コインの場合はコイン枚数）
    attr_accessor :value
  end
end