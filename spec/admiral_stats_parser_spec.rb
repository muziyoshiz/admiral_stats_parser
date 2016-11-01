require 'spec_helper'

describe AdmiralStatsParser do
  it 'has a version number' do
    expect(AdmiralStatsParser::VERSION).not_to be nil
  end

  describe '.get_latest_api_version' do
    it 'returns 4' do
      expect(AdmiralStatsParser.get_latest_api_version).to eq(4)
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

    # 2016-10-27 〜
    it 'returns 4' do
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2016-10-27T07:00:00+0900'))).to eq(4)

      # 遠い未来の場合は、最新バージョンを返す
      expect(AdmiralStatsParser.guess_api_version(Time.parse('2200-01-01T00:00:00+0900'))).to eq(4)
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
    end
  end

  # 基本情報は version 2 〜 4 で仕様が同じ
  (2..4).each do |version|
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

  # 海域情報は version 2 〜 4 で仕様が同じ
  (2..4).each do |version|
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

  # 艦娘図鑑は version 2 〜 4 で仕様が同じ
  (2..4).each do |version|
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

  # 装備図鑑は version 1 〜 4 で仕様が同じ
  (1..4).each do |version|
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

  describe '.parse_equip_list_info(json, 1)' do
    it 'raises' do
      json = '[{"type":1,"equipmentId":1,"name":"12cm単装砲","num":8,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":2,"name":"12.7cm連装砲","num":31,"img":"equip_icon_1_1984kzwm2f7s.png"},{"type":1,"equipmentId":3,"name":"10cm連装高角砲","num":6,"img":"equip_icon_26_rv74l134q7an.png"}]'

      expect { AdmiralStatsParser.parse_equip_list_info(json, 1) }.to raise_error('API version 1 does not support equip list info')
    end
  end

  # 装備一覧は version 2 〜 4 で仕様が同じ
  (2..4).each do |version|
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

  describe ".parse_event_info(json, 4)" do
    it 'returns EventInfo[]' do
      # E-1 クリア、E-5 未クリア
      json = '[{"areaId":1000,"areaSubId":1,"level":"HEI","areaKind":"NORMAL","stageImageName":"area_14yzzpb2ab.png","stageMissionName":"前哨戦","stageMissionInfo":"敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！","requireGp":300,"limitSec":240,"rewardList":[{"rewardType":"FIRST","dataId":0,"kind":"ROOM_ITEM_COIN","value":50},{"rewardType":"FIRST","dataId":1,"kind":"RESULT_POINT","value":500},{"rewardType":"SECOND","dataId":0,"kind":"RESULT_POINT","value":200}],"stageDropItemInfo":["SMALLBOX","MEDIUMBOX","SMALLREC","NONE"],"sortieLimit":false,"areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},' +
          '{"areaId":1000,"areaSubId":5,"level":"HEI","areaKind":"SWEEP","stageImageName":"area_0555h7ae9d.png","stageMissionName":"？","stageMissionInfo":"？","requireGp":0,"limitSec":0,"rewardList":[{"dataId":0,"kind":"NONE","value":0}],"stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"sortieLimit":false,"areaClearState":"NOTCLEAR","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]'

      results = AdmiralStatsParser.parse_event_info(json, 4)

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
    end
  end

  describe ".summarize_event_info(json, 4)" do
    it 'returns summary' do
      # E-1 クリア、E-5 未クリア
      json = '[{"areaId":1000,"areaSubId":1,"level":"HEI","areaKind":"NORMAL","stageImageName":"area_14yzzpb2ab.png","stageMissionName":"前哨戦","stageMissionInfo":"敵泊地へ強襲作戦が発令された！\n主作戦に先立ち、敵泊地海域付近の\n偵察を実施せよ！","requireGp":300,"limitSec":240,"rewardList":[{"rewardType":"FIRST","dataId":0,"kind":"ROOM_ITEM_COIN","value":50},{"rewardType":"FIRST","dataId":1,"kind":"RESULT_POINT","value":500},{"rewardType":"SECOND","dataId":0,"kind":"RESULT_POINT","value":200}],"stageDropItemInfo":["SMALLBOX","MEDIUMBOX","SMALLREC","NONE"],"sortieLimit":false,"areaClearState":"CLEAR","militaryGaugeStatus":"BREAK","eneMilitaryGaugeVal":1000,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1},' +
          '{"areaId":1000,"areaSubId":5,"level":"HEI","areaKind":"SWEEP","stageImageName":"area_0555h7ae9d.png","stageMissionName":"？","stageMissionInfo":"？","requireGp":0,"limitSec":0,"rewardList":[{"dataId":0,"kind":"NONE","value":0}],"stageDropItemInfo":["UNKNOWN","NONE","NONE","NONE"],"sortieLimit":false,"areaClearState":"NOTCLEAR","militaryGaugeStatus":"NONE","eneMilitaryGaugeVal":0,"militaryGaugeLeft":0,"bossStatus":"NONE","loopCount":1}]'

      event_info_list = AdmiralStatsParser.parse_event_info(json, 4)

      hei_results = AdmiralStatsParser.summarize_event_info(event_info_list, "HEI", 4)
      expect(hei_results[:opened]).to be true
      expect(hei_results[:all_cleared]).to be false
      expect(hei_results[:current_loop_counts]).to eq(1)
      expect(hei_results[:cleared_loop_counts]).to eq(0)
      expect(hei_results[:cleared_stage_no]).to eq(1)
      expect(hei_results[:current_military_gauge_left]).to eq(0)
    end
  end
end
