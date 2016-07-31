# -*- coding: utf-8 -*-
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

      info.lv = 100
      expect(info.lv_to_exp).to be_nil

      info.lv = nil
      expect(info.lv_to_exp).to be_nil
    end
  end
end
