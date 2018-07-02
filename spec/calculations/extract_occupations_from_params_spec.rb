require 'rails_helper' 

describe ExtractOccupationsFromParams do
  subject do
    ExtractOccupationsFromParams.result_for(params: params)
  end

  let!(:court1) { FactoryBot.create(:court) }
  let!(:court2) { FactoryBot.create(:court) }
  let(:params) do
    { 
      "court_#{court1.id}" => [1, 2],
      "court_#{court2.id}" => [2, 3],
      "court_0" => [3, 4]
    }
  end

  it 'Extracts occupation information from params' do
    result = subject
    expect(result.length).to eq 2
    expect(result[court1.id]).to match_array [1, 2]
    expect(result[court2.id]).to match_array [2, 3]
  end
end
