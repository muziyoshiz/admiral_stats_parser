require 'spec_helper'

describe EquipListInfo do
  describe '#type_to_s' do
    it 'returns name of equipment type' do
      info = EquipListInfo.new
      info.type = 1
      expect(info.type_to_s).to eq('主砲')

      info.type = 2
      expect(info.type_to_s).to eq('副砲・高角')

      info.type = 3
      expect(info.type_to_s).to eq('魚雷')

      info.type = 4
      expect(info.type_to_s).to eq('艦戦')

      info.type = 5
      expect(info.type_to_s).to eq('艦爆・艦攻')

      info.type = 6
      expect(info.type_to_s).to eq('偵察機')

      info.type = 7
      expect(info.type_to_s).to eq('ソナー・爆雷')

      info.type = 8
      expect(info.type_to_s).to eq('その他')

      # 不明な名前の場合は、type の数値をそのまま返す
      info.type = 9
      expect(info.type_to_s).to eq('9')

      info.type = nil
      expect(info.type_to_s).to eq('')
    end
  end
end
