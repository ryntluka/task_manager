require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag) }
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:issues) }
    it { should have_many(:tasks).through(:issues) }
  end
end
