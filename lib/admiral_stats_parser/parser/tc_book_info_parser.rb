require 'json'
require 'admiral_stats_parser/model/tc_book_info'

module TcBookInfoParser
  MANDATORY_KEYS = {
    1 => {
      :book_no => Integer,
      :ship_class => String,
      :ship_class_index => Integer,
      :ship_type => String,
      :ship_name => String,
      :card_index_img => String,
      :card_img_list => Array,
      :variation_num => Integer,
      :acquire_num => Integer,
#      :lv => Integer,
#      :status_img => Array,
    },
    2 => {
      :book_no => Integer,
      :ship_class => String,
      :ship_class_index => Integer,
      :ship_type => String,
      :ship_name => String,
      :card_index_img => String,
      :card_img_list => Array,
      :variation_num => Integer,
      :acquire_num => Integer,
      :lv => Integer,
      :status_img => Array,
    }
  }

  def self.parse(json, api_version)
    items_array = JSON.parse(json)

    unless items_array.is_a?(Array)
      raise 'json is not an Array'
    end

    results = []
    items_array.each do |items|
      result = TcBookInfo.new

      MANDATORY_KEYS[api_version].each do |key, key_class|
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
