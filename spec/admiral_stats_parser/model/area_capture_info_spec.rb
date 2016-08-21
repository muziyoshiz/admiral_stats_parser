require 'spec_helper'

describe AreaCaptureInfo do
  describe '#area_id_to_s' do
    it 'returns name of area' do
      info = AreaCaptureInfo.new

      info.area_id = 1
      expect(info.area_id_to_s).to eq('鎮守府海域')

      info.area_id = 2
      expect(info.area_id_to_s).to eq('南西諸島海域')

      info.area_id = 3
      expect(info.area_id_to_s).to eq('北方海域')

      info.area_id = 4
      expect(info.area_id_to_s).to eq('西方海域')

      info.area_id = 5
      expect(info.area_id_to_s).to eq('5')

      info.area_id = nil
      expect(info.area_id_to_s).to eq('')
    end
  end

  describe '#area_sub_id_to_s' do
    it 'returns name of sub area' do
      info = AreaCaptureInfo.new

      info.area_id = 1
      info.area_sub_id = 1
      expect(info.area_sub_id_to_s).to eq('鎮守府正面海域')

      info.area_id = 1
      info.area_sub_id = 5
      expect(info.area_sub_id_to_s).to eq('1-5')

      info.area_id = 5
      info.area_sub_id = 1
      expect(info.area_sub_id_to_s).to eq('5-1')

      info.area_id = nil
      info.area_sub_id = nil
      expect(info.area_sub_id_to_s).to eq('-')
    end
  end
end
