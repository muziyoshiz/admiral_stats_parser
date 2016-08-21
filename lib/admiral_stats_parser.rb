require 'time'
require 'admiral_stats_parser/version'
require 'admiral_stats_parser/parser/personal_basic_info_parser'
require 'admiral_stats_parser/parser/area_capture_info_parser'
require 'admiral_stats_parser/parser/tc_book_info_parser'
require 'admiral_stats_parser/parser/equip_book_info_parser'
require 'admiral_stats_parser/parser/character_list_info_parser'
require 'admiral_stats_parser/parser/equip_list_info_parser'

module AdmiralStatsParser
  # 最新の API バージョンを返します。
  def self.get_latest_api_version
    return 2
  end

  # エクスポート時刻を元に、API バージョンを推測して返します。
  def self.guess_api_version(exported_at)
    # version 2 の開始日
    t2 = Time.parse('2016-06-30T00:00:00+0900')

    return 1 if (exported_at < t2)
    return self.get_latest_api_version
  end

  # 基本情報をパースします。
  def self.parse_personal_basic_info(json, api_version)
    case api_version
      when 1, 2
      PersonalBasicInfoParser.parse(json, api_version)
    else
      raise 'unsupported API version'
    end
  end

  # 海域情報をパースします。
  def self.parse_area_capture_info(json, api_version)
    case api_version
      when 1, 2
      AreaCaptureInfoParser.parse(json, api_version)
    else
      raise 'unsupported API version'
    end
  end

  # 艦娘図鑑をパースします。
  def self.parse_tc_book_info(json, api_version)
    case api_version
      when 1, 2
      TcBookInfoParser.parse(json, api_version)
    else
      raise 'unsupported API version'
    end
  end

  # 装備図鑑をパースします。
  def self.parse_equip_book_info(json, api_version)
    case api_version
      when 1, 2
      EquipBookInfoParser.parse(json)
    else
      raise 'unsupported API version'
    end
  end

  # 艦娘一覧をパースします。
  def self.parse_character_list_info(json, api_version)
    case api_version
    when 1
      raise 'API version 1 does not support character list info'
    when 2
      CharacterListInfoParser.parse(json)
    else
      raise 'unsupported API version'
    end
  end

  # 装備一覧をパースします。
  def self.parse_equip_list_info(json, api_version)
    case api_version
    when 1
      raise 'API version 1 does not support equip list info'
    when 2
      EquipListInfoParser.parse(json)
    else
      raise 'unsupported API version'
    end
  end
end
