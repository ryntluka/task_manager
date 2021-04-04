require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:task) }
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_inclusion_of(:is_done).in_array([true, false]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:issues) }
    it { should have_many(:tags).through(:issues) }
  end
end
