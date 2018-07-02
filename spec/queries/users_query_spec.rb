require 'rails_helper' 

describe UsersQuery do
  subject do
    UsersQuery.call
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:blocked_user) { FactoryBot.create(:user, :blocked) }

  it 'Returns users, not blocked, not demo' do
    users = subject
    expect(users.count).to eq 1
    expect(users.first.id).to eq user.id
  end
end
