require 'rails_helper' 

describe ReleaseTimeSlot do
  subject do
    ReleaseTimeSlot.call(court.id, date, time_slot.id)
  end

  let(:date) { Date.today }
  let!(:court1) { FactoryBot.create(:court) }
  let!(:court2) { FactoryBot.create(:court) }
  let!(:ts1) { FactoryBot.create(:time_slot, order_key: 1000) }
  let!(:ts2) { FactoryBot.create(:time_slot, order_key: 1030) }
  let!(:occupation11) { FactoryBot.create(:occupation, date: Date.today, court: court1, time_slot: ts1) }
  let!(:occupation12) { FactoryBot.create(:occupation, date: Date.today, court: court1, time_slot: ts2) }
  let!(:occupation11x) { FactoryBot.create(:occupation, date: Date.tomorrow, court: court1, time_slot: ts1) }
  let!(:occupation21) { FactoryBot.create(:occupation, date: Date.today, court: court2, time_slot: ts1) }

  context 'Releasing occupied time slots' do
    it 'Releases time slots' do
      ReleaseTimeSlot.call(court1.id, Date.today, ts1.id)
      expect(Occupation.count).to eq 3
      expect(Occupation.all.pluck(:id)).to match_array [occupation12.id, occupation11x.id, occupation21.id]

      ReleaseTimeSlot.call(court1.id, Date.today, ts2.id)
      expect(Occupation.count).to eq 2
      expect(Occupation.all.pluck(:id)).to match_array [occupation11x.id, occupation21.id]

      ReleaseTimeSlot.call(court1.id, Date.tomorrow, ts1.id)
      expect(Occupation.count).to eq 1
      expect(Occupation.all.pluck(:id)).to match_array [occupation21.id]
    end
  end

  context 'Releasing available time slots' do
    subject do
      ReleaseTimeSlot.call(court2.id, Date.tomorrow, ts2.id)
    end
    
    it 'Raises error and does not release anything' do
      expect{subject}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
