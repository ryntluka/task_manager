require 'rails_helper'


describe User, type: :model do
  subject { build(:user) }

  # using shoulda matchers
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:tasks) }
    it { should have_many(:projects) }
    it { should have_many(:tags) }
  end
end
