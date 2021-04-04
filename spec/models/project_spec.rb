require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { build(:project) }
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:position) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
  end
end
