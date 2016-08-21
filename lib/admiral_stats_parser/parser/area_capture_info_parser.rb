require 'json'
require 'admiral_stats_parser/model/area_capture_info'

class AreaCaptureInfoParser
  MANDATORY_KEYS = {
    1 => {
      :area_id => Integer,
      :area_sub_id => Integer,
      :limit_sec => Integer,
#      :require_gp => Integer,
      :pursuit_map => :boolean,
      :pursuit_map_open => :boolean,
#      :sortie_limit => :boolean,
      :stage_image_name => String,
      :stage_mission_name => String,
      :stage_mission_info => String,
      :stage_clear_item_info => String,
      :stage_drop_item_info => Array,
      :area_clear_state => String,
    },
    2 => {
      :area_id => Integer,
      :area_sub_id => Integer,
      :limit_sec => Integer,
      :require_gp => Integer,
      :pursuit_map => :boolean,
      :pursuit_map_open => :boolean,
      :sortie_limit => :boolean,
      :stage_image_name => String,
      :stage_mission_name => String,
      :stage_mission_info => String,
      :stage_clear_item_info => String,
      :stage_drop_item_info => Array,
      :area_clear_state => String,
    }
  }

  def self.parse(json, api_version)
    items_array = JSON.parse(json)

    unless items_array.is_a?(Array)
      raise 'json is not an Array'
    end

    results = []
    items_array.each do |items|
      result = AreaCaptureInfo.new

      MANDATORY_KEYS[api_version].each do |key, key_class|
        # 必須のキーが含まれなければエラー
        camel_case_key = key.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
        unless items.include?(camel_case_key)
          raise "Mandatory key #{key} does not exist"
        end

        # 結果のクラスが合わなければエラー
        # ruby には Boolean クラスがないので、そこだけ特別な処理を用意する
        if key_class == :boolean
          unless [true, false].include?(items[camel_case_key])
            raise "Mandatory key #{key} is not boolean"
          end
        else
          unless items[camel_case_key].is_a?(key_class)
            raise "Mandatory key #{key} is not class #{key_class}"
          end
        end

        result.instance_variable_set("@#{key.to_s}", items[camel_case_key])
      end

      results << result
    end

    results
  end
end
