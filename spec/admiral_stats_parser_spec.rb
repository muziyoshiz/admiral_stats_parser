require 'spec_helper'

describe AdmiralStatsParser do
  it 'has a version number' do
    expect(AdmiralStatsParser::VERSION).not_to be nil
  end

  describe '.get_latest_api_version' do
    it 'returns 17' do
      expect(AdmiralStatsParser.get_latest_api_version).to eq(17)
    end
  end

  describe '.guess_api_version(exported_at)' do
    # 2016-04-26 〜 2016-06-29
    it 'returns 1' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-04-26T00:00:00+0900'))).to eq(1)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-06-30T06:59:59+0900'))).to eq(1)
    end

    # 2016-06-30（REVISION 2 のリリース日）〜 2016-09-14
    it 'returns 2' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-06-30T07:00:00+0900'))).to eq(2)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-09-15T06:59:59+0900'))).to eq(2)
    end

    # 2016-09-15 〜 2016-10-26
    it 'returns 3' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-09-15T07:00:00+0900'))).to eq(3)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-10-27T06:59:59+0900'))).to eq(3)
    end

    # 2016-10-27 〜 2016-12-20
    it 'returns 4' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-10-27T07:00:00+0900'))).to eq(4)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-12-21T06:59:59+0900'))).to eq(4)
    end

    # 2016-12-21 〜 2017-02-13
    it 'returns 5' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-12-21T07:00:00+0900'))).to eq(5)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-02-14T06:59:59+0900'))).to eq(5)
    end

    # 2017-02-14 〜 2017-04-25
    it 'returns 6' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-02-14T07:00:00+0900'))).to eq(6)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-04-26T06:59:59+0900'))).to eq(6)
    end

    # 2017-04-26 〜 2017-05-31
    it 'returns 7' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-04-26T07:00:00+0900'))).to eq(7)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-06-01T06:59:59+0900'))).to eq(7)
    end

    # 2017-06-01 〜 2017-07-30
    it 'returns 8' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-06-01T07:00:00+0900'))).to eq(8)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-07-31T06:59:59+0900'))).to eq(8)
    end

    # 2017-07-31 〜 2017-09-20
    it 'returns 9' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-07-31T07:00:00+0900'))).to eq(9)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-09-21T06:59:59+0900'))).to eq(9)
    end

    # 2017-09-21 〜 2018-01-31
    it 'returns 10' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2017-09-21T07:00:00+0900'))).to eq(10)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-02-01T06:59:59+0900'))).to eq(10)
    end

    # 2018-02-01 〜 2018-02-16
    it 'returns 11' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-02-01T07:00:00+0900'))).to eq(11)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-02-16T06:59:59+0900'))).to eq(11)
    end

    # 2018-02-16 〜 2018-04-18
    it 'returns 12' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-02-16T07:00:00+0900'))).to eq(12)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-04-19T06:59:59+0900'))).to eq(12)
    end

    # 2018-04-19 〜 2018-05-13
    it 'returns 13' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-04-19T07:00:00+0900'))).to eq(13)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-05-14T06:59:59+0900'))).to eq(13)
    end

    # 2018-05-14 〜 2018-07-23
    it 'returns 14' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-05-14T07:00:00+0900'))).to eq(14)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-07-24T06:59:59+0900'))).to eq(14)
    end

    # 2018-07-24 〜 2019-05-08
    it 'returns 15' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2018-07-24T07:00:00+0900'))).to eq(15)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2019-05-09T06:59:59+0900'))).to eq(15)
    end

    # 2019-05-09 〜 2019-07-03
    it 'returns 16' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2019-05-09T07:00:00+0900'))).to eq(16)
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2019-07-04T06:59:59+0900'))).to eq(16)
    end

    # 2019-07-04
    it 'returns 17' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2019-07-04T07:00:00+0900'))).to eq(17)
    end

    it 'returns latest version' do
      # 遠い未来の場合は、最新バージョンを返す
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2200-01-01T00:00:00+0900'))).to eq(AdmiralStatsParser.get_latest_api_version)
    end
  end

  describe '.parse_personal_basic_info(json, 1)' do
    it 'returns PersonalBasicInfo' do
      json = '{"admiralName":"ABCDEFGH","fuel":838,"ammo":974,"steel":482,"bauxite":129,"bucket":7,"level":5,"roomItemCoin":0}'
      result = AdmiralStatsParser.parse_personal_basic_info(json, 1)

      expect(result.admiral_name).to eq('ABCDEFGH')
      expect(result.fuel).to eq(838)
      expect(result.ammo).to eq(974)
      expect(result.steel).to eq(482)
      expect(result.bauxite).to eq(129)
      expect(result.bucket).to eq(7)
      expect(result.level).to eq(5)
      expect(result.room_item_coin).to eq(0)
      expect(result.result_point).to be_nil
      expect(result.rank).to be_nil
      expect(result.title_id).to be_nil
      expect(result.material_max).to be_nil
      expect(result.strategy_point).to be_nil
      expect(result.kou_medal).to be_nil
    end
  end

  describe '.parse_personal_basic_info(json_without_admiral_name, 1)' do
    it 'returns PersonalBasicInfo' do
      json = '{"fuel":838,"ammo":974,"steel":482,"bauxite":129,"bucket":7,"level":5,"roomItemCoin":0}'
      result = AdmiralStatsParser.parse_personal_basic_info(json, 1)

      expect(result.admiral_name).to be_nil
      expect(result.fuel).to eq(838)
      expect(result.ammo).to eq(974)
      expect(result.steel).to eq(482)
      expect(result.bauxite).to eq(129)
      expect(result.bucket).to eq(7)
      expect(result.level).to eq(5)
      expect(result.room_item_coin).to eq(0)
      expect(result.result_point).to be_nil
      expect(result.rank).to be_nil
      expect(result.title_id).to be_nil
      expect(result.material_max).to be_nil
      expect(result.strategy_point).to be_nil
      expect(result.kou_medal).to be_nil
    end
  end

  # 基本情報は version 2 〜 6 で仕様が同じ
  (2..6).each do |version|
    describe ".parse_personal_basic_info(json_without_admiral_name, #{version})" do
        it 'returns PersonalBasicInfo' do
        json = '{"fuel":6750,"ammo":6183,"steel":7126,"bauxite":6513,"bucket":46,"level":32,"roomItemCoin":82,"resultPoint":"3571","rank":"圏外","titleId":7,"materialMax":7200,"strategyPoint":915}'
        result = AdmiralStatsParser.parse_personal_basic_info(json, version)

        expect(result.admiral_name).to be_nil
        expect(result.fuel).to eq(6750)
        expect(result.ammo).to eq(6183)
        expect(result.steel).to eq(7126)
        expect(result.bauxite).to eq(6513)
        expect(result.bucket).to eq(46)
        expect(result.level).to eq(32)
        expect(result.room_item_coin).to eq(82)
        expect(result.result_point).to eq('3571')
        expect(result.rank).to eq('圏外')
        expect(result.title_id).to eq(7)
        expect(result.material_max).to eq(7200)
        expect(result.strategy_point).to eq(915)
        expect(result.kou_medal).to be_nil
      end
    end

    describe ".parse_personal_basic_info(json, #{version})" do
      it 'returns PersonalBasicInfo' do
        json = '{"admiralName":"ABCDEFGH","fuel":6750,"ammo":6183,"steel":7126,"bauxite":6513,"bucket":46,"level":32,"roomItemCoin":82,"resultPoint":"3571","rank":"圏外","titleId":7,"materialMax":7200,"strategyPoint":915}'
        result = AdmiralStatsParser.parse_personal_basic_info(json, version)

        expect(result.admiral_name).to eq('ABCDEFGH')
        expect(result.fuel).to eq(6750)
        expect(result.ammo).to eq(6183)
        expect(result.steel).to eq(7126)
        expect(result.bauxite).to eq(6513)
        expect(result.bucket).to eq(46)
        expect(result.level).to eq(32)
        expect(result.room_item_coin).to eq(82)
        expect(result.result_point).to eq('3571')
        expect(result.rank).to eq('圏外')
        expect(result.title_id).to eq(7)
        expect(result.material_max).to eq(7200)
        expect(result.strategy_point).to eq(915)
        expect(result.kou_medal).to be_nil
      end
    end
  end

  # 基本情報は version 7 で「甲種勲章の数」が追加された
  # version 7 〜 で仕様が同じ
  (7..17).each do |version|
    describe ".parse_personal_basic_info(json_without_admiral_name, #{version})" do
      it 'returns PersonalBasicInfo' do
        json = File.open('spec/fixtures/v7/Personal_basicInfo_without_admiralName.json').read
        result = AdmiralStatsParser.parse_personal_basic_info(json, version)

        expect(result.admiral_name).to be_nil
        expect(result.fuel).to eq(18600)
        expect(result.ammo).to eq(18601)
        expect(result.steel).to eq(18602)
        expect(result.bauxite).to eq(17947)
        expect(result.bucket).to eq(397)
        expect(result.level).to eq(89)
        expect(result.room_item_coin).to eq(1226)
        expect(result.result_point).to eq('2944')
        expect(result.rank).to eq('圏外')
        expect(result.title_id).to eq(7)
        expect(result.material_max).to eq(18600)
        expect(result.strategy_point).to eq(9705)
        expect(result.kou_medal).to eq(0)
      end
    end

    describe ".parse_personal_basic_info(json, #{version})" do
      it 'returns PersonalBasicInfo' do
        json = File.open('spec/fixtures/v7/Personal_basicInfo.json').read
        result = AdmiralStatsParser.parse_personal_basic_info(json, version)

        expect(result.admiral_name).to eq('ムジ')
        expect(result.fuel).to eq(18600)
        expect(result.ammo).to eq(18601)
        expect(result.steel).to eq(18602)
        expect(result.bauxite).to eq(17947)
        expect(result.bucket).to eq(397)
        expect(result.level).to eq(89)
        expect(result.room_item_coin).to eq(1226)
        expect(result.result_point).to eq('2944')
        expect(result.rank).to eq('圏外')
        expect(result.title_id).to eq(7)
        expect(result.material_max).to eq(18600)
        expect(result.strategy_point).to eq(9705)
        expect(result.kou_medal).to eq(0)
      end
    end
  end

  describe '.parse_area_capture_info(json, 1)' do
    it 'returns AreaCaptureInfo[]' do
      json = '[{"areaId":1,"areaSubId":4,"limitSec":330,"pursuitMap":false,"pursuitMapOpen":false,"stageImageName":"area_0c6tpjoayu.png","stageMissionName":"南１号作戦","stageMissionInfo":"南西諸島の防衛ライン上の敵侵攻艦隊を捕捉、全力出撃でこれを撃滅せよ！","stageClearItemInfo":"MEISTER","stageDropItemInfo":["BUCKET","SMALLBOX","SMALLREC","NONE"],"areaClearState":"NOTCLEAR"},{"areaId":2,"areaSubId":1,"limitSec":0,"pursuitMap":false,"pursuitMapOpen":false,"stageImageName":"area_8nzeirxrui.png","stageMissionName":"？","stageMissionInfo":"？","stageClearItemInfo":"UNKNOWN","stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"areaClearState":"NOOPEN"}]'

      results = AdmiralStatsParser.parse_area_capture_info(json, 1)

      expect(results.size).to eq(2)

      result = results[0]
      expect(result.area_id).to eq(1)
      expect(result.area_sub_id).to eq(4)
      expect(result.limit_sec).to eq(330)
      expect(result.require_gp).to be_nil
      expect(result.pursuit_map).to eq(false)
      expect(result.pursuit_map_open).to eq(false)
      expect(result.sortie_limit).to be_nil
      expect(result.stage_image_name).to eq('area_0c6tpjoayu.png')
      expect(result.stage_mission_name).to eq('南１号作戦')
      expect(result.stage_mission_info).to eq('南西諸島の防衛ライン上の敵侵攻艦隊を捕捉、全力出撃でこれを撃滅せよ！')
      expect(result.stage_clear_item_info).to eq('MEISTER')
      expect(result.stage_drop_item_info).to eq(['BUCKET', 'SMALLBOX', 'SMALLREC', 'NONE'])
      expect(result.area_clear_state).to eq('NOTCLEAR')

      result = results[1]
      expect(result.area_id).to eq(2)
      expect(result.area_sub_id).to eq(1)
      expect(result.limit_sec).to eq(0)
      expect(result.require_gp).to be_nil
      expect(result.pursuit_map).to eq(false)
      expect(result.pursuit_map_open).to eq(false)
      expect(result.sortie_limit).to be_nil
      expect(result.stage_image_name).to eq('area_8nzeirxrui.png')
      expect(result.stage_mission_name).to eq('？')
      expect(result.stage_mission_info).to eq('？')
      expect(result.stage_clear_item_info).to eq('UNKNOWN')
      expect(result.stage_drop_item_info).to eq(['UNKNOWN', 'NONE', 'NONE', 'NONE'])
      expect(result.area_clear_state).to eq('NOOPEN')
    end
  end

  # 海域情報は version 2 〜 6 で仕様が同じ
  (2..6).each do |version|
    describe ".parse_area_capture_info(json, #{version})" do
      it 'returns AreaCaptureInfo[]' do
        json = '[{"areaId":1,"areaSubId":1,"limitSec":150,"requireGp":150,"pursuitMap":false,"pursuitMapOpen":true,"sortieLimit":false,"stageImageName":"area_rprx04hjnl.png","stageMissionName":"近海警備","stageMissionInfo":"鎮守府正面近海の警備に出動せよ！","stageClearItemInfo":"MEISTER","stageDropItemInfo":["BUCKET","NONE","NONE","NONE"],"areaClearState":"CLEAR"},{"areaId":1,"areaSubId":1,"limitSec":90,"requireGp":100,"pursuitMap":true,"pursuitMapOpen":false,"sortieLimit":false,"stageImageName":"area_rprx04hjnl.png","stageMissionName":"近海警備","stageMissionInfo":"鎮守府正面近海の敵艦隊を追撃せよ！","stageClearItemInfo":"NONE","stageDropItemInfo":["NONE","NONE","NONE","NONE"],"areaClearState":"CLEAR"}]'

        results = AdmiralStatsParser.parse_area_capture_info(json, version)

        expect(results.size).to eq(2)

        result = results[0]
        expect(result.area_id).to eq(1)
        expect(result.area_sub_id).to eq(1)
        expect(result.limit_sec).to eq(150)
        expect(result.require_gp).to eq(150)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(true)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_rprx04hjnl.png')
        expect(result.stage_mission_name).to eq('近海警備')
        expect(result.stage_mission_info).to eq('鎮守府正面近海の警備に出動せよ！')
        expect(result.stage_clear_item_info).to eq('MEISTER')
        expect(result.stage_drop_item_info).to eq(['BUCKET', 'NONE', 'NONE', 'NONE'])
        expect(result.area_clear_state).to eq('CLEAR')

        result = results[1]
        expect(result.area_id).to eq(1)
        expect(result.area_sub_id).to eq(1)
        expect(result.limit_sec).to eq(90)
        expect(result.require_gp).to eq(100)
        expect(result.pursuit_map).to eq(true)
        expect(result.pursuit_map_open).to eq(false)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_rprx04hjnl.png')
        expect(result.stage_mission_name).to eq('近海警備')
        expect(result.stage_mission_info).to eq('鎮守府正面近海の敵艦隊を追撃せよ！')
        expect(result.stage_clear_item_info).to eq('NONE')
        expect(result.stage_drop_item_info).to eq(['NONE', 'NONE', 'NONE', 'NONE'])
        expect(result.area_clear_state).to eq('CLEAR')
      end
    end
  end

  # 海域情報は version 7 から bossStatus が追加された？（もっと前からかもしれない）
  # version 7 〜 10 で仕様が同じ
  (7..10).each do |version|
    describe ".parse_area_capture_info(json, #{version})" do
      it 'returns AreaCaptureInfo[]' do
        json = File.open('spec/fixtures/v7/Area_captureInfo.json').read
        results = AdmiralStatsParser.parse_area_capture_info(json, version)

        expect(results.size).to eq(21)

        # 1-1
        result = results[0]
        expect(result.area_id).to eq(1)
        expect(result.area_sub_id).to eq(1)
        expect(result.limit_sec).to eq(150)
        expect(result.require_gp).to eq(150)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(false)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_rprx04hjnl.png')
        expect(result.stage_mission_name).to eq('近海警備')
        expect(result.stage_mission_info).to eq('鎮守府正面近海の警備に出動せよ！')
        expect(result.stage_clear_item_info).to eq('MEISTER')
        expect(result.stage_drop_item_info).to eq(['BUCKET', 'NONE', 'NONE', 'NONE'])
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.boss_info).to be_nil

        # 4-4 (bossInfoがある)
        result = results[19]
        expect(result.area_id).to eq(4)
        expect(result.area_sub_id).to eq(4)
        expect(result.limit_sec).to eq(390)
        expect(result.require_gp).to eq(450)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(true)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_rwcr2jocm4.png')
        expect(result.stage_mission_name).to eq('カスガダマ沖海戦')
        expect(result.stage_mission_info).to eq('カレー洋西方の敵哨戒線を突破、カスガダマ島沖へ侵攻し、敵東方艦隊の中枢部隊を撃滅せよ！')
        expect(result.stage_clear_item_info).to eq('MEISTER')
        expect(result.stage_drop_item_info).to eq(['BUCKET', 'SMALLBOX', 'MEDIUMBOX', 'NONE'])
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.boss_info.military_gauge_status).to eq('BREAK')
        expect(result.boss_info.ene_military_gauge_val).to eq(4500)
        expect(result.boss_info.military_gauge_left).to eq(0)
        expect(result.boss_info.boss_status).to eq('FORM_1')
      end
    end
  end

  # version 11 から、1海域にルートが2個あるパターンが登場した
  (11..17).each do |version|
    describe ".parse_area_capture_info(json, #{version})" do
      it 'returns AreaCaptureInfo[]' do
        json = File.open('spec/fixtures/v11/Area_captureInfo.json').read
        results = AdmiralStatsParser.parse_area_capture_info(json, version)

        expect(results.size).to eq(22)

        # 1-1
        result = results[0]
        expect(result.area_id).to eq(1)
        expect(result.area_sub_id).to eq(1)
        expect(result.limit_sec).to eq(150)
        expect(result.require_gp).to eq(150)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(false)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_rprx04hjnl.png')
        expect(result.stage_mission_name).to eq('近海警備')
        expect(result.stage_mission_info).to eq('鎮守府正面近海の警備に出動せよ！')
        expect(result.stage_clear_item_info).to eq('MEISTER')
        expect(result.stage_drop_item_info).to eq(['BUCKET', 'NONE', 'NONE', 'NONE'])
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.boss_info).to be_nil
        expect(result.route).to be_nil

        # 5-3 (450GP)
        result = results[20]
        expect(result.area_id).to eq(5)
        expect(result.area_sub_id).to eq(3)
        expect(result.limit_sec).to eq(390)
        expect(result.require_gp).to eq(450)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(false)
        expect(result.sortie_limit).to eq(false)
        expect(result.stage_image_name).to eq('area_54gzha5h03.png')
        expect(result.stage_mission_name).to eq('第一次サーモン沖海戦')
        expect(result.stage_mission_info).to eq('敵泊地に対して夜戦突撃を敢行し、敵主力艦隊を叩け！')
        expect(result.stage_clear_item_info).to eq('NONE')
        expect(result.stage_drop_item_info).to eq(['BUCKET', 'SMALLBOX', 'MEDIUMBOX', 'NONE'])
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.boss_info.military_gauge_status).to eq('NORMAL')
        expect(result.boss_info.ene_military_gauge_val).to eq(4000)
        expect(result.boss_info.military_gauge_left).to eq(1000)
        expect(result.boss_info.boss_status).to eq('NONE')
        expect(result.route).to eq('ROUTE_A')

        # 5-3 (350GP)
        result = results[21]
        expect(result.area_id).to eq(5)
        expect(result.area_sub_id).to eq(3)
        expect(result.limit_sec).to eq(270)
        expect(result.require_gp).to eq(350)
        expect(result.pursuit_map).to eq(false)
        expect(result.pursuit_map_open).to eq(false)
        expect(result.sortie_limit).to eq(true)
        expect(result.stage_image_name).to eq('area_54gzha5h03_2.png')
        expect(result.stage_mission_name).to eq('第一次サーモン沖海戦')
        expect(result.stage_mission_info).to eq('敵戦力が集結する泊地に対し、夜戦突撃を速やかに敢行せよ！')
        expect(result.stage_clear_item_info).to eq('NONE')
        expect(result.stage_drop_item_info).to eq(['SMALLBOX', 'MEDIUMBOX', 'LARGEBOX', 'NONE'])
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.boss_info.military_gauge_status).to eq('NORMAL')
        expect(result.boss_info.ene_military_gauge_val).to eq(4000)
        expect(result.boss_info.military_gauge_left).to eq(1000)
        expect(result.boss_info.boss_status).to eq('NONE')
        expect(result.route).to eq('ROUTE_B')
      end
    end
  end

  describe '.parse_tc_book_info(json, 1)' do
    it 'returns TcBookInfo[]' do
      json = '[{"bookNo":1,"shipClass":"","shipClassIndex":-1,"shipType":"","shipName":"未取得","cardIndexImg":"","cardImgList":[],"variationNum":0,"acquireNum":0},{"bookNo":2,"shipClass":"長門型","shipClassIndex":2,"shipType":"戦艦","shipName":"陸奥","cardIndexImg":"s/tc_2_tjpm66z1epc6.jpg","cardImgList":["s/tc_2_tjpm66z1epc6.jpg","","","","",""],"variationNum":6,"acquireNum":1}]'

      results = AdmiralStatsParser.parse_tc_book_info(json, 1)

      expect(results.size).to eq(2)

      result = results[0]
      expect(result.book_no).to eq(1)
      expect(result.ship_class).to eq('')
      expect(result.ship_class_index).to eq(-1)
      expect(result.ship_type).to eq('')
      expect(result.ship_name).to eq('未取得')
      expect(result.card_index_img).to eq('')
      expect(result.card_img_list).to eq([])
      expect(result.variation_num).to eq(0)
      expect(result.acquire_num).to eq(0)
      expect(result.lv).to be_nil
      expect(result.status_img).to be_nil

      result = results[1]
      expect(result.book_no).to eq(2)
      expect(result.ship_class).to eq('長門型')
      expect(result.ship_class_index).to eq(2)
      expect(result.ship_type).to eq('戦艦')
      expect(result.ship_name).to eq('陸奥')
      expect(result.card_index_img).to eq('s/tc_2_tjpm66z1epc6.jpg')
      expect(result.card_img_list).to eq(['s/tc_2_tjpm66z1epc6.jpg','','','','',''])
      expect(result.variation_num).to eq(6)
      expect(result.acquire_num).to eq(1)
      expect(result.lv).to be_nil
      expect(result.status_img).to be_nil
    end
  end

  # 艦娘図鑑は version 2 〜 11 で仕様が同じ
  (2..11).each do |version|
    describe ".parse_tc_book_info(json, #{version})" do
      it 'returns TcBookInfo[]' do
        json = '[{"bookNo":1,"shipClass":"長門型","shipClassIndex":1,"shipType":"戦艦","shipName":"長門","cardIndexImg":"s/tc_1_d7ju63kolamj.jpg","cardImgList":["","","s/tc_1_gk42czm42s3p.jpg","","",""],"variationNum":6,"acquireNum":1,"lv":23,"statusImg":["i/i_d7ju63kolamj_n.png"]},{"bookNo":5,"shipClass":"","shipClassIndex":-1,"shipType":"","shipName":"未取得","cardIndexImg":"","cardImgList":[],"variationNum":0,"acquireNum":0,"lv":0,"statusImg":[]}]'

        results = AdmiralStatsParser.parse_tc_book_info(json, version)

        expect(results.size).to eq(2)

        result = results[0]
        expect(result.book_no).to eq(1)
        expect(result.ship_class).to eq('長門型')
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_type).to eq('戦艦')
        expect(result.ship_name).to eq('長門')
        expect(result.card_index_img).to eq('s/tc_1_d7ju63kolamj.jpg')
        expect(result.card_img_list).to eq(['','','s/tc_1_gk42czm42s3p.jpg','','',''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(1)
        expect(result.lv).to eq(23)
        expect(result.status_img).to eq(['i/i_d7ju63kolamj_n.png'])

        result = results[1]
        expect(result.book_no).to eq(5)
        expect(result.ship_class).to eq('')
        expect(result.ship_class_index).to eq(-1)
        expect(result.ship_type).to eq('')
        expect(result.ship_name).to eq('未取得')
        expect(result.card_index_img).to eq('')
        expect(result.card_img_list).to eq([])
        expect(result.variation_num).to eq(0)
        expect(result.acquire_num).to eq(0)
        expect(result.lv).to eq(0)
        expect(result.status_img).to eq([])
      end
    end
  end

  # version 12 から、艦娘図鑑にケッコンカッコカリの情報が追加された
  (12..13).each do |version|
    describe ".parse_tc_book_info(json, #{version})" do
      it 'returns TcBookInfo[]' do
        # 注意：未取得のデータには isMarried および marriedImg キーがない
        json = File.open('spec/fixtures/v12/TcBook_info.json').read

        results = AdmiralStatsParser.parse_tc_book_info(json, version)

        expect(results.size).to eq(2)

        result = results[0]
        expect(result.book_no).to eq(1)
        expect(result.ship_class).to eq('長門型')
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_type).to eq('戦艦')
        expect(result.ship_name).to eq('長門')
        expect(result.card_index_img).to eq('s/tc_1_d7ju63kolamj.jpg')
        expect(result.card_img_list).to eq(['','','s/tc_1_gk42czm42s3p.jpg','','',''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(1)
        expect(result.lv).to eq(23)
        expect(result.status_img).to eq(['i/i_d7ju63kolamj_n.png'])
        expect(result.is_married).to eq([false, true])
        expect(result.married_img).to eq([''])

        result = results[1]
        expect(result.book_no).to eq(5)
        expect(result.ship_class).to eq('')
        expect(result.ship_class_index).to eq(-1)
        expect(result.ship_type).to eq('')
        expect(result.ship_name).to eq('未取得')
        expect(result.card_index_img).to eq('')
        expect(result.card_img_list).to eq([])
        expect(result.variation_num).to eq(0)
        expect(result.acquire_num).to eq(0)
        expect(result.lv).to eq(0)
        expect(result.status_img).to eq([])
        expect(result.is_married).to be_nil
        expect(result.married_img).to be_nil
      end
    end
  end

  # version 14 から、艦番号が必須ではなくなった
  (14..16).each do |version|
    describe ".parse_tc_book_info(json, #{version})" do
      it 'returns TcBookInfo[]' do
        # 注意：未取得のデータには isMarried および marriedImg キーがない
        # 注意(2)：まるゆには cardIndexImg キーがない
        json = File.open('spec/fixtures/v14/TcBook_info.json').read

        results = AdmiralStatsParser.parse_tc_book_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.book_no).to eq(1)
        expect(result.ship_class).to eq('長門型')
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_type).to eq('戦艦')
        expect(result.ship_name).to eq('長門')
        expect(result.card_index_img).to eq('s/tc_1_d7ju63kolamj.jpg')
        expect(result.card_img_list).to eq(['','','s/tc_1_gk42czm42s3p.jpg','','',''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(1)
        expect(result.lv).to eq(23)
        expect(result.status_img).to eq(['i/i_d7ju63kolamj_n.png'])
        expect(result.is_married).to eq([false, true])
        expect(result.married_img).to eq([''])

        result = results[1]
        expect(result.book_no).to eq(5)
        expect(result.ship_class).to eq('')
        expect(result.ship_class_index).to eq(-1)
        expect(result.ship_type).to eq('')
        expect(result.ship_name).to eq('未取得')
        expect(result.card_index_img).to eq('')
        expect(result.card_img_list).to eq([])
        expect(result.variation_num).to eq(0)
        expect(result.acquire_num).to eq(0)
        expect(result.lv).to eq(0)
        expect(result.status_img).to eq([])
        expect(result.is_married).to be_nil
        expect(result.married_img).to be_nil

        result = results[2]
        expect(result.book_no).to eq(163)
        expect(result.ship_class).to eq('三式潜航輸送艇')
        expect(result.ship_class_index).to be_nil
        expect(result.ship_type).to eq('潜水艦')
        expect(result.ship_name).to eq('まるゆ')
        expect(result.card_index_img).to eq('s/tc_163_4ecmr9qtz4kd.jpg')
        expect(result.card_img_list).to eq(['s/tc_163_4ecmr9qtz4kd.jpg', '', '', '', '', ''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(1)
        expect(result.lv).to eq(3)
        expect(result.status_img).to eq(['i/i_rjdnpze1x0gn_n.png', ''])
        expect(result.is_married).to eq([false, false])
        expect(result.married_img).to eq([''])
      end
    end
  end

  # version 17 から、"cardList" 以下に情報がまとめられた
  [17].each do |version|
    describe ".parse_tc_book_info(json, #{version})" do
      it 'returns TcBookInfo[]' do
        # 注意：未取得のデータには isMarried および marriedImg キーがない
        # 注意(2)：まるゆには cardIndexImg キーがない
        json = File.open('spec/fixtures/v17/TcBook_info.json').read

        results = AdmiralStatsParser.parse_tc_book_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.book_no).to eq(1)
        expect(result.ship_class).to eq('長門型')
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_type).to eq('戦艦')
        expect(result.ship_name).to eq('長門')
        expect(result.card_index_img).to eq('s/tc_1_d7ju63kolamj.jpg')
        expect(result.card_img_list).to eq(['s/tc_1_d7ju63kolamj.jpg','','s/tc_1_gk42czm42s3p.jpg','s/tc_1_2wp6daq4fn42.jpg','',''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(3)
        expect(result.lv).to eq(83)
        expect(result.status_img).to eq(['i/i_d7ju63kolamj_n.png', 'i/i_2wp6daq4fn42_n.png'])
        expect(result.is_married).to eq([false, false])
        expect(result.married_img).to eq(['', ''])

        result = results[1]
        expect(result.book_no).to eq(5)
        expect(result.ship_class).to eq('')
        expect(result.ship_class_index).to eq(-1)
        expect(result.ship_type).to eq('')
        expect(result.ship_name).to eq('未取得')
        expect(result.card_index_img).to eq('')
        expect(result.card_img_list).to eq([])
        expect(result.variation_num).to eq(0)
        expect(result.acquire_num).to eq(0)
        expect(result.lv).to eq(0)
        expect(result.status_img).to eq([])
        expect(result.is_married).to be_nil
        expect(result.married_img).to be_nil

        result = results[2]
        expect(result.book_no).to eq(163)
        expect(result.ship_class).to eq('三式潜航輸送艇')
        expect(result.ship_class_index).to be_nil
        expect(result.ship_type).to eq('潜水艦')
        expect(result.ship_name).to eq('まるゆ')
        expect(result.card_index_img).to eq('s/tc_163_4ecmr9qtz4kd.jpg')
        expect(result.card_img_list).to eq(['s/tc_163_4ecmr9qtz4kd.jpg', '', '', 's/tc_163_sa64c6de4sjg.jpg', '', ''])
        expect(result.variation_num).to eq(6)
        expect(result.acquire_num).to eq(2)
        expect(result.lv).to eq(10)
        expect(result.status_img).to eq(['i/i_rjdnpze1x0gn_n.png', 'i/i_xu9t41r7weaa_n.png'])
        expect(result.is_married).to eq([false, false])
        expect(result.married_img).to eq(['', ''])
      end
    end
  end

  # 装備図鑑は version 1 〜 で仕様が同じ
  (1..17).each do |version|
    describe ".parse_equip_book_info(json, #{version})" do
      it 'returns EquipBookInfo[]' do
        json = '[{"bookNo":1,"equipKind":"小口径主砲","equipName":"12cm単装砲","equipImg":"e/equip_1_3315nm5166d.png"},{"bookNo":2,"equipKind":"小口径主砲","equipName":"12.7cm連装砲","equipImg":"e/equip_2_fon8wsqc5sn.png"},{"bookNo":3,"equipKind":"","equipName":"","equipImg":""},{"bookNo":4,"equipKind":"中口径主砲","equipName":"14cm単装砲","equipImg":"e/equip_4_8tzid3z8li7.png"}]'

        results = AdmiralStatsParser.parse_equip_book_info(json, version)

        expect(results.size).to eq(4)

        result = results[0]
        expect(result.book_no).to eq(1)
        expect(result.equip_kind).to eq('小口径主砲')
        expect(result.equip_name).to eq('12cm単装砲')
        expect(result.equip_img).to eq('e/equip_1_3315nm5166d.png')

        result = results[1]
        expect(result.book_no).to eq(2)
        expect(result.equip_kind).to eq('小口径主砲')
        expect(result.equip_name).to eq('12.7cm連装砲')
        expect(result.equip_img).to eq('e/equip_2_fon8wsqc5sn.png')

        result = results[2]
        expect(result.book_no).to eq(3)
        expect(result.equip_kind).to eq('')
        expect(result.equip_name).to eq('')
        expect(result.equip_img).to eq('')

        result = results[3]
        expect(result.book_no).to eq(4)
        expect(result.equip_kind).to eq('中口径主砲')
        expect(result.equip_name).to eq('14cm単装砲')
        expect(result.equip_img).to eq('e/equip_4_8tzid3z8li7.png')
      end
    end
  end

  describe '.parse_character_list_info(json, 1)' do
    it 'raises' do
      json = '[{"bookNo":11,"lv":20,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"吹雪","statusImg":"i/i_u6jw00e3ey3p_n.png"},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"朝潮","statusImg":"i/i_69ex6r4uutp3_n.png"},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":1,"shipName":"朝潮改","statusImg":"i/i_umacfn9qcwp1_n.png"}]'

      expect { AdmiralStatsParser.parse_character_list_info(json, 1) }.to raise_error('API version 1 does not support character list info')
    end
  end

  describe '.parse_character_list_info(json, 2)' do
    it 'returns CharacterListInfo[]' do
      json = '[{"bookNo":11,"lv":20,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"吹雪","statusImg":"i/i_u6jw00e3ey3p_n.png"},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"朝潮","statusImg":"i/i_69ex6r4uutp3_n.png"},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":1,"shipName":"朝潮改","statusImg":"i/i_umacfn9qcwp1_n.png"}]'

      results = AdmiralStatsParser.parse_character_list_info(json, 2)

      expect(results.size).to eq(3)

      result = results[0]
      expect(result.book_no).to eq(11)
      expect(result.lv).to eq(20)
      expect(result.ship_type).to eq('駆逐艦')
      expect(result.ship_sort_no).to eq(1800)
      expect(result.remodel_lv).to eq(0)
      expect(result.ship_name).to eq('吹雪')
      expect(result.status_img).to eq('i/i_u6jw00e3ey3p_n.png')

      result = results[1]
      expect(result.book_no).to eq(85)
      expect(result.lv).to eq(36)
      expect(result.ship_type).to eq('駆逐艦')
      expect(result.ship_sort_no).to eq(1800)
      expect(result.remodel_lv).to eq(0)
      expect(result.ship_name).to eq('朝潮')
      expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')

      result = results[2]
      expect(result.book_no).to eq(85)
      expect(result.lv).to eq(36)
      expect(result.ship_type).to eq('駆逐艦')
      expect(result.ship_sort_no).to eq(1800)
      expect(result.remodel_lv).to eq(1)
      expect(result.ship_name).to eq('朝潮改')
      expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
    end
  end

  # 艦娘一覧は version 3 〜 4 で仕様が同じ
  (3..4).each do |version|
    describe ".parse_character_list_info(json, #{version})" do
      it 'returns CharacterListInfo[]' do
        json = '[{"bookNo":11,"lv":20,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"吹雪","statusImg":"i/i_u6jw00e3ey3p_n.png","starNum":1},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"朝潮","statusImg":"i/i_69ex6r4uutp3_n.png","starNum":5},{"bookNo":85,"lv":36,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":1,"shipName":"朝潮改","statusImg":"i/i_umacfn9qcwp1_n.png","starNum":3}]'

        results = AdmiralStatsParser.parse_character_list_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.book_no).to eq(11)
        expect(result.lv).to eq(20)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('吹雪')
        expect(result.status_img).to eq('i/i_u6jw00e3ey3p_n.png')
        expect(result.star_num).to eq(1)

        result = results[1]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(36)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.star_num).to eq(5)

        result = results[2]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(36)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('朝潮改')
        expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
        expect(result.star_num).to eq(3)
      end
    end
  end

  # 艦娘一覧は、version 5 で各艦娘が装備中のアイテムが追加された
  (5..6).each do |version|
    describe ".parse_character_list_info(json, #{version})" do
      it 'returns CharacterListInfo[]' do
        # 朝潮、朝潮改、鈴谷、鈴谷改のデータ
        json = <<-'EOS'
  [{"bookNo":85,"lv":97,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":0,"shipName":"朝潮","statusImg":"i/i_69ex6r4uutp3_n.png","starNum":5,"shipClass":"朝潮型","shipClassIndex":1,"tcImg":"s/tc_85_69ex6r4uutp3.jpg","expPercent":97,"maxHp":16,"realHp":16,"damageStatus":"NORMAL","slotNum":2,"slotEquipName":["","","",""],"slotAmount":[0,0,0,0],"slotDisp":["NONE","NONE","NONE","NONE"],"slotImg":["","","",""]},{"bookNo":85,"lv":97,"shipType":"駆逐艦","shipSortNo":1800,"remodelLv":1,"shipName":"朝潮改","statusImg":"i/i_umacfn9qcwp1_n.png","starNum":5,"shipClass":"朝潮型","shipClassIndex":1,"tcImg":"s/tc_85_umacfn9qcwp1.jpg","expPercent":97,"maxHp":31,"realHp":31,"damageStatus":"NORMAL","slotNum":3,"slotEquipName":["10cm高角砲＋高射装置","10cm高角砲＋高射装置","61cm四連装(酸素)魚雷",""],"slotAmount":[0,0,0,0],"slotDisp":["NONE","NONE","NONE","NONE"],"slotImg":["equip_icon_26_rv74l134q7an.png","equip_icon_26_rv74l134q7an.png","equip_icon_5_c4bcdscek33o.png",""]},{"bookNo":124,"lv":70,"shipType":"重巡洋艦","shipSortNo":1500,"remodelLv":0,"shipName":"鈴谷","statusImg":"i/i_zrr1yq3annrq_n.png","starNum":5,"shipClass":"最上型","shipClassIndex":3,"tcImg":"s/tc_124_2uejd60gndj3.jpg","expPercent":4,"maxHp":40,"realHp":40,"damageStatus":"NORMAL","slotNum":3,"slotEquipName":["","","",""],"slotAmount":[2,2,2,0],"slotDisp":["NOT_EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT","NONE"],"slotImg":["","","",""]},{"bookNo":129,"lv":70,"shipType":"航空巡洋艦","shipSortNo":1400,"remodelLv":1,"shipName":"鈴谷改","statusImg":"i/i_6cc94esr14nz_n.png","starNum":5,"shipClass":"最上型","shipClassIndex":3,"tcImg":"s/tc_129_7k4atc4mguna.jpg","expPercent":4,"maxHp":50,"realHp":50,"damageStatus":"NORMAL","slotNum":4,"slotEquipName":["20.3cm(3号)連装砲","瑞雲","15.5cm三連装副砲","三式弾"],"slotAmount":[5,6,5,6],"slotDisp":["NOT_EQUIPPED_AIRCRAFT","EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT"],"slotImg":["equip_icon_2_n8b0sex6xclf.png","equip_icon_10_lpoysb3zk6s4.png","equip_icon_4_mgy58yrghven.png","equip_icon_13_jdkmrexetpvn.png"]}]
        EOS

        results = AdmiralStatsParser.parse_character_list_info(json, version)

        expect(results.size).to eq(4)

        result = results[0]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(97)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_69ex6r4uutp3.jpg')
        expect(result.exp_percent).to eq(97)
        expect(result.max_hp).to eq(16)
        expect(result.real_hp).to eq(16)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to be_nil
        expect(result.married).to be_nil

        result = results[1]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(97)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('朝潮改')
        expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_umacfn9qcwp1.jpg')
        expect(result.exp_percent).to eq(97)
        expect(result.max_hp).to eq(31)
        expect(result.real_hp).to eq(31)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['10cm高角砲＋高射装置', '10cm高角砲＋高射装置', '61cm四連装(酸素)魚雷', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['equip_icon_26_rv74l134q7an.png', 'equip_icon_26_rv74l134q7an.png', 'equip_icon_5_c4bcdscek33o.png', ''])
        expect(result.blueprint_total_num).to be_nil
        expect(result.married).to be_nil

        result = results[2]
        expect(result.book_no).to eq(124)
        expect(result.lv).to eq(70)
        expect(result.ship_type).to eq('重巡洋艦')
        expect(result.ship_sort_no).to eq(1500)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('鈴谷')
        expect(result.status_img).to eq('i/i_zrr1yq3annrq_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('最上型')
        expect(result.ship_class_index).to eq(3)
        expect(result.tc_img).to eq('s/tc_124_2uejd60gndj3.jpg')
        expect(result.exp_percent).to eq(4)
        expect(result.max_hp).to eq(40)
        expect(result.real_hp).to eq(40)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([2, 2, 2, 0])
        expect(result.slot_disp).to eq(%w(NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to be_nil
        expect(result.married).to be_nil

        # {"bookNo":129,"lv":70,"shipType":"航空巡洋艦","shipSortNo":1400,"remodelLv":1,"shipName":"鈴谷改",
        # "statusImg":"i/i_6cc94esr14nz_n.png","starNum":5,"shipClass":"最上型","shipClassIndex":3,
        # "tcImg":"s/tc_129_7k4atc4mguna.jpg","expPercent":4,"maxHp":50,"realHp":50,"damageStatus":"NORMAL",
        # "slotNum":4,"slotEquipName":["20.3cm(3号)連装砲","瑞雲","15.5cm三連装副砲","三式弾"],"slotAmount":[5,6,5,6],
        # "slotDisp":["NOT_EQUIPPED_AIRCRAFT","EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT","NOT_EQUIPPED_AIRCRAFT"],
        # "slotImg":["equip_icon_2_n8b0sex6xclf.png","equip_icon_10_lpoysb3zk6s4.png","equip_icon_4_mgy58yrghven.png","equip_icon_13_jdkmrexetpvn.png"]}]
        result = results[3]
        expect(result.book_no).to eq(129)
        expect(result.lv).to eq(70)
        expect(result.ship_type).to eq('航空巡洋艦')
        expect(result.ship_sort_no).to eq(1400)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('鈴谷改')
        expect(result.status_img).to eq('i/i_6cc94esr14nz_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('最上型')
        expect(result.ship_class_index).to eq(3)
        expect(result.tc_img).to eq('s/tc_129_7k4atc4mguna.jpg')
        expect(result.exp_percent).to eq(4)
        expect(result.max_hp).to eq(50)
        expect(result.real_hp).to eq(50)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(4)
        expect(result.slot_equip_name).to eq(%w(20.3cm(3号)連装砲 瑞雲 15.5cm三連装副砲 三式弾))
        expect(result.slot_amount).to eq([5, 6, 5, 6])
        expect(result.slot_disp).to eq(%w(NOT_EQUIPPED_AIRCRAFT EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT))
        expect(result.slot_img).to eq(%w(equip_icon_2_n8b0sex6xclf.png equip_icon_10_lpoysb3zk6s4.png equip_icon_4_mgy58yrghven.png equip_icon_13_jdkmrexetpvn.png))
        expect(result.blueprint_total_num).to be_nil
        expect(result.married).to be_nil
      end
    end
  end

  # 艦娘一覧は、version 7 で改装設計図の枚数が追加された
  # version 7 〜 11 で仕様が同じ
  (7..11).each do |version|
    describe ".parse_character_list_info(json, #{version})" do
      it 'returns CharacterListInfo[]' do
        # 朝潮、朝潮改、千歳、千歳改のデータ
        json = File.open('spec/fixtures/v7/CharacterList_info.json').read

        results = AdmiralStatsParser.parse_character_list_info(json, version)

        expect(results.size).to eq(4)

        result = results[0]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_69ex6r4uutp3.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(16)
        expect(result.real_hp).to eq(16)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to be_nil

        result = results[1]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('朝潮改')
        expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_umacfn9qcwp1.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(31)
        expect(result.real_hp).to eq(31)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['61cm四連装(酸素)魚雷', '61cm四連装(酸素)魚雷', '強化型艦本式缶', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['equip_icon_5_c4bcdscek33o.png', 'equip_icon_5_c4bcdscek33o.png', 'equip_icon_12_556qjnbtokca.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to be_nil

        result = results[2]
        expect(result.book_no).to eq(49)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('千歳')
        expect(result.status_img).to eq('i/i_x44xgkjc9a4z_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_49_x44xgkjc9a4z.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(40)
        expect(result.real_hp).to eq(40)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([12, 12, 0, 0])
        expect(result.slot_disp).to eq(%w(NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to be_nil

        result = results[3]
        expect(result.book_no).to eq(95)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('千歳改')
        expect(result.status_img).to eq('i/i_6a3eccmpq03x_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_95_6a3eccmpq03x.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(41)
        expect(result.real_hp).to eq(41)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['瑞雲', '瑞雲', '甲標的', ''])
        expect(result.slot_amount).to eq([12, 6, 6, 0])
        expect(result.slot_disp).to eq(%w(EQUIPPED_AIRCRAFT EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE))
        expect(result.slot_img).to eq(['equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_5_c4bcdscek33o.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to be_nil
      end
    end
  end

  # version 12 から艦娘一覧にケッコンカッコカリの情報が追加された
  (12..13).each do |version|
    describe ".parse_character_list_info(json, #{version})" do
      it 'returns CharacterListInfo[]' do
        # 朝潮、朝潮改、千歳、千歳改のデータ
        json = File.open('spec/fixtures/v12/CharacterList_info.json').read

        results = AdmiralStatsParser.parse_character_list_info(json, version)

        expect(results.size).to eq(4)

        result = results[0]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_69ex6r4uutp3.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(16)
        expect(result.real_hp).to eq(16)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)

        result = results[1]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('朝潮改')
        expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_umacfn9qcwp1.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(31)
        expect(result.real_hp).to eq(31)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['61cm四連装(酸素)魚雷', '61cm四連装(酸素)魚雷', '強化型艦本式缶', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['equip_icon_5_c4bcdscek33o.png', 'equip_icon_5_c4bcdscek33o.png', 'equip_icon_12_556qjnbtokca.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(true)

        result = results[2]
        expect(result.book_no).to eq(49)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('千歳')
        expect(result.status_img).to eq('i/i_x44xgkjc9a4z_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_49_x44xgkjc9a4z.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(40)
        expect(result.real_hp).to eq(40)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([12, 12, 0, 0])
        expect(result.slot_disp).to eq(%w(NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)

        result = results[3]
        expect(result.book_no).to eq(95)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('千歳改')
        expect(result.status_img).to eq('i/i_6a3eccmpq03x_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_95_6a3eccmpq03x.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(41)
        expect(result.real_hp).to eq(41)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['瑞雲', '瑞雲', '甲標的', ''])
        expect(result.slot_amount).to eq([12, 6, 6, 0])
        expect(result.slot_disp).to eq(%w(EQUIPPED_AIRCRAFT EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE))
        expect(result.slot_img).to eq(['equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_5_c4bcdscek33o.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)
      end
    end
  end

  # version 14 から ship_class_index は必須ではなくなった
  (14..17).each do |version|
    describe ".parse_character_list_info(json, #{version})" do
      it 'returns CharacterListInfo[]' do
        # 朝潮、朝潮改、千歳、千歳改、まるゆのデータ
        json = File.open('spec/fixtures/v14/CharacterList_info.json').read

        results = AdmiralStatsParser.parse_character_list_info(json, version)

        expect(results.size).to eq(5)

        result = results[0]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_69ex6r4uutp3.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(16)
        expect(result.real_hp).to eq(16)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)

        result = results[1]
        expect(result.book_no).to eq(85)
        expect(result.lv).to eq(99)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_sort_no).to eq(1800)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('朝潮改')
        expect(result.status_img).to eq('i/i_umacfn9qcwp1_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('朝潮型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_85_umacfn9qcwp1.jpg')
        expect(result.exp_percent).to eq(0)
        expect(result.max_hp).to eq(31)
        expect(result.real_hp).to eq(31)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['61cm四連装(酸素)魚雷', '61cm四連装(酸素)魚雷', '強化型艦本式缶', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['equip_icon_5_c4bcdscek33o.png', 'equip_icon_5_c4bcdscek33o.png', 'equip_icon_12_556qjnbtokca.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(true)

        result = results[2]
        expect(result.book_no).to eq(49)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('千歳')
        expect(result.status_img).to eq('i/i_x44xgkjc9a4z_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_49_x44xgkjc9a4z.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(40)
        expect(result.real_hp).to eq(40)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(2)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([12, 12, 0, 0])
        expect(result.slot_disp).to eq(%w(NOT_EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)

        result = results[3]
        expect(result.book_no).to eq(95)
        expect(result.lv).to eq(52)
        expect(result.ship_type).to eq('水上機母艦')
        expect(result.ship_sort_no).to eq(700)
        expect(result.remodel_lv).to eq(1)
        expect(result.ship_name).to eq('千歳改')
        expect(result.status_img).to eq('i/i_6a3eccmpq03x_n.png')
        expect(result.star_num).to eq(5)
        expect(result.ship_class).to eq('千歳型')
        expect(result.ship_class_index).to eq(1)
        expect(result.tc_img).to eq('s/tc_95_6a3eccmpq03x.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(41)
        expect(result.real_hp).to eq(41)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(3)
        expect(result.slot_equip_name).to eq(['瑞雲', '瑞雲', '甲標的', ''])
        expect(result.slot_amount).to eq([12, 6, 6, 0])
        expect(result.slot_disp).to eq(%w(EQUIPPED_AIRCRAFT EQUIPPED_AIRCRAFT NOT_EQUIPPED_AIRCRAFT NONE))
        expect(result.slot_img).to eq(['equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_10_lpoysb3zk6s4.png', 'equip_icon_5_c4bcdscek33o.png', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)

        result = results[4]
        expect(result.book_no).to eq(163)
        expect(result.lv).to eq(3)
        expect(result.ship_type).to eq('潜水艦')
        expect(result.ship_sort_no).to eq(900)
        expect(result.remodel_lv).to eq(0)
        expect(result.ship_name).to eq('まるゆ')
        expect(result.status_img).to eq('i/i_rjdnpze1x0gn_n.png')
        expect(result.star_num).to eq(1)
        expect(result.ship_class).to eq('三式潜航輸送艇')
        expect(result.ship_class_index).to be_nil
        expect(result.tc_img).to eq('s/tc_163_4ecmr9qtz4kd.jpg')
        expect(result.exp_percent).to eq(23)
        expect(result.max_hp).to eq(6)
        expect(result.real_hp).to eq(6)
        expect(result.damage_status).to eq('NORMAL')
        expect(result.slot_num).to eq(0)
        expect(result.slot_equip_name).to eq(['', '', '', ''])
        expect(result.slot_amount).to eq([0, 0, 0, 0])
        expect(result.slot_disp).to eq(%w(NONE NONE NONE NONE))
        expect(result.slot_img).to eq(['', '', '', ''])
        expect(result.blueprint_total_num).to eq(0)
        expect(result.married).to eq(false)
      end
    end
  end

  describe '.parse_equip_list_info(json, 1)' do
    it 'raises' do
      json = '[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]'

      expect { AdmiralStatsParser.parse_equip_list_info(json, 1) }.to raise_error('API version 1 does not support equip list info')
    end
  end

  # 装備一覧は version 2 〜 8 で仕様が同じ
  (2..8).each do |version|
    describe ".parse_equip_list_info(json, #{version})" do
      it 'returns EquipListInfo[]' do
        json = '[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]'

        results = AdmiralStatsParser.parse_equip_list_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(1)
        expect(result.name).to eq('12cm単装砲')
        expect(result.num).to eq(8)
        expect(result.img).to eq('equip_icon_1_1984kzwm2f7s.png')

        result = results[1]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(2)
        expect(result.name).to eq('12.7cm連装砲')
        expect(result.num).to eq(31)
        expect(result.img).to eq('equip_icon_1_1984kzwm2f7s.png')

        result = results[2]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(3)
        expect(result.name).to eq('10cm連装高角砲')
        expect(result.num).to eq(6)
        expect(result.img).to eq('equip_icon_26_rv74l134q7an.png')
      end

      describe ".parse_max_slot_num(json, #{version})" do
        it 'returns 500 (default)' do
          json = '[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]'

          # maxSlotNum は別のメソッドで取得する（API バージョンごとに、既存メソッドの構造を大きく変えたくなかったため）
          max_slot_num = AdmiralStatsParser.parse_max_slot_num(json, version)
          expect(max_slot_num).to eq(500)
        end
      end
    end
  end

  # 装備一覧は version 9 で最大装備保有数が追加された
  # version 9 〜 は仕様が同じ
  (9..17).each do |version|
    describe ".parse_equip_list_info(json, #{version})" do
      it 'returns EquipListInfo[]' do
        json = '{"maxSlotNum":510,"equipList":[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]}'

        results = AdmiralStatsParser.parse_equip_list_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(1)
        expect(result.name).to eq('12cm単装砲')
        expect(result.num).to eq(8)
        expect(result.img).to eq('equip_icon_1_1984kzwm2f7s.png')

        result = results[1]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(2)
        expect(result.name).to eq('12.7cm連装砲')
        expect(result.num).to eq(31)
        expect(result.img).to eq('equip_icon_1_1984kzwm2f7s.png')

        result = results[2]
        expect(result.type).to eq(1)
        expect(result.equipment_id).to eq(3)
        expect(result.name).to eq('10cm連装高角砲')
        expect(result.num).to eq(6)
        expect(result.img).to eq('equip_icon_26_rv74l134q7an.png')
      end
    end

    describe ".parse_max_slot_num(json, #{version})" do
      it 'returns 510' do
        json = '{"maxSlotNum":510,"equipList":[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]}'

        # maxSlotNum は別のメソッドで取得する（API バージョンごとに、既存メソッドの構造を大きく変えたくなかったため）
        max_slot_num = AdmiralStatsParser.parse_max_slot_num(json, version)
        expect(max_slot_num).to eq(510)
      end
    end
  end

  # version 1 〜 3 にはイベント海域情報なし
  (1..3).each do |version|
    describe ".parse_equip_list_info(json, #{version})" do
      it 'raises' do
        json = '[{"areaId":1000,"areaSubId":1,"level":"HEI","areaKind":"NORMAL","stageImageName":"area_14yzzpb2ab.png","stageMissionName":"前哨戦","stageMissionInfo":"敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！","requireGp":300,"limitSec":240,"rewardList":[{"rewardType":"FIRST","dataId":0,"kind":"ROOM_ITEM_COIN","value":50},{"rewardType":"FIRST","dataId":1,"kind":"RESULT_POINT","value":500},{"rewardType":"SECOND","dataId":0,"kind":"RESULT_POINT","value":200}],"stageDropItemInfo":["SMALLBOX","MEDIUMBOX","SMALLREC","NONE"],"sortieLimit":false,"areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},' +
            '{"areaId":1000,"areaSubId":5,"level":"HEI","areaKind":"SWEEP","stageImageName":"area_0555h7ae9d.png","stageMissionName":"？","stageMissionInfo":"？","requireGp":0,"limitSec":0,"rewardList":[{"dataId":0,"kind":"NONE","value":0}],"stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"sortieLimit":false,"areaClearState":"NOOPEN","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]'

        expect { AdmiralStatsParser.parse_event_info(json, version) }.to raise_error("API version #{version} does not support event info")
      end
    end
  end

  # イベント海域情報は version 4 〜 6 で仕様が同じ
  (4..6).each do |version|
    describe ".parse_event_info(json, #{version})" do
      it 'returns EventInfo[]' do
        # E-1 クリア、E-5 未クリア
        json = '[{"areaId":1000,"areaSubId":1,"level":"HEI","areaKind":"NORMAL","stageImageName":"area_14yzzpb2ab.png","stageMissionName":"前哨戦","stageMissionInfo":"敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！","requireGp":300,"limitSec":240,"rewardList":[{"rewardType":"FIRST","dataId":0,"kind":"ROOM_ITEM_COIN","value":50},{"rewardType":"FIRST","dataId":1,"kind":"RESULT_POINT","value":500},{"rewardType":"SECOND","dataId":0,"kind":"RESULT_POINT","value":200}],"stageDropItemInfo":["SMALLBOX","MEDIUMBOX","SMALLREC","NONE"],"sortieLimit":false,"areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},' +
            '{"areaId":1000,"areaSubId":5,"level":"HEI","areaKind":"SWEEP","stageImageName":"area_0555h7ae9d.png","stageMissionName":"？","stageMissionInfo":"？","requireGp":0,"limitSec":0,"rewardList":[{"dataId":0,"kind":"NONE","value":0}],"stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"sortieLimit":false,"areaClearState":"NOTCLEAR","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]'

        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(2)

        result = results[0]
        expect(result.area_id).to eq(1000)
        expect(result.area_sub_id).to eq(1)
        expect(result.level).to eq('HEI')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_14yzzpb2ab.png')
        expect(result.stage_mission_name).to eq('前哨戦')
        expect(result.stage_mission_info).to eq("敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！")
        expect(result.require_gp).to eq(300)
        expect(result.limit_sec).to eq(240)
        expect(result.reward_list.size).to eq(3)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[0].value).to eq(50)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('RESULT_POINT')
        expect(result.reward_list[1].value).to eq(500)
        expect(result.reward_list[2].reward_type).to eq('SECOND')
        expect(result.reward_list[2].data_id).to eq(0)
        expect(result.reward_list[2].kind).to eq('RESULT_POINT')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('SMALLBOX')
        expect(result.stage_drop_item_info[1]).to eq('MEDIUMBOX')
        expect(result.stage_drop_item_info[2]).to eq('SMALLREC')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.military_gauge_status).to eq('BREAK')
        expect(result.ene_military_gauge_val).to eq(1000)
        expect(result.military_gauge_left).to eq(0)
        expect(result.boss_status).to eq('NONE')
        expect(result.loop_count).to eq(1)
        expect(result.ene_military_gauge2d).to be_nil
        expect(result.period).to be_nil

        result = results[1]
        expect(result.area_id).to eq(1000)
        expect(result.area_sub_id).to eq(5)
        expect(result.level).to eq('HEI')
        expect(result.area_kind).to eq('SWEEP')
        expect(result.stage_image_name).to eq('area_0555h7ae9d.png')
        expect(result.stage_mission_name).to eq('？')
        expect(result.stage_mission_info).to eq('？')
        expect(result.require_gp).to eq(0)
        expect(result.limit_sec).to eq(0)
        expect(result.reward_list.size).to eq(1)
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('NONE')
        expect(result.reward_list[0].value).to eq(0)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('UNKNOWN')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NONE')
        expect(result.ene_military_gauge_val).to eq(0)
        expect(result.military_gauge_left).to eq(0)
        expect(result.boss_status).to eq('NONE')
        expect(result.loop_count).to eq(1)
        expect(result.ene_military_gauge2d).to be_nil
        expect(result.period).to be_nil
      end
    end
  end

  # イベント海域情報は version 7 から前段作戦、後段作戦あり
  # version 7 〜 で仕様が同じ
  (7..17).each do |version|
    describe ".parse_event_info(json, #{version})" do
      it 'returns EventInfo[]' do
        # E-3 クリア直後
        json = File.open('spec/fixtures/v7/Event_info_zendan_hei1_e3_cleared.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(12)

        # 丙E-1 (クリア済)
        result = results[0]
        expect(result.area_id).to eq(1001)
        expect(result.area_sub_id).to eq(1)
        expect(result.level).to eq('HEI')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_gbaewgvif8.png')
        expect(result.stage_mission_name).to eq('南方海域へ進出せよ！')
        expect(result.stage_mission_info).to eq("いよいよ南方海域へ進出を開始する。\n哨戒線を偵察せよ！")
        expect(result.require_gp).to eq(300)
        expect(result.limit_sec).to eq(240)
        expect(result.reward_list.size).to eq(3)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[0].value).to eq(50)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('RESULT_POINT')
        expect(result.reward_list[1].value).to eq(500)
        expect(result.reward_list[2].reward_type).to eq('SECOND')
        expect(result.reward_list[2].data_id).to eq(0)
        expect(result.reward_list[2].kind).to eq('RESULT_POINT')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('SMALLBOX')
        expect(result.stage_drop_item_info[1]).to eq('MEDIUMBOX')
        expect(result.stage_drop_item_info[2]).to eq('LARGEBOX')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.military_gauge_status).to eq('BREAK')
        expect(result.ene_military_gauge_val).to eq(2000)
        expect(result.military_gauge_left).to eq(0)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_sensuikakyuu1')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(0)

        # 丙E-3 (クリア済)
        result = results[2]
        expect(result.area_id).to eq(1001)
        expect(result.area_sub_id).to eq(3)
        expect(result.level).to eq('HEI')
        expect(result.area_kind).to eq('PERIOD_LAST')
        expect(result.stage_image_name).to eq('area_xexlaicaqs.png')
        expect(result.stage_mission_name).to eq('敵洋上戦力を排除せよ！')
        expect(result.stage_mission_info).to eq("南方海域の前面に展開する\n敵洋上戦力の排除を行う。\n未知の大型戦艦の情報あり！注意せよ！")
        expect(result.require_gp).to eq(400)
        expect(result.limit_sec).to eq(360)
        expect(result.reward_list.size).to eq(3)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('EQUIP')
        expect(result.reward_list[0].value).to eq(1)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('RESULT_POINT')
        expect(result.reward_list[1].value).to eq(1000)
        expect(result.reward_list[2].reward_type).to eq('SECOND')
        expect(result.reward_list[2].data_id).to eq(0)
        expect(result.reward_list[2].kind).to eq('RESULT_POINT')
        expect(result.reward_list[2].value).to eq(500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('SMALLBOX')
        expect(result.stage_drop_item_info[1]).to eq('MEDIUMBOX')
        expect(result.stage_drop_item_info[2]).to eq('LARGEBOX')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('CLEAR')
        expect(result.military_gauge_status).to eq('BREAK')
        expect(result.ene_military_gauge_val).to eq(2800)
        expect(result.military_gauge_left).to eq(0)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_nanpouseiki')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(0)

        # 乙E-1 (未クリア、開放済み)
        result = results[4]
        expect(result.area_id).to eq(1001)
        expect(result.area_sub_id).to eq(9)
        expect(result.level).to eq('OTU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_9wb019oc5p.png')
        expect(result.stage_mission_name).to eq('南方海域へ進出せよ！')
        expect(result.stage_mission_info).to eq("いよいよ南方海域へ進出を開始する。\n哨戒線を偵察せよ！")
        expect(result.require_gp).to eq(300)
        expect(result.limit_sec).to eq(240)
        expect(result.reward_list.size).to eq(3)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[0].value).to eq(100)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('RESULT_POINT')
        expect(result.reward_list[1].value).to eq(1000)
        expect(result.reward_list[2].reward_type).to eq('SECOND')
        expect(result.reward_list[2].data_id).to eq(0)
        expect(result.reward_list[2].kind).to eq('RESULT_POINT')
        expect(result.reward_list[2].value).to eq(500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('SMALLBOX')
        expect(result.stage_drop_item_info[1]).to eq('MEDIUMBOX')
        expect(result.stage_drop_item_info[2]).to eq('LARGEBOX')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(1800)
        expect(result.military_gauge_left).to eq(1800)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_sensuikakyuu1')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(0)

        # 甲E-1 (未クリア、未開放)
        result = results[8]
        expect(result.area_id).to eq(1001)
        expect(result.area_sub_id).to eq(17)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_egorqr3pa3.png')
        expect(result.stage_mission_name).to eq('？')
        expect(result.stage_mission_info).to eq('？')
        expect(result.require_gp).to eq(0)
        expect(result.limit_sec).to eq(0)
        expect(result.reward_list.size).to eq(1)
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('NONE')
        expect(result.reward_list[0].value).to eq(0)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('UNKNOWN')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('NOOPEN')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(2000)
        expect(result.military_gauge_left).to eq(2000)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(0)
      end
    end
  end

  # イベント海域情報は version 13 から EO あり
  (13..17).each do |version|
    describe ".parse_event_info(json, #{version}) EO 開放前" do
      it 'returns EventInfo[]' do
        # EO 開放前
        json = File.open('spec/fixtures/v13/Event_info_eo_noopen.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(2)

        # 乙 EO
        result = results[0]
        expect(result.area_id).to eq(1003)
        expect(result.area_sub_id).to eq(17)
        expect(result.level).to eq('OTU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_ccd30c39wzz.png')
        expect(result.stage_mission_name).to eq('？')
        expect(result.stage_mission_info).to eq('？')
        expect(result.require_gp).to eq(0)
        expect(result.limit_sec).to eq(0)
        expect(result.reward_list.size).to eq(1)
        expect(result.reward_list[0].reward_type).to be_nil
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('NONE')
        expect(result.reward_list[0].value).to eq(0)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('UNKNOWN')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('NOOPEN')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(7200)
        expect(result.military_gauge_left).to eq(7200)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to eq('HEI')
        expect(result.ng_unit_img).to be_nil

        # 甲 EO
        result = results[1]
        expect(result.area_id).to eq(1003)
        expect(result.area_sub_id).to eq(27)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_yo4u95e35d6.png')
        expect(result.stage_mission_name).to eq('？')
        expect(result.stage_mission_info).to eq('？')
        expect(result.require_gp).to eq(0)
        expect(result.limit_sec).to eq(0)
        expect(result.reward_list.size).to eq(1)
        expect(result.reward_list[0].reward_type).to be_nil
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('NONE')
        expect(result.reward_list[0].value).to eq(0)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('UNKNOWN')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(false)
        expect(result.area_clear_state).to eq('NOOPEN')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(6000)
        expect(result.military_gauge_left).to eq(6000)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to be_nil
        expect(result.ng_unit_img).to be_nil
      end
    end

    describe ".parse_event_info(json, #{version}) EO解放後、1周目出撃中" do
      it 'returns opened EventInfo[]' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_notclear.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(1)

        result = results[0]
        expect(result.area_id).to eq(1003)
        expect(result.area_sub_id).to eq(27)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_yo4u95e35d6.png')
        expect(result.stage_mission_name).to eq('敵飛行場を夜間砲撃で叩け！')
        expect(result.stage_mission_info).to eq('拡張作戦が発令された！味方艦隊と共に全戦力を結集し、敵飛行場を叩け！')
        expect(result.require_gp).to eq(450)
        expect(result.limit_sec).to eq(720)
        expect(result.reward_list.size).to eq(8)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('TLOP_KOU_MEDAL')
        expect(result.reward_list[0].value).to eq(1)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('EQUIP')
        expect(result.reward_list[1].value).to eq(1)
        expect(result.reward_list[2].reward_type).to eq('FIRST')
        expect(result.reward_list[2].data_id).to eq(2)
        expect(result.reward_list[2].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.reward_list[3].reward_type).to eq('FIRST')
        expect(result.reward_list[3].data_id).to eq(3)
        expect(result.reward_list[3].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[3].value).to eq(500)
        expect(result.reward_list[4].reward_type).to eq('FIRST')
        expect(result.reward_list[4].data_id).to eq(4)
        expect(result.reward_list[4].kind).to eq('RESULT_POINT')
        expect(result.reward_list[4].value).to eq(3000)
        expect(result.reward_list[5].reward_type).to eq('SECOND')
        expect(result.reward_list[5].data_id).to eq(0)
        expect(result.reward_list[5].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[5].value).to eq(50)
        expect(result.reward_list[6].reward_type).to eq('SECOND')
        expect(result.reward_list[6].data_id).to eq(1)
        expect(result.reward_list[6].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[6].value).to eq(100)
        expect(result.reward_list[7].reward_type).to eq('SECOND')
        expect(result.reward_list[7].data_id).to eq(2)
        expect(result.reward_list[7].kind).to eq('RESULT_POINT')
        expect(result.reward_list[7].value).to eq(1500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('NONE')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.sortie_limit_img).to eq('sortie_yo4u95e35d6.png')
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(6000)
        expect(result.military_gauge_left).to eq(1893)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_hikouzyouki_senkanseiki_hime')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to be_nil
        expect(result.ng_unit_img).to eq('ng_yo4u95e35d6.png')
      end
    end

    describe ".parse_event_info(json, #{version}) EO解放後、1周目最終戦直前" do
      it 'returns opened EventInfo[]' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_final.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(1)

        result = results[0]
        expect(result.area_id).to eq(1003)
        # 最終戦だけ area_sub_id が 27 から 28 に変わる
        expect(result.area_sub_id).to eq(28)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('BOSS_RAID_FINAL')
        expect(result.stage_image_name).to eq('area_i15pybux8bm.png')
        expect(result.stage_mission_name).to eq('敵飛行場を夜間砲撃で叩け！')
        expect(result.stage_mission_info).to eq("今こそ南方海域要所、敵飛行場を\n撃滅する時！暁の水平線に勝利を刻め！")
        expect(result.require_gp).to eq(450)
        expect(result.limit_sec).to eq(720)
        expect(result.reward_list.size).to eq(8)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('TLOP_KOU_MEDAL')
        expect(result.reward_list[0].value).to eq(1)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('EQUIP')
        expect(result.reward_list[1].value).to eq(1)
        expect(result.reward_list[2].reward_type).to eq('FIRST')
        expect(result.reward_list[2].data_id).to eq(2)
        expect(result.reward_list[2].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.reward_list[3].reward_type).to eq('FIRST')
        expect(result.reward_list[3].data_id).to eq(3)
        expect(result.reward_list[3].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[3].value).to eq(500)
        expect(result.reward_list[4].reward_type).to eq('FIRST')
        expect(result.reward_list[4].data_id).to eq(4)
        expect(result.reward_list[4].kind).to eq('RESULT_POINT')
        expect(result.reward_list[4].value).to eq(3000)
        expect(result.reward_list[5].reward_type).to eq('SECOND')
        expect(result.reward_list[5].data_id).to eq(0)
        expect(result.reward_list[5].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[5].value).to eq(50)
        expect(result.reward_list[6].reward_type).to eq('SECOND')
        expect(result.reward_list[6].data_id).to eq(1)
        expect(result.reward_list[6].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[6].value).to eq(100)
        expect(result.reward_list[7].reward_type).to eq('SECOND')
        expect(result.reward_list[7].data_id).to eq(2)
        expect(result.reward_list[7].kind).to eq('RESULT_POINT')
        expect(result.reward_list[7].value).to eq(1500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('NONE')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.sortie_limit_img).to eq('sortie_i15pybux8bm.png')
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NONE')
        expect(result.ene_military_gauge_val).to eq(0)
        expect(result.military_gauge_left).to eq(0)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to be_nil
        expect(result.ng_unit_img).to eq('ng_i15pybux8bm.png')
      end
    end

    describe ".parse_event_info(json, #{version}) EO 1周目最終戦クリア後" do
      it 'returns cleared EventInfo[]' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_clear.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(1)

        # SEGA 公式サイトの仕様上、出撃前の状態と区別が付かない（クリアしたかどうか判断できない）
        result = results[0]
        expect(result.area_id).to eq(1003)
        expect(result.area_sub_id).to eq(27)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_yo4u95e35d6.png')
        expect(result.stage_mission_name).to eq('敵飛行場を夜間砲撃で叩け！')
        expect(result.stage_mission_info).to eq('拡張作戦が発令された！味方艦隊と共に全戦力を結集し、敵飛行場を叩け！')
        expect(result.require_gp).to eq(450)
        expect(result.limit_sec).to eq(720)
        expect(result.reward_list.size).to eq(8)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('TLOP_KOU_MEDAL')
        expect(result.reward_list[0].value).to eq(1)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('EQUIP')
        expect(result.reward_list[1].value).to eq(1)
        expect(result.reward_list[2].reward_type).to eq('FIRST')
        expect(result.reward_list[2].data_id).to eq(2)
        expect(result.reward_list[2].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.reward_list[3].reward_type).to eq('FIRST')
        expect(result.reward_list[3].data_id).to eq(3)
        expect(result.reward_list[3].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[3].value).to eq(500)
        expect(result.reward_list[4].reward_type).to eq('FIRST')
        expect(result.reward_list[4].data_id).to eq(4)
        expect(result.reward_list[4].kind).to eq('RESULT_POINT')
        expect(result.reward_list[4].value).to eq(3000)
        expect(result.reward_list[5].reward_type).to eq('SECOND')
        expect(result.reward_list[5].data_id).to eq(0)
        expect(result.reward_list[5].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[5].value).to eq(50)
        expect(result.reward_list[6].reward_type).to eq('SECOND')
        expect(result.reward_list[6].data_id).to eq(1)
        expect(result.reward_list[6].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[6].value).to eq(100)
        expect(result.reward_list[7].reward_type).to eq('SECOND')
        expect(result.reward_list[7].data_id).to eq(2)
        expect(result.reward_list[7].kind).to eq('RESULT_POINT')
        expect(result.reward_list[7].value).to eq(1500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('NONE')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.sortie_limit_img).to eq('sortie_yo4u95e35d6.png')
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(6000)
        expect(result.military_gauge_left).to eq(6000)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_hikouzyouki_senkanseiki_hime')
        expect(result.loop_count).to eq(1)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to be_nil
        expect(result.ng_unit_img).to eq('ng_yo4u95e35d6.png')
      end
    end

    describe ".parse_event_info(json, #{version}) EO 2周目開始直後" do
      it 'returns cleared EventInfo[]' do
        json = File.open('spec/fixtures/v13/Event_info_eo_2nd_loop_notclear.json').read
        results = AdmiralStatsParser.parse_event_info(json, version)

        expect(results.size).to eq(1)

        result = results[0]
        expect(result.area_id).to eq(1003)
        expect(result.area_sub_id).to eq(27)
        expect(result.level).to eq('KOU')
        expect(result.area_kind).to eq('NORMAL')
        expect(result.stage_image_name).to eq('area_yo4u95e35d6.png')
        expect(result.stage_mission_name).to eq('敵飛行場を夜間砲撃で叩け！')
        expect(result.stage_mission_info).to eq('拡張作戦が発令された！味方艦隊と共に全戦力を結集し、敵飛行場を叩け！')
        expect(result.require_gp).to eq(450)
        expect(result.limit_sec).to eq(720)
        expect(result.reward_list.size).to eq(8)
        expect(result.reward_list[0].reward_type).to eq('FIRST')
        expect(result.reward_list[0].data_id).to eq(0)
        expect(result.reward_list[0].kind).to eq('TLOP_KOU_MEDAL')
        expect(result.reward_list[0].value).to eq(1)
        expect(result.reward_list[1].reward_type).to eq('FIRST')
        expect(result.reward_list[1].data_id).to eq(1)
        expect(result.reward_list[1].kind).to eq('EQUIP')
        expect(result.reward_list[1].value).to eq(1)
        expect(result.reward_list[2].reward_type).to eq('FIRST')
        expect(result.reward_list[2].data_id).to eq(2)
        expect(result.reward_list[2].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[2].value).to eq(200)
        expect(result.reward_list[3].reward_type).to eq('FIRST')
        expect(result.reward_list[3].data_id).to eq(3)
        expect(result.reward_list[3].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[3].value).to eq(500)
        expect(result.reward_list[4].reward_type).to eq('FIRST')
        expect(result.reward_list[4].data_id).to eq(4)
        expect(result.reward_list[4].kind).to eq('RESULT_POINT')
        expect(result.reward_list[4].value).to eq(3000)
        expect(result.reward_list[5].reward_type).to eq('SECOND')
        expect(result.reward_list[5].data_id).to eq(0)
        expect(result.reward_list[5].kind).to eq('ROOM_ITEM_COIN')
        expect(result.reward_list[5].value).to eq(50)
        expect(result.reward_list[6].reward_type).to eq('SECOND')
        expect(result.reward_list[6].data_id).to eq(1)
        expect(result.reward_list[6].kind).to eq('STRATEGY_POINT')
        expect(result.reward_list[6].value).to eq(100)
        expect(result.reward_list[7].reward_type).to eq('SECOND')
        expect(result.reward_list[7].data_id).to eq(2)
        expect(result.reward_list[7].kind).to eq('RESULT_POINT')
        expect(result.reward_list[7].value).to eq(1500)
        expect(result.stage_drop_item_info.size).to eq(4)
        expect(result.stage_drop_item_info[0]).to eq('NONE')
        expect(result.stage_drop_item_info[1]).to eq('NONE')
        expect(result.stage_drop_item_info[2]).to eq('NONE')
        expect(result.stage_drop_item_info[3]).to eq('NONE')
        expect(result.sortie_limit).to eq(true)
        expect(result.sortie_limit_img).to eq('sortie_yo4u95e35d6.png')
        expect(result.area_clear_state).to eq('NOTCLEAR')
        expect(result.military_gauge_status).to eq('NORMAL')
        expect(result.ene_military_gauge_val).to eq(6000)
        expect(result.military_gauge_left).to eq(6000)
        expect(result.boss_status).to be_nil
        expect(result.ene_military_gauge2d).to eq('base_hikouzyouki_senkanseiki_hime')
        expect(result.loop_count).to eq(2)
        expect(result.period).to eq(2)
        expect(result.disp_add_level).to be_nil
        expect(result.ng_unit_img).to eq('ng_yo4u95e35d6.png')
      end
    end
  end

  # イベント海域情報が空の場合の動作は、version 4 〜 で仕様が同じ
  (4..17).each do |version|
    describe ".summarize_event_info('[]', #{version})" do
      it 'returns summary' do
        # イベントを開催していない期間は、空の配列が返される
        json = '[]'

        # 引数が空の配列の場合、返り値も空の配列になる
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)
        expect(event_info_list).to be_an(Array)
        expect(event_info_list.size).to eq(0)
      end
    end
  end

  # こちらはサマリのテスト
  # イベント海域情報は version 4 〜 6 で仕様が同じ
  (4..6).each do |version|
    describe ".summarize_event_info(json, #{version})" do
      it 'returns summary' do
        # E-1 クリア、E-5 未クリア
        json = '[{"areaId":1000,"areaSubId":1,"level":"HEI","areaKind":"NORMAL","stageImageName":"area_14yzzpb2ab.png","stageMissionName":"前哨戦","stageMissionInfo":"敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！","requireGp":300,"limitSec":240,"rewardList":[{"rewardType":"FIRST","dataId":0,"kind":"ROOM_ITEM_COIN","value":50},{"rewardType":"FIRST","dataId":1,"kind":"RESULT_POINT","value":500},{"rewardType":"SECOND","dataId":0,"kind":"RESULT_POINT","value":200}],"stageDropItemInfo":["SMALLBOX","MEDIUMBOX","SMALLREC","NONE"],"sortieLimit":false,"areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},' +
            '{"areaId":1000,"areaSubId":5,"level":"HEI","areaKind":"SWEEP","stageImageName":"area_0555h7ae9d.png","stageMissionName":"？","stageMissionInfo":"？","requireGp":0,"limitSec":0,"rewardList":[{"dataId":0,"kind":"NONE","value":0}],"stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"sortieLimit":false,"areaClearState":"NOTCLEAR","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]'

        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        hei_results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", nil, version)
        expect(hei_results[:opened]).to be true
        expect(hei_results[:all_cleared]).to be false
        expect(hei_results[:current_loop_counts]).to eq(1)
        expect(hei_results[:cleared_loop_counts]).to eq(0)
        expect(hei_results[:cleared_stage_no]).to eq(1)
        expect(hei_results[:current_military_gauge_left]).to eq(0)
      end
    end
  end

  # こちらはサマリのテスト
  # イベント海域情報は version 7 から前段作戦、後段作戦あり
  # version 7 〜 で仕様が同じ
  (7..17).each do |version|
    describe ".summarize_event_info(json, #{version}) 何も出撃していない時点" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v7/Event_info_zendan_initial.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(1800)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 0, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)
      end
    end

    describe ".summarize_event_info(json, #{version}) 丙1周目E-3クリア後" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v7/Event_info_zendan_hei1_e3_cleared.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(3)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(1800)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 0, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)
      end
    end

    describe ".summarize_event_info(json, #{version}) 丙1周目掃討戦クリア後" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v7/Event_info_zendan_hei1_e4_cleared.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be true
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(1)
        expect(results[:cleared_stage_no]).to eq(4)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(1800)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 0, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)
      end
    end

    describe ".summarize_event_info(json, #{version}) 丙2周目開始直後" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v7/Event_info_zendan_hei2_initial.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(2)
        expect(results[:cleared_loop_counts]).to eq(1)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 0, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(1800)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 0, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(2000)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 1, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)
      end
    end
  end

  # こちらはサマリのテスト
  # イベント海域情報は version 13 からEOあり
  (13..17).each do |version|
    describe ".summarize_event_info(json, #{version}) EO 開放前" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v13/Event_info_eo_noopen.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        # EO は HEI と OTU が一緒になっていて、HEI のデータはない
        # その場合は、未開放の場合と同じデータを返す
        results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 2, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to be_nil
        expect(results[:cleared_loop_counts]).to be_nil
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "OTU", 2, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(7200)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 2, version)
        expect(results[:opened]).to be false
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(6000)
      end
    end

    describe ".summarize_event_info(json, #{version}) EO解放後、1周目出撃中" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_notclear.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 2, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(1893)
      end
    end

    describe ".summarize_event_info(json, #{version}) EO解放後、1周目最終戦直前" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_final.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 2, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(0)
      end
    end

    describe ".summarize_event_info(json, #{version}) EO 1周目最終戦クリア後" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v13/Event_info_eo_1st_loop_clear.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        # SEGA 公式サイトの仕様上、出撃前の状態と区別が付かない（クリアしたかどうか判断できない）
        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 2, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(1)
        expect(results[:cleared_loop_counts]).to eq(0)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(6000)
      end
    end

    describe ".summarize_event_info(json, #{version}) EO 2周目開始直後" do
      it 'returns summary' do
        json = File.open('spec/fixtures/v13/Event_info_eo_2nd_loop_notclear.json').read
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)

        results = AdmiralStatsParser.summarize_event_info(event_info_list, "KOU", 2, version)
        expect(results[:opened]).to be true
        expect(results[:all_cleared]).to be false
        expect(results[:current_loop_counts]).to eq(2)
        expect(results[:cleared_loop_counts]).to eq(1)
        expect(results[:cleared_stage_no]).to eq(0)
        expect(results[:current_military_gauge_left]).to eq(6000)
      end
    end
  end

  (7..17).each do |version|
    describe ".summarize_event_info('[]', #{version})" do
      it 'returns summary' do
        # イベントを開催していない期間は、空の配列が返される
        json = '[]'

        # 引数が空の配列の場合、返り値も空の配列になる
        event_info_list = AdmiralStatsParser.parse_event_info(json, version)
        expect(event_info_list).to be_an(Array)
        expect(event_info_list.size).to eq(0)
      end
    end
  end

  # version 1 〜 6 には改装設計図一覧なし
  (1..6).each do |version|
    describe ".parse_blueprint_list_info(json, #{version})" do
      it 'raises' do
        json = File.open('spec/fixtures/v7/BlueprintList_info.json').read
        expect { AdmiralStatsParser.parse_blueprint_list_info(json, version) }.to raise_error("API version #{version} does not support blueprint list info")
      end
    end
  end

  # 改装設計図は version 7 で追加
  [7].each do |version|
    # 改装設計図が1枚もない場合
    describe ".parse_blueprint_list_info('[]', #{version})" do
      it 'returns []' do
        results = AdmiralStatsParser.parse_blueprint_list_info('[]', version)
        expect(results.size).to eq(0)
      end
    end

    # 改装設計図がある場合
    describe ".parse_blueprint_list_info(json, #{version})" do
      it 'returns BlueprintListInfo[]' do
        # 朝潮、卯月、龍田の改装設計図
        json = File.open('spec/fixtures/v7/BlueprintList_info.json').read

        results = AdmiralStatsParser.parse_blueprint_list_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.ship_class_id).to eq(20)
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_sort_no).to eq(1800)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.blueprint_total_num).to eq(1)
        expect(result.expiration_date_list.size).to eq(1)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)

        result = results[1]
        expect(result.ship_class_id).to eq(14)
        expect(result.ship_class_index).to eq(4)
        expect(result.ship_sort_no).to eq(1800)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_name).to eq('卯月')
        expect(result.status_img).to eq('i/i_mj1x41twqqw6_n.png')
        expect(result.blueprint_total_num).to eq(1)
        expect(result.expiration_date_list.size).to eq(1)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)

        result = results[2]
        expect(result.ship_class_id).to eq(24)
        expect(result.ship_class_index).to eq(2)
        expect(result.ship_sort_no).to eq(1700)
        expect(result.ship_type).to eq('軽巡洋艦')
        expect(result.ship_name).to eq('龍田')
        expect(result.status_img).to eq('i/i_gxqprfwt6ynk_n.png')
        expect(result.blueprint_total_num).to eq(1)
        expect(result.expiration_date_list.size).to eq(1)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)
      end
    end
  end

  # 改装設計図は version 8 から情報が増えた（existsWarningForExpiration, expireThisMonth）
  (8..17).each do |version|
    # 改装設計図が1枚もない場合
    describe ".parse_blueprint_list_info('[]', #{version})" do
      it 'returns []' do
        results = AdmiralStatsParser.parse_blueprint_list_info('[]', version)
        expect(results.size).to eq(0)
      end
    end

    # 改装設計図がある場合
    describe ".parse_blueprint_list_info(json, #{version})" do
      it 'returns BlueprintListInfo[]' do
        # 朝潮、如月、望月の改装設計図
        json = File.open('spec/fixtures/v8/BlueprintList_info.json').read

        results = AdmiralStatsParser.parse_blueprint_list_info(json, version)

        expect(results.size).to eq(3)

        result = results[0]
        expect(result.ship_class_id).to eq(20)
        expect(result.ship_class_index).to eq(1)
        expect(result.ship_sort_no).to eq(1800)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_name).to eq('朝潮')
        expect(result.status_img).to eq('i/i_69ex6r4uutp3_n.png')
        expect(result.blueprint_total_num).to eq(1)
        expect(result.exists_warning_for_expiration).to eq(false)
        expect(result.expiration_date_list.size).to eq(1)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)
        expect(result.expiration_date_list[0].expire_this_month).to eq(false)

        result = results[1]
        expect(result.ship_class_id).to eq(14)
        expect(result.ship_class_index).to eq(2)
        expect(result.ship_sort_no).to eq(1800)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_name).to eq('如月')
        expect(result.status_img).to eq('i/i_q47stxacmqww_n.png')
        expect(result.blueprint_total_num).to eq(2)
        expect(result.exists_warning_for_expiration).to eq(false)
        expect(result.expiration_date_list.size).to eq(2)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)
        expect(result.expiration_date_list[0].expire_this_month).to eq(false)
        expect(result.expiration_date_list[1].expiration_date).to eq(1507733999000)
        expect(result.expiration_date_list[1].blueprint_num).to eq(1)
        expect(result.expiration_date_list[1].expire_this_month).to eq(false)

        result = results[2]
        expect(result.ship_class_id).to eq(14)
        expect(result.ship_class_index).to eq(11)
        expect(result.ship_sort_no).to eq(1800)
        expect(result.ship_type).to eq('駆逐艦')
        expect(result.ship_name).to eq('望月')
        expect(result.status_img).to eq('i/i_66r1z2tptm2x_n.png')
        expect(result.blueprint_total_num).to eq(2)
        expect(result.exists_warning_for_expiration).to eq(false)
        expect(result.expiration_date_list.size).to eq(2)
        expect(result.expiration_date_list[0].expiration_date).to eq(1505141999000)
        expect(result.expiration_date_list[0].blueprint_num).to eq(1)
        expect(result.expiration_date_list[0].expire_this_month).to eq(false)
        expect(result.expiration_date_list[1].expiration_date).to eq(1507733999000)
        expect(result.expiration_date_list[1].blueprint_num).to eq(1)
        expect(result.expiration_date_list[1].expire_this_month).to eq(false)
      end
    end
  end

  # 輸送イベント海域情報は version 15 から実装
  (15..17).each do |version|
    describe ".parse_cop_info(json, #{version}) 出撃前" do
      it 'returns CopInfo[]' do
        json = File.open('spec/fixtures/v15/Cop_info_initial.json').read
        result = AdmiralStatsParser.parse_cop_info(json, version)

        expect(result.numerator).to eq(300)
        expect(result.denominator).to eq(300)
        expect(result.achievement_number).to eq(1)
        expect(result.area_achievement_claim).to eq(false)
        expect(result.limited_frame_num).to eq(0)

        achievements = result.individual_achievement
        expect(achievements.size).to eq(2)
        expect(achievements[0].data_id).to eq(0)
        expect(achievements[0].kind).to eq('EQUIP')
        expect(achievements[0].value).to eq(1)
        expect(achievements[1].data_id).to eq(1)
        expect(achievements[1].kind).to eq('TRC_FRAME')
        expect(achievements[1].value).to eq(1)

        area_data_list = result.area_data_list
        expect(area_data_list.size).to eq(3)
        expect(area_data_list[0].area_id).to eq(3000)
        expect(area_data_list[0].area_sub_id).to eq(1)
        expect(area_data_list[1].area_id).to eq(3000)
        expect(area_data_list[1].area_sub_id).to eq(2)
        expect(area_data_list[2].area_id).to eq(3000)
        expect(area_data_list[2].area_sub_id).to eq(3)
      end
    end

    describe ".parse_cop_info(json, #{version}) 10周目、E-1のみクリア" do
      it 'returns CopInfo[]' do
        json = File.open('spec/fixtures/v15/Cop_info_10th_lap.json').read
        result = AdmiralStatsParser.parse_cop_info(json, version)

        expect(result.numerator).to eq(327)
        expect(result.denominator).to eq(800)
        expect(result.achievement_number).to eq(10)
        expect(result.area_achievement_claim).to eq(true)
        expect(result.limited_frame_num).to eq(6)

        achievements = result.individual_achievement
        expect(achievements.size).to eq(3)
        expect(achievements[0].data_id).to eq(0)
        expect(achievements[0].kind).to eq('EQUIP')
        expect(achievements[0].value).to eq(1)
        expect(achievements[1].data_id).to eq(1)
        expect(achievements[1].kind).to eq('TRC_FRAME')
        expect(achievements[1].value).to eq(2)
        expect(achievements[2].data_id).to eq(2)
        expect(achievements[2].kind).to eq('RESULT_POINT')
        expect(achievements[2].value).to eq(1000)

        area_data_list = result.area_data_list
        expect(area_data_list.size).to eq(3)
        expect(area_data_list[0].area_id).to eq(3000)
        expect(area_data_list[0].area_sub_id).to eq(1)
        expect(area_data_list[1].area_id).to eq(3000)
        expect(area_data_list[1].area_sub_id).to eq(2)
        expect(area_data_list[2].area_id).to eq(3000)
        expect(area_data_list[2].area_sub_id).to eq(3)
      end
    end
  end

  # イベント期間後は空のdictが返されると仮定（現時点では仕様がわからない）
  (15..17).each do |version|
    describe ".parse_cop_info('{}', #{version})" do
      it 'returns nil' do
        # イベントを開催していない期間は、空のdictが返されると仮定
        json = '{}'

        # 引数が空のdictの場合、返り値はnilになる
        cop_info = AdmiralStatsParser.parse_cop_info(json, version)
        expect(cop_info).to be_nil
      end
    end
  end
end
