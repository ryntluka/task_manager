require 'rails_helper'

RSpec.describe Task, type: :model do
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

  describe '.active' do
    it 'should include active tasks' do
      task = create(:task, is_done: false)
      expect(Task.active).to include task
    end
    it 'should exclude finished tasks' do
      task = create(:task, is_done: true)
      expect(Task.active).not_to include task
    end
  end

  describe '.finished' do
    it 'should include finished tasks' do
      task = create(:task, is_done: true)
      expect(Task.finished).to include task
    end
    it 'should exclude active tasks' do
      task = create(:task, is_done: false)
      expect(Task.finished).not_to include task
    end
  end

  describe '.search_by_title' do
    it 'should include title starting with expressions' do
      task = create(:task, title: "Hello there")
      expect(Task.search_by_title("Hel")).to include task
    end
    it 'should include title ending with expression' do
      task = create(:task, title: "Hello there")
      expect(Task.search_by_title("ere")).to include task
    end
    it 'should include title containing expression' do
      task = create(:task, title: "Hello there")
      expect(Task.search_by_title("llo")).to include task
    end
    it 'should include expression ignoring letter case' do
      task = create(:task, title: "Hello there")
      expect(Task.search_by_title("HELLO")).to include task
    end
    it 'should exclude title which doesn\'t contain expression' do
      task = create(:task, title: "Hello there")
      expect(Task.search_by_title("SO")).not_to include task
    end
  end

  describe '.filter_by_tags' do
    it 'should include task with tag' do
      tag = create(:tag)
      task = create(:task, tags: [tag])
      expect(Task.filter_by_tags([tag.id,])).to include task
    end
    it 'should exclude task without tag' do
      tag = create(:tag)
      task = create(:task)
      expect(Task.filter_by_tags([tag.id,])).not_to include task
    end
    it 'should include task with multiple tags' do
      tag1 = create(:tag)
      tag2 = create(:tag)
      task = create(:task, tags: [tag1, tag2])
      expect(Task.filter_by_tags([tag1.id,])).to include task
      expect(Task.filter_by_tags([tag2.id,])).to include task
    end
  end

  describe 'delete strategies' do
    it 'should not delete user' do
      user = create(:user)
      task = create(:task, user: user)
      task.destroy
      expect(User.find_by(id: user.id)).not_to eq nil
    end
    it 'should not delete projects' do
      project = create(:project)
      task = create(:task, project: project)
      task.destroy
      expect(Project.find_by(id: project.id)).not_to eq nil
    end
    it 'should not delete tags' do
      tag = create(:tag)
      task = create(:task, tags: [tag])
      task.destroy
      expect(Tag.find_by(id: tag.id)).not_to eq nil
    end
  end
end