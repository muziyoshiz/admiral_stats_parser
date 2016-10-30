require 'spec_helper'

describe EventInfo do
  describe '#event_do' do
    it 'returns event number' do

      info = EventInfo.new
      info.area_id = 1000
      expect(info.event_no).to eq(1)

      info.area_id = 1001
      expect(info.event_no).to be_nil
    end
  end

  describe '#area_id_to_s' do
    it 'returns name of area' do
      info = EventInfo.new

      info.area_id = 1000
      expect(info.area_id_to_s).to eq('敵艦隊前線泊地殴り込み')

      info.area_id = 1001
      expect(info.area_id_to_s).to eq('1001')

      info.area_id = nil
      expect(info.area_id_to_s).to eq('')
    end
  end

  describe '#area_sub_id_to_s' do
    it 'returns name of sub area' do
      info = EventInfo.new

      info.area_id = 1000
      info.area_sub_id = 1
      expect(info.area_sub_id_to_s).to eq('前哨戦')

      info.area_id = nil
      info.area_sub_id = nil
      expect(info.area_sub_id_to_s).to eq('-')
    end
  end
end