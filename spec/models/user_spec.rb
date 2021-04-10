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

  describe 'delete strategies' do
    it 'should delete tasks' do
      user = create(:user)
      task = create(:task, user: user)
      user.destroy
      expect(Task.find_by(id: task.id)).to eq nil
    end
    it 'should delete projects' do
      user = create(:user)
      project = create(:project, user: user)
      user.destroy
      expect(Project.find_by(id: project.id)).to eq nil
    end
    it 'should delete tags' do
      user = create(:user)
      tag = create(:tag, user: user)
      user.destroy
      expect(Tag.find_by(id: tag.id)).to eq nil
    end
  end
end
