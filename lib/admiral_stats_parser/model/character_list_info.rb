# 艦娘一覧
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

  # 星の数（1〜5）
  attr_accessor :star_num

  # 艦型
  # 未取得の場合は、空文字列
  attr_accessor :ship_class

  # 艦番号（1〜）
  # 未取得の場合は、-1
  attr_accessor :ship_class_index

  # 詳細画面で表示する画像のファイル名
  attr_accessor :tc_img

  # 経験値の獲得割合(%)
  attr_accessor :exp_percent

  # 最大HP
  attr_accessor :max_hp

  # 現在HP
  attr_accessor :real_hp

  # 被弾状態を表す文字列（"NORMAL" 以外に何がある？）
  attr_accessor :damage_status

  # 装備スロット数
  attr_accessor :slot_num

  # 各スロットの装備名を表す文字列の配列（スロット数が4未満でも、要素は4個）
  attr_accessor :slot_equip_name

  # 各スロットに搭載可能な艦載機数の配列（スロット数が4未満でも、要素は4個）
  # 艦載機を搭載できない場合は 0
  attr_accessor :slot_amount

  # 各スロットの搭載状況を表す文字列の配列（スロット数が4未満でも、要素は4個）
  # "NONE":
  # "NOT_EQUIPPED_AIRCRAFT": 艦載機を装備可能なスロットだが、艦載機を装備していない
  # "EQUIPPED_AIRCRAFT": 艦載機を装備している
  attr_accessor :slot_disp

  # 各スロットの装備画像のファイル名の配列（スロット数が4未満でも、要素は4個）
  # 何も装備していない場合、および装備可能なスロットでない場合は、空文字列
  attr_accessor :slot_img

  # 改装設計図の枚数 (From API version 7)
  attr_accessor :blueprint_total_num

  # 累計経験値表
  EXP_TABLE = {
    92 => 584500,
    93 => 606500,
    94 => 631500,
    95 => 661500,
    96 => 701500,
    97 => 761500,
    98 => 851500,
    99 => 1000000,
  }

  # Lv を、これまでに取得した累計経験値に変換して返します。
  # ただし、Lv をもとに計算する都合上、その Lv になってから取得した経験値は含みません。
  # この累計経験値は、艦娘の経験値テーブルが、艦これの本家と同じと仮定して計算しています。
  def lv_to_exp
    CharacterListInfo.convert_lv_to_exp(@lv)
  end

  # Lv および経験値の獲得割合を、これまでに取得した累計経験値に変換して返します。
  # 獲得割合は整数のパーセントなので、実際の累積経験値とは誤差があります。
  # また、経験値の獲得割合がサポートされる前のデータ（API version 4 以前）では、lv_to_exp と同じ結果を返します。
  # この累計経験値は、艦娘の経験値テーブルが、艦これの本家と同じと仮定して計算しています。
  def lv_and_exp_percent_to_exp
    CharacterListInfo.convert_lv_and_exp_percent_to_exp(@lv, @exp_percent)
  end

  # 引数で与えられた Lv を、これまでに取得した累計経験値に変換して返します。
  # ただし、Lv をもとに計算する都合上、その Lv になってから取得した経験値は含みません。
  # この累計経験値は、艦娘の経験値テーブルが、艦これの本家と同じと仮定して計算しています。
  def self.convert_lv_to_exp(lv)
    case lv
      when 1..50
        # Lv51までは、必要経験値が100ずつ増えていく
        lv * (lv - 1) * 100 / 2
      when 51..60
        # Lv61までは、次レベルまでの必要経験値が200ずつ増えていく
        a = 5000
        d = 200
        n = lv - 50
        # Lv50 までの累計経験値 = 122500
        122500 + n * (2 * a + (n - 1) * d) / 2
      when 61..70
        # Lv71までは、次レベルまでの必要経験値が300ずつ増えていく
        a = 7000
        d = 300
        n = lv - 60
        # Lv60 までの累計経験値 = 181500
        181500 + n * (2 * a + (n - 1) * d) / 2
      when 71..80
        # Lv81までは、次レベルまでの必要経験値が400ずつ増えていく
        a = 10000
        d = 400
        n = lv - 70
        # Lv70 までの累計経験値 = 265000
        265000 + n * (2 * a + (n - 1) * d) / 2
      when 81..91
        # Lv91までは、次レベルまでの必要経験値が500ずつ増えていく
        a = 14000
        d = 500
        n = lv - 80
        # Lv80 までの累計経験値 = 383000
        383000 + n * (2 * a + (n - 1) * d) / 2
      when 92..99
        # Lv92以降は規則性がなくなるため、累計経験値表から取得
        EXP_TABLE[lv]
      else
        raise "Unsupported Lv: #{lv}"
    end
  end

  # Lv および経験値の獲得割合を、これまでに取得した累計経験値に変換して返します。
  # 獲得割合は整数のパーセントなので、実際の累積経験値とは誤差があります。
  # また、経験値の獲得割合がサポートされる前のデータ（API version 4 以前）では、lv_to_exp と同じ結果を返します。
  # この累計経験値は、艦娘の経験値テーブルが、艦これの本家と同じと仮定して計算しています。
  def self.convert_lv_and_exp_percent_to_exp(lv, exp_percent)
    # API version 4 以前のデータには exp_percent が含まれないので、lv_to_exp と同じ結果を返す
    unless exp_percent
      return convert_lv_to_exp(lv)
    end

    # Lv 99 に達している場合、および exp_percent が 0 の場合も、lv_to_exp と同じ結果を返す
    if lv == 99 or exp_percent == 0
      return convert_lv_to_exp(lv)
    end

    # 現在のレベルまでの経験値
    current_exp = convert_lv_to_exp(lv)
    # 次のレベルまでの経験値
    next_exp = convert_lv_to_exp(lv + 1)

    # 次のレベルに達するまでに必要な経験値を加算して返す
    current_exp + (next_exp - current_exp) * exp_percent / 100
  end
end
