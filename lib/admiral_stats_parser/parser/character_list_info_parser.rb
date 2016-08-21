require 'json'
require 'admiral_stats_parser/model/character_list_info'

class CharacterListInfoParser
  MANDATORY_KEYS = {
    :book_no => Integer,
    :lv => Integer,
    :ship_type => String,
    :ship_sort_no => Integer,
    :remodel_lv => Integer,
    :ship_name => String,
    :status_img => String,
  }

  def self.parse(json)
    items_array = JSON.parse(json)

    unless items_array.is_a?(Array)
      raise 'json is not an Array'
    end

    results = []
    items_array.each do |items|
      result = CharacterListInfo.new

      MANDATORY_KEYS.each do |key, key_class|
        # 必須のキーが含まれなければエラー
        camel_case_key = key.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
        unless items.include?(camel_case_key)
          raise "Mandatory key #{key} does not exist"
        end

        # 結果のクラスが合わなければエラー
        unless items[camel_case_key].is_a?(key_class)
          raise "Mandatory key #{key} is not class #{key_class}"
        end

        result.instance_variable_set("@#{key.to_s}", items[camel_case_key])
      end

      results << result
    end

    results
  end
end
