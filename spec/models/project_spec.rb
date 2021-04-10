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

  describe '.search_by_title' do
    it 'should include title starting with expressions' do
      project = create(:project, title: "Hello there")
      expect(Project.search_by_title("Hel")).to include project
    end
    it 'should include title ending with expression' do
      project = create(:project, title: "Hello there")
      expect(Project.search_by_title("ere")).to include project
    end
    it 'should include title containing expression' do
      project = create(:project, title: "Hello there")
      expect(Project.search_by_title("llo")).to include project
    end
    it 'should include expression ignoring letter case' do
      project = create(:project, title: "Hello there")
      expect(Project.search_by_title("HELLO")).to include project
    end
    it 'should exclude title which doesn\'t contain expression' do
      project = create(:project, title: "Hello there")
      expect(Project.search_by_title("SO")).not_to include project
    end
  end
end
