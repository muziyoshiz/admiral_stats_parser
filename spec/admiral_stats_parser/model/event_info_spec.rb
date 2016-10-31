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

  # 丙 E-1 出撃前
  describe 'HEI E-0' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":1000,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":1000,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":3,"level":"HEI","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1200,"militaryGaugeLeft":1200,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":4,"level":"HEI","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":2000,"militaryGaugeLeft":2000,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":5,"level":"HEI","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":6,"level":"OTU","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":1500,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":7,"level":"OTU","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":1500,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":8,"level":"OTU","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1800,"militaryGaugeLeft":1800,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":9,"level":"OTU","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":2500,"militaryGaugeLeft":2500,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":10,"level":"OTU","areaClearState":"NOOPEN","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]

    statuses = [
        [1000, 1, "HEI", "NOTCLEAR", 1000, 1000, 1],
        [1000, 2, "HEI", "NOTCLEAR", 1000, 1000, 1],
        [1000, 3, "HEI", "NOTCLEAR", 1200, 1200, 1],
        [1000, 4, "HEI", "NOTCLEAR", 2000, 2000, 1],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 1],
        [1000, 6, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(1000)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 丙 E-1 突破後
  describe 'HEI E-1 cleared' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":1000,"bossStatus":"NONE","loopCount":1}

    statuses = [
        [1000, 1, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 2, "HEI", "NOTCLEAR", 1000, 1000, 1],
        [1000, 3, "HEI", "NOTCLEAR", 1200, 1200, 1],
        [1000, 4, "HEI", "NOTCLEAR", 2000, 2000, 1],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 1],
        [1000, 6, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(1000)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 丙 E-4 クリア直前
  describe 'HEI E-4 trying' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":3,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1200,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":4,"level":"HEI","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":2000,"militaryGaugeLeft":468,"bossStatus":"HIME","loopCount":1},

    statuses = [
        [1000, 1, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 2, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 3, "HEI", "CLEAR", 1200, 0, 1],
        [1000, 4, "HEI", "NOTCLEAR", 2000, 468, 1],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 1],
        [1000, 6, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(3)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(468)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 丙 E-4 突破後
  describe 'HEI E-4 cleared' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":3,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1200,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":4,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":2000,"militaryGaugeLeft":0,"bossStatus":"HIME","loopCount":1},
    # {"areaId":1000,"areaSubId":5,"level":"HEI","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}

    statuses = [
        [1000, 1, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 2, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 3, "HEI", "CLEAR", 1200, 0, 1],
        [1000, 4, "HEI", "CLEAR", 2000, 0, 1],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 1],
        [1000, 6, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(4)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 丙 E-5 突破後
  describe 'HEI E-5 cleared' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":3,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1200,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":4,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":2000,"militaryGaugeLeft":0,"bossStatus":"HIME","loopCount":1},
    # {"areaId":1000,"areaSubId":5,"level":"HEI","areaClearState":"NOOPEN","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":6,"level":"OTU","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":1500,"bossStatus":"NONE","loopCount":1},

    statuses = [
        [1000, 1, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 2, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 3, "HEI", "CLEAR", 1200, 0, 1],
        [1000, 4, "HEI", "CLEAR", 2000, 0, 1],
        [1000, 5, "HEI", "NOOPEN", 0, 0, 1],
        [1000, 6, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(5)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 丙2周目突入、および乙E-1クリア後
  describe 'OTU E-1 cleared' do
    # {"areaId":1000,"areaSubId":6,"level":"OTU","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":7,"level":"OTU","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":1500,"bossStatus":"NONE","loopCount":1},

    statuses = [
        [1000, 1, "HEI", "NOTCLEAR", 1000, 610, 2],
        [1000, 2, "HEI", "NOTCLEAR", 1000, 1000, 2],
        [1000, 3, "HEI", "NOTCLEAR", 1200, 1200, 2],
        [1000, 4, "HEI", "NOTCLEAR", 2000, 2000, 2],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 2],
        [1000, 6, "OTU", "CLEAR", 1500, 0, 1],
        [1000, 7, "OTU", "NOTCLEAR", 1500, 1500, 1],
        [1000, 8, "OTU", "NOTCLEAR", 1800, 1800, 1],
        [1000, 9, "OTU", "NOTCLEAR", 2500, 2500, 1],
        [1000, 10, "OTU", "NOTCLEAR", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(2)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(610)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end
  end

  # 乙E-5クリア後
  describe 'OTU E-5 cleared' do
    # {"areaId":1000,"areaSubId":6,"level":"OTU","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":7,"level":"OTU","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1500,"militaryGaugeLeft":1500,"bossStatus":"NONE","loopCount":1},

    statuses = [
        [1000, 1, "HEI", "NOTCLEAR", 1000, 610, 2],
        [1000, 2, "HEI", "NOTCLEAR", 1000, 1000, 2],
        [1000, 3, "HEI", "NOTCLEAR", 1200, 1200, 2],
        [1000, 4, "HEI", "NOTCLEAR", 2000, 2000, 2],
        [1000, 5, "HEI", "NOTCLEAR", 0, 0, 2],
        [1000, 6, "OTU", "CLEAR", 1500, 0, 1],
        [1000, 7, "OTU", "CLEAR", 1500, 0, 1],
        [1000, 8, "OTU", "CLEAR", 1800, 0, 1],
        [1000, 9, "OTU", "CLEAR", 2500, 0, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfo.current_loop_counts(event_info_list, 'HEI')).to eq(2)
      expect(EventInfo.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfo.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfo.cleared_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfo.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfo.cleared_stage_no(event_info_list, 'OTU')).to eq(5)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfo.current_military_gauge_left(event_info_list, 'HEI')).to eq(610)
      expect(EventInfo.current_military_gauge_left(event_info_list, 'OTU')).to eq(0)
    end
  end
end
