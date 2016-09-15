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
    case @lv
    when 1..50
      # Lv51までは、必要経験値が100ずつ増えていく
      @lv * (@lv - 1) * 100 / 2
    when 51..60
      # Lv61までは、次レベルまでの必要経験値が200ずつ増えていく
      a = 5000
      d = 200
      n = @lv - 50
      # Lv50 までの累計経験値 = 122500
      122500 + n * (2 * a + (n - 1) * d) / 2
    when 61..70
      # Lv71までは、次レベルまでの必要経験値が300ずつ増えていく
      a = 7000
      d = 300
      n = @lv - 60
      # Lv60 までの累計経験値 = 181500
      181500 + n * (2 * a + (n - 1) * d) / 2
    when 71..80
      # Lv81までは、次レベルまでの必要経験値が400ずつ増えていく
      a = 10000
      d = 400
      n = @lv - 70
      # Lv70 までの累計経験値 = 265000
      265000 + n * (2 * a + (n - 1) * d) / 2
    when 81..91
      # Lv91までは、次レベルまでの必要経験値が500ずつ増えていく
      a = 14000
      d = 500
      n = @lv - 80
      # Lv80 までの累計経験値 = 383000
      383000 + n * (2 * a + (n - 1) * d) / 2
    when 92..99
      # Lv92以降は規則性がなくなるため、累計経験値表から取得
      EXP_TABLE[@lv]
    else
      nil
    end
  end
end
