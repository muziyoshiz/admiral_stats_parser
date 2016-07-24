# -*- coding: utf-8 -*-
require 'spec_helper'

describe AdmiralStatsParser do
  it 'has a version number' do
    expect(AdmiralStatsParser::VERSION).not_to be nil
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
    end
  end

  describe '.parse_personal_basic_info(json, 2)' do
    it 'returns PersonalBasicInfo' do
      json = '{"admiralName":"ABCDEFGH","fuel":6750,"ammo":6183,"steel":7126,"bauxite":6513,"bucket":46,"level":32,"roomItemCoin":82,"resultPoint":"3571","rank":"圏外","titleId":7,"materialMax":7200,"strategyPoint":915}'
      result = AdmiralStatsParser.parse_personal_basic_info(json, 2)

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
      expect(result.stage_image_name).to eq("area_0c6tpjoayu.png")
      expect(result.stage_mission_name).to eq("南１号作戦")
      expect(result.stage_mission_info).to eq("南西諸島の防衛ライン上の敵侵攻艦隊を捕捉、全力出撃でこれを撃滅せよ！")
      expect(result.stage_clear_item_info).to eq("MEISTER")
      expect(result.stage_drop_item_info).to eq(["BUCKET", "SMALLBOX", "SMALLREC", "NONE"])
      expect(result.area_clear_state).to eq("NOTCLEAR")

      result = results[1]
      expect(result.area_id).to eq(2)
      expect(result.area_sub_id).to eq(1)
      expect(result.limit_sec).to eq(0)
      expect(result.require_gp).to be_nil
      expect(result.pursuit_map).to eq(false)
      expect(result.pursuit_map_open).to eq(false)
      expect(result.sortie_limit).to be_nil
      expect(result.stage_image_name).to eq("area_8nzeirxrui.png")
      expect(result.stage_mission_name).to eq("？")
      expect(result.stage_mission_info).to eq("？")
      expect(result.stage_clear_item_info).to eq("UNKNOWN")
      expect(result.stage_drop_item_info).to eq(["UNKNOWN", "NONE", "NONE", "NONE"])
      expect(result.area_clear_state).to eq("NOOPEN")
    end
  end

  describe '.parse_area_capture_info(json, 2)' do
    it 'returns AreaCaptureInfo[]' do
      json = '[{"areaId":1,"areaSubId":1,"limitSec":150,"requireGp":150,"pursuitMap":false,"pursuitMapOpen":true,"sortieLimit":false,"stageImageName":"area_rprx04hjnl.png","stageMissionName":"近海警備","stageMissionInfo":"鎮守府正面近海の警備に出動せよ！","stageClearItemInfo":"MEISTER","stageDropItemInfo":["BUCKET","NONE","NONE","NONE"],"areaClearState":"CLEAR"},{"areaId":1,"areaSubId":1,"limitSec":90,"requireGp":100,"pursuitMap":true,"pursuitMapOpen":false,"sortieLimit":false,"stageImageName":"area_rprx04hjnl.png","stageMissionName":"近海警備","stageMissionInfo":"鎮守府正面近海の敵艦隊を追撃せよ！","stageClearItemInfo":"NONE","stageDropItemInfo":["NONE","NONE","NONE","NONE"],"areaClearState":"CLEAR"}]'

      results = AdmiralStatsParser.parse_area_capture_info(json, 2)

      expect(results.size).to eq(2)

      result = results[0]
      expect(result.area_id).to eq(1)
      expect(result.area_sub_id).to eq(1)
      expect(result.limit_sec).to eq(150)
      expect(result.require_gp).to eq(150)
      expect(result.pursuit_map).to eq(false)
      expect(result.pursuit_map_open).to eq(true)
      expect(result.sortie_limit).to eq(false)
      expect(result.stage_image_name).to eq("area_rprx04hjnl.png")
      expect(result.stage_mission_name).to eq("近海警備")
      expect(result.stage_mission_info).to eq("鎮守府正面近海の警備に出動せよ！")
      expect(result.stage_clear_item_info).to eq("MEISTER")
      expect(result.stage_drop_item_info).to eq(["BUCKET", "NONE", "NONE", "NONE"])
      expect(result.area_clear_state).to eq("CLEAR")

      result = results[1]
      expect(result.area_id).to eq(1)
      expect(result.area_sub_id).to eq(1)
      expect(result.limit_sec).to eq(90)
      expect(result.require_gp).to eq(100)
      expect(result.pursuit_map).to eq(true)
      expect(result.pursuit_map_open).to eq(false)
      expect(result.sortie_limit).to eq(false)
      expect(result.stage_image_name).to eq("area_rprx04hjnl.png")
      expect(result.stage_mission_name).to eq("近海警備")
      expect(result.stage_mission_info).to eq("鎮守府正面近海の敵艦隊を追撃せよ！")
      expect(result.stage_clear_item_info).to eq("NONE")
      expect(result.stage_drop_item_info).to eq(["NONE", "NONE", "NONE", "NONE"])
      expect(result.area_clear_state).to eq("CLEAR")
    end
  end

  describe '.parse_tc_book_info(json, 1)' do
    it 'returns TcBookInfo[]' do
      json = '[{"bookNo":1,"shipClass":"","shipClassIndex":-1,"shipType":"","shipName":"未取得","cardIndexImg":"","cardImgList":[],"variationNum":0,"acquireNum":0},{"bookNo":2,"shipClass":"長門型","shipClassIndex":2,"shipType":"戦艦","shipName":"陸奥","cardIndexImg":"s/tc_2_tjpm66z1epc6.jpg","cardImgList":["s/tc_2_tjpm66z1epc6.jpg","","","","",""],"variationNum":6,"acquireNum":1}]'

      results = AdmiralStatsParser.parse_tc_book_info(json, 1)

      expect(results.size).to eq(2)

      result = results[0]
      expect(result.book_no).to eq(1)
      expect(result.ship_class).to eq("")
      expect(result.ship_class_index).to eq(-1)
      expect(result.ship_type).to eq("")
      expect(result.ship_name).to eq("未取得")
      expect(result.card_index_img).to eq("")
      expect(result.card_img_list).to eq([])
      expect(result.variation_num).to eq(0)
      expect(result.acquire_num).to eq(0)
      expect(result.lv).to be_nil
      expect(result.status_img).to be_nil

      result = results[1]
      expect(result.book_no).to eq(2)
      expect(result.ship_class).to eq("長門型")
      expect(result.ship_class_index).to eq(2)
      expect(result.ship_type).to eq("戦艦")
      expect(result.ship_name).to eq("陸奥")
      expect(result.card_index_img).to eq("s/tc_2_tjpm66z1epc6.jpg")
      expect(result.card_img_list).to eq(["s/tc_2_tjpm66z1epc6.jpg","","","","",""])
      expect(result.variation_num).to eq(6)
      expect(result.acquire_num).to eq(1)
      expect(result.lv).to be_nil
      expect(result.status_img).to be_nil
    end
  end

  describe '.parse_tc_book_info(json, 2)' do
    it 'returns TcBookInfo[]' do
      json = '[{"bookNo":1,"shipClass":"長門型","shipClassIndex":1,"shipType":"戦艦","shipName":"長門","cardIndexImg":"s/tc_1_d7ju63kolamj.jpg","cardImgList":["","","s/tc_1_gk42czm42s3p.jpg","","",""],"variationNum":6,"acquireNum":1,"lv":23,"statusImg":["i/i_d7ju63kolamj_n.png"]},{"bookNo":5,"shipClass":"","shipClassIndex":-1,"shipType":"","shipName":"未取得","cardIndexImg":"","cardImgList":[],"variationNum":0,"acquireNum":0,"lv":0,"statusImg":[]}]'

      results = AdmiralStatsParser.parse_tc_book_info(json, 2)

      expect(results.size).to eq(2)

      result = results[0]
      expect(result.book_no).to eq(1)
      expect(result.ship_class).to eq("長門型")
      expect(result.ship_class_index).to eq(1)
      expect(result.ship_type).to eq("戦艦")
      expect(result.ship_name).to eq("長門")
      expect(result.card_index_img).to eq("s/tc_1_d7ju63kolamj.jpg")
      expect(result.card_img_list).to eq(["","","s/tc_1_gk42czm42s3p.jpg","","",""])
      expect(result.variation_num).to eq(6)
      expect(result.acquire_num).to eq(1)
      expect(result.lv).to eq(23)
      expect(result.status_img).to eq(["i/i_d7ju63kolamj_n.png"])

      result = results[1]
      expect(result.book_no).to eq(5)
      expect(result.ship_class).to eq("")
      expect(result.ship_class_index).to eq(-1)
      expect(result.ship_type).to eq("")
      expect(result.ship_name).to eq("未取得")
      expect(result.card_index_img).to eq("")
      expect(result.card_img_list).to eq([])
      expect(result.variation_num).to eq(0)
      expect(result.acquire_num).to eq(0)
      expect(result.lv).to eq(0)
      expect(result.status_img).to eq([])
    end
  end
end
