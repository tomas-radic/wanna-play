require 'rails_helper' 

describe OccupiedTimeSlotsForDay do
  subject do
    OccupiedTimeSlotsForDay.call(date, Court.all.includes(:occupations)).result
  end

  let(:date) { Date.yesterday }
  let!(:court1) { FactoryBot.create(:court) }
  let!(:court2) { FactoryBot.create(:court) }
  let!(:ts1) { FactoryBot.create(:time_slot, order_key: 1000) }
  let!(:ts2) { FactoryBot.create(:time_slot, order_key: 1030) }
  let!(:ts3) { FactoryBot.create(:time_slot, order_key: 1100) }
  let!(:ts4) { FactoryBot.create(:time_slot, order_key: 1130) }
  let!(:occupation11) { FactoryBot.create(:occupation, court: court1, time_slot: ts1, date: date) }
  let!(:occupation12) { FactoryBot.create(:occupation, court: court1, time_slot: ts2, date: date) }
  let!(:occupation13x) { FactoryBot.create(:occupation, court: court1, time_slot: ts3, date: Date.today) }
  let!(:occupation22) { FactoryBot.create(:occupation, court: court2, time_slot: ts2, date: date) }
  let!(:occupation23) { FactoryBot.create(:occupation, court: court2, time_slot: ts3, date: date) }
  let!(:occupation24) { FactoryBot.create(:occupation, court: court2, time_slot: ts4, date: date) }
  let!(:occupation21x) { FactoryBot.create(:occupation, court: court2, time_slot: ts1, date: Date.tomorrow) }

  it 'Returns hash describing occupied time slots of courts for given day' do
    result = subject
    
    expect(result).to be_a Hash
    expect(result.length).to eq 2
    
    expect(result[court1.id].length).to eq 2
    expect(result[court1.id]).to include(ts1.id => occupation11.id, ts2.id => occupation12.id)
    
    expect(result[court2.id].length).to eq 3
    expect(result[court2.id]).to include(ts2.id => occupation22.id, ts3.id => occupation23.id, ts4.id => occupation24.id)
  end
end
