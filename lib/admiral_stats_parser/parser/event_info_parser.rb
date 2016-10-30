require 'json'
require 'admiral_stats_parser/model/event_info'

class EventInfoParser
  MANDATORY_KEYS = {
      1 => {
          :area_id => Integer,
          :area_sub_id => Integer,
          :level => String,
          :area_kind => String,
          :limit_sec => Integer,
          :require_gp => Integer,
          :sortie_limit => :boolean,
          :stage_image_name => String,
          :stage_mission_name => String,
          :stage_mission_info => String,
          :reward_list => :reward_list,
          :stage_drop_item_info => Array,
          :area_clear_state => String,
          :military_gauge_status => String,
          :ene_military_gauge_val => Integer,
          :military_gauge_left => Integer,
          :boss_status => String,
          :loop_count => Integer,
      }
  }

  REWARD_LIST_MANDATORY_KEYS = {
      :data_id => Integer,
      :kind => String,
      :value => Integer,
  }

  REWARD_LIST_OPTIONAL_KEYS = {
      :reward_type => String,
  }

  def self.parse(json, api_version)
    items_array = JSON.parse(json)

    unless items_array.is_a?(Array)
      raise 'json is not an Array'
    end

    results = []
    items_array.each do |items|
      result = EventInfo.new

      MANDATORY_KEYS[api_version].each do |key, key_class|
        # 必須のキーが含まれなければエラー
        camel_case_key = key.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
        unless items.include?(camel_case_key)
          raise "Mandatory key #{key} does not exist"
        end

        # 結果のクラスが合わなければエラー
        # 海域撃破ボーナスを格納するために、特別な処理を追加
        if key_class == :reward_list
          result.instance_variable_set(
              "@#{key.to_s}", EventInfoParser.parse_reward_list(items[camel_case_key]))
          next
        end

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

  def self.parse_reward_list(rewards)
    results = []

    rewards.each do |reward|
      result = EventInfo::EventInfoReward.new

      REWARD_LIST_MANDATORY_KEYS.each do |key, key_class|
        # 必須のキーが含まれなければエラー
        camel_case_key = key.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
        unless reward.include?(camel_case_key)
          raise "Mandatory key #{key} does not exist"
        end

        # 結果のクラスが合わなければエラー
        unless reward[camel_case_key].is_a?(key_class)
          raise "Mandatory key #{key} is not class #{key_class}"
        end

        result.instance_variable_set("@#{key.to_s}", reward[camel_case_key])
      end

      REWARD_LIST_OPTIONAL_KEYS.each do |key, key_class|
        # キーが含まれなければ、処理をスキップ
        camel_case_key = key.to_s.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
        next unless reward.include?(camel_case_key)

        # 結果のクラスが合わなければエラー
        unless reward[camel_case_key].is_a?(key_class)
          raise "Optional key #{key} is not class #{key_class}"
        end

        result.instance_variable_set("@#{key.to_s}", reward[camel_case_key])
      end

      results << result
    end

    results
  end
end
