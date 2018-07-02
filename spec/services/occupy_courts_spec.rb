require 'rails_helper' 

describe OccupyCourts do
  subject do
    OccupyCourts.call(user.id, date, occupations)
  end

  let!(:user) { FactoryBot.create(:user) }
  let(:date) { Date.tomorrow }
  let!(:court1) { FactoryBot.create(:court) }
  let!(:court2) { FactoryBot.create(:court) }
  let!(:ts1) { FactoryBot.create(:time_slot, order_key: 1000) }
  let!(:ts2) { FactoryBot.create(:time_slot, order_key: 1030) }
  let!(:ctts11) { FactoryBot.create(:court_to_time_slot, court: court1, time_slot: ts1) }
  let!(:ctts12) { FactoryBot.create(:court_to_time_slot, court: court1, time_slot: ts2) }
  let!(:ctts21) { FactoryBot.create(:court_to_time_slot, court: court2, time_slot: ts1) }

  context 'Occupying courts using available time slots' do
    let(:occupations) do
      { court1.id => [ts1.id, ts2.id], court2.id => [ts1.id] }
    end

    it 'Creates occupations' do
      subject
      court1_occupations = court1.reload.occupations
      court2_occupations = court2.reload.occupations

      expect(court1_occupations.count).to eq 2
      expect(court2_occupations.count).to eq 1
    end
  end

  context 'Occupying courts using time slots already occupied' do
    let!(:occupation) { FactoryBot.create(:occupation, date: date, court: court2, time_slot: ts1) }
    let(:occupations) do
      { court1.id => [ts1.id, ts2.id], court2.id => [ts1.id] }
    end

    it 'Raises error and does NOT create new occupations' do
      expect(Occupation.count).to eq 1
      expect{subject}.to raise_error(ActiveRecord::RecordInvalid)
      expect(Occupation.count).to eq 1
    end
  end

  context 'Occupying courts using time slots not belonging to court' do
    let(:occupations) do
      { court1.id => [ts1.id, ts2.id], court2.id => [ts2.id] }
    end

    it 'Raises error and does NOT create new occupations' do
      expect{subject}.to raise_error(ActiveRecord::RecordNotFound)
      expect(Occupation.count).to eq 0
    end
  end

  context 'Occupying disabled courts' do
    let!(:unavailable_court) { FactoryBot.create(:court, :unavailable) }
    let!(:uctts) { FactoryBot.create(:court_to_time_slot, court: unavailable_court, time_slot: ts1) }
    let(:occupations) do
      { court1.id => [ts1.id, ts2.id], unavailable_court.id => [ts1.id] }
    end

    it 'Raises error and does NOT create new occupations' do
      expect{subject}.to raise_error(ActiveRecord::RecordNotFound)
      expect(Occupation.count).to eq 0
    end
  end
end
