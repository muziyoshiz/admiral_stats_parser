require 'spec_helper'

describe CharacterListInfo do
  describe '#lv_to_exp' do
    it 'returns sum of experience points' do
      info = CharacterListInfo.new
      info.lv = 1
      expect(info.lv_to_exp).to eq(0)

      info.lv = 2
      expect(info.lv_to_exp).to eq(100)

      info.lv = 50
      expect(info.lv_to_exp).to eq(122500)

      info.lv = 51
      expect(info.lv_to_exp).to eq(127500)

      info.lv = 52
      expect(info.lv_to_exp).to eq(132700)

      info.lv = 60
      expect(info.lv_to_exp).to eq(181500)

      info.lv = 61
      expect(info.lv_to_exp).to eq(188500)

      info.lv = 62
      expect(info.lv_to_exp).to eq(195800)

      info.lv = 70
      expect(info.lv_to_exp).to eq(265000)

      info.lv = 71
      expect(info.lv_to_exp).to eq(275000)

      info.lv = 72
      expect(info.lv_to_exp).to eq(285400)

      info.lv = 80
      expect(info.lv_to_exp).to eq(383000)

      info.lv = 81
      expect(info.lv_to_exp).to eq(397000)

      info.lv = 82
      expect(info.lv_to_exp).to eq(411500)

      info.lv = 90
      expect(info.lv_to_exp).to eq(545500)

      info.lv = 91
      expect(info.lv_to_exp).to eq(564500)

      info.lv = 92
      expect(info.lv_to_exp).to eq(584500)

      info.lv = 99
      expect(info.lv_to_exp).to eq(1000000)

      # Lv 100 には、ケッコンカッコカリ後に自動的に上がるため、経験値は増えない
      info.lv = 100
      expect(info.lv_to_exp).to eq(1000000)

      info.lv = 101
      expect(info.lv_to_exp).to eq(1010000)

      info.lv = 102
      expect(info.lv_to_exp).to eq(1011000)

      info.lv = 111
      expect(info.lv_to_exp).to eq(1065000)

      info.lv = 112
      expect(info.lv_to_exp).to eq(1077000)

      info.lv = 116
      expect(info.lv_to_exp).to eq(1145000)

      info.lv = 117
      expect(info.lv_to_exp).to eq(1168000)

      info.lv = 121
      expect(info.lv_to_exp).to eq(1290000)

      info.lv = 122
      expect(info.lv_to_exp).to eq(1329000)

      info.lv = 131
      expect(info.lv_to_exp).to eq(1860000)

      info.lv = 132
      expect(info.lv_to_exp).to eq(1940000)

      info.lv = 140
      expect(info.lv_to_exp).to eq(2760000)

      info.lv = 141
      expect(info.lv_to_exp).to eq(2887000)

      info.lv = 145
      expect(info.lv_to_exp).to eq(3465000)

      info.lv = 146
      expect(info.lv_to_exp).to eq(3628000)

      info.lv = 150
      expect(info.lv_to_exp).to eq(4360000)

      info.lv = 151
      expect(info.lv_to_exp).to eq(4564000)

      info.lv = 155
      expect(info.lv_to_exp).to eq(5470000)

      info.lv = 156
      expect(info.lv_to_exp).to be_nil

      info.lv = nil
      expect(info.lv_to_exp).to be_nil
    end
  end

  describe '#lv_and_exp_percent_to_exp' do
    it 'returns sum of experience points' do
      info = CharacterListInfo.new

      # レベル1、経験値0の場合は0
      info.lv = 1
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(0)

      info.lv = 1
      info.exp_percent = nil
      expect(info.lv_and_exp_percent_to_exp).to eq(0)

      # レベル2に必要な経験値100の10%
      info.lv = 1
      info.exp_percent = 10
      expect(info.lv_and_exp_percent_to_exp).to eq(10)

      info.lv = 98
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(851500)

      info.lv = 99
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(1000000)

      info.lv = 100
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(1000000)

      info.lv = 150
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(4360000)

      # 98 -> 99 は 148500
      # その 11% は 16335
      info.lv = 98
      info.exp_percent = 11
      expect(info.lv_and_exp_percent_to_exp).to eq(851500 + 16335)

      # 過去のデータ（exp_percent が nil）もサポート
      info.lv = 98
      info.exp_percent = nil
      expect(info.lv_and_exp_percent_to_exp).to eq(851500)

      info.lv = 99
      info.exp_percent = nil
      expect(info.lv_and_exp_percent_to_exp).to eq(1000000)

      # レベル上限に到達した場合
      info.lv = 155
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to eq(5470000)

      info.lv = nil
      info.exp_percent = 0
      expect(info.lv_and_exp_percent_to_exp).to be_nil
    end
  end
end
