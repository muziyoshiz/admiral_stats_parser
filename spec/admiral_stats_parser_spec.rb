require 'spec_helper'

describe AdmiralStatsParser do
  it 'has a version number' do
    expect(AdmiralStatsParser::VERSION).not_to be nil
  end

  describe '#parse_personal_basic' do
    it 'returns "Test String"' do
      expect(AdmiralStatsParser.parse_personal_basic("", 1)).to eq('Test String')
    end
  end
end
