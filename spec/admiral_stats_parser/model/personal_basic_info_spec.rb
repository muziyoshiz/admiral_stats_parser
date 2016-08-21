require 'spec_helper'

describe PersonalBasicInfo do
  describe '#title_id_to_s' do
    it 'returns name of title' do
      info = PersonalBasicInfo.new

      info.title_id = 1
      expect(info.title_id_to_s).to eq('1')

      info.title_id = 2
      expect(info.title_id_to_s).to eq('2')

      info.title_id = 3
      expect(info.title_id_to_s).to eq('3')

      info.title_id = 4
      expect(info.title_id_to_s).to eq('4')

      info.title_id = 5
      expect(info.title_id_to_s).to eq('5')

      info.title_id = 6
      expect(info.title_id_to_s).to eq('6')

      info.title_id = 7
      expect(info.title_id_to_s).to eq('中将')

      info.title_id = 8
      expect(info.title_id_to_s).to eq('8')

      info.title_id = nil
      expect(info.title_id_to_s).to eq('')
    end
  end
end
