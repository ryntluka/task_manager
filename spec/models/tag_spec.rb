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

  describe '.search_by_title' do
    it 'should include title starting with expressions' do
      tag = create(:tag, title: "Hello there")
      expect(Tag.search_by_title("Hel")).to include tag
    end
    it 'should include title ending with expression' do
      tag = create(:tag, title: "Hello there")
      expect(Tag.search_by_title("ere")).to include tag
    end
    it 'should include title containing expression' do
      tag = create(:tag, title: "Hello there")
      expect(Tag.search_by_title("llo")).to include tag
    end
    it 'should include expression ignoring letter case' do
      tag = create(:tag, title: "Hello there")
      expect(Tag.search_by_title("HELLO")).to include tag
    end
    it 'should exclude title which doesn\'t contain expression' do
      tag = create(:tag, title: "Hello there")
      expect(Tag.search_by_title("SO")).not_to include tag
    end
  end
end
