# -*- coding: utf-8 -*-
require 'spec_helper'

describe EquipListInfo do
  describe '#type_to_s' do
    it 'returns name of equipment type' do
      equip = EquipListInfo.new
      equip.type = 1
      expect(equip.type_to_s).to eq('主砲')

      equip.type = 2
      expect(equip.type_to_s).to eq('副砲・高角')

      equip.type = 3
      expect(equip.type_to_s).to eq('魚雷')

      equip.type = 4
      expect(equip.type_to_s).to eq('艦戦')

      equip.type = 5
      expect(equip.type_to_s).to eq('艦爆・艦攻')

      equip.type = 6
      expect(equip.type_to_s).to eq('偵察機')

      equip.type = 7
      expect(equip.type_to_s).to eq('ソナー・爆雷')

      equip.type = 8
      expect(equip.type_to_s).to eq('その他')

      # 不明な名前の場合は、type の数値をそのまま返す
      equip.type = 9
      expect(equip.type_to_s).to eq('9')

      equip.type = nil
      expect(equip.type_to_s).to eq('')
    end
  end
end
