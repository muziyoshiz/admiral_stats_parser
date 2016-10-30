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

  describe '.finished_loop_counts' do
    # まだ丙をクリアしてない場合
    it 'returns 0 when not cleared (HEI)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 1
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 1
        info.level = 'HEI'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_loop_counts(info_list, 'HEI')).to eq(0)
    end

    # 丙をクリアした場合
    it 'returns 1 when cleared once (HEI)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 1
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 1
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_loop_counts(info_list, 'HEI')).to eq(1)
    end

    # 丙2周目に入ったが、まだクリアしてない場合
    it 'returns 1 when not cleared twice (HEI)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'HEI')).to eq(2)
      expect(EventInfo.cleared_loop_counts(info_list, 'HEI')).to eq(1)
    end

    # 丙2周目をクリアしている場合
    it 'returns 2 when cleared twice (HEI)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'HEI')).to eq(2)
      expect(EventInfo.cleared_loop_counts(info_list, 'HEI')).to eq(2)
    end

    # まだ乙をクリアしてない場合
    it 'returns 0 when not cleared (OTU)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'OTU')).to eq(1)
      expect(EventInfo.cleared_loop_counts(info_list, 'OTU')).to eq(0)
    end

    # 丙をクリアした場合
    it 'returns 1 when cleared once (OTU)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 1
        info.level = 'OTU'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'OTU')).to eq(1)
      expect(EventInfo.cleared_loop_counts(info_list, 'OTU')).to eq(1)
    end

    # 丙2周目に入ったが、まだクリアしてない場合
    it 'returns 1 when not cleared twice (OTU)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 2
        info.level = 'OTU'
        info.area_clear_state = 'NOTCLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 2
        info.level = 'OTU'
        info.area_clear_state = 'NOOPEN'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'OTU')).to eq(2)
      expect(EventInfo.cleared_loop_counts(info_list, 'OTU')).to eq(1)
    end

    # 丙2周目をクリアしている場合
    it 'returns 2 when cleared twice (OTU)' do
      info_list = []

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 1
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 4
        info.loop_count = 2
        info.level = 'HEI'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 5
        info.loop_count = 2
        info.level = 'OTU'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      begin
        info = EventInfo.new
        info.area_id = 1000
        info.area_sub_id = 9
        info.loop_count = 2
        info.level = 'OTU'
        info.area_clear_state = 'CLEAR'
        info_list << info
      end

      expect(EventInfo.current_loop_counts(info_list, 'OTU')).to eq(2)
      expect(EventInfo.cleared_loop_counts(info_list, 'OTU')).to eq(2)
    end
  end
end
