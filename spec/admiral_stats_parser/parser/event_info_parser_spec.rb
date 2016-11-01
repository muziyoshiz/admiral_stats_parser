require 'spec_helper'

describe EventInfoParser do
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
        [1000, 2, "HEI", "NOOPEN", 1000, 1000, 1],
        [1000, 3, "HEI", "NOOPEN", 1200, 1200, 1],
        [1000, 4, "HEI", "NOOPEN", 2000, 2000, 1],
        [1000, 5, "HEI", "NOOPEN", 0, 0, 1],
        [1000, 6, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 7, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(1000)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be false
    end
  end

  # 丙 E-1 突破後
  describe 'HEI E-1 cleared' do
    # [{"areaId":1000,"areaSubId":1,"level":"HEI","areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},
    # {"areaId":1000,"areaSubId":2,"level":"HEI","areaClearState":"NOTCLEAR","militaryGaugeStatus":"NORMAL","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":1000,"bossStatus":"NONE","loopCount":1}

    statuses = [
        [1000, 1, "HEI", "CLEAR", 1000, 0, 1],
        [1000, 2, "HEI", "NOTCLEAR", 1000, 1000, 1],
        [1000, 3, "HEI", "NOOPEN", 1200, 1200, 1],
        [1000, 4, "HEI", "NOOPEN", 2000, 2000, 1],
        [1000, 5, "HEI", "NOOPEN", 0, 0, 1],
        [1000, 6, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 7, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(1000)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be false
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
        [1000, 5, "HEI", "NOOPEN", 0, 0, 1],
        [1000, 6, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 7, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(3)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(468)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be false
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
        [1000, 6, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 7, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(4)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be false
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
        [1000, 7, "OTU", "NOOPEN", 1500, 1500, 1],
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(5)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be true
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
        [1000, 8, "OTU", "NOOPEN", 1800, 1800, 1],
        [1000, 9, "OTU", "NOOPEN", 2500, 2500, 1],
        [1000, 10, "OTU", "NOOPEN", 0, 0, 1],
    ]

    event_info_list = []
    statuses.each do |status|
      e = EventInfo.new
      e.area_id, e.area_sub_id, e.level, e.area_clear_state, e.ene_military_gauge_val, e.military_gauge_left, e.loop_count = status
      event_info_list << e
    end

    it 'returns current_loop_counts' do
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(2)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(610)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(1500)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be true
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
      expect(EventInfoParser.current_loop_counts(event_info_list, 'HEI')).to eq(2)
      expect(EventInfoParser.current_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_loop_counts' do
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'HEI')).to eq(1)
      expect(EventInfoParser.cleared_loop_counts(event_info_list, 'OTU')).to eq(1)
    end

    it 'returns cleared_stage_no' do
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'HEI')).to eq(0)
      expect(EventInfoParser.cleared_stage_no(event_info_list, 'OTU')).to eq(5)
    end

    it 'returns current_military_gauge_left' do
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'HEI')).to eq(610)
      expect(EventInfoParser.current_military_gauge_left(event_info_list, 'OTU')).to eq(0)
    end

    it 'returns opened?' do
      expect(EventInfoParser.opened?(event_info_list, 'HEI')).to be true
      expect(EventInfoParser.opened?(event_info_list, 'OTU')).to be true
    end
  end
end