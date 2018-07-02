require 'rails_helper' 

describe CourtsQuery do
  subject do
    CourtsQuery.call
  end

  let!(:court1) { FactoryBot.create(:court) }
  let!(:court2) { FactoryBot.create(:court, :unavailable) }


  it 'Returns available courts only' do
    courts = subject
    expect(courts.count).to eq 1
    expect(courts.first.id).to eq court1.id
  end
end
