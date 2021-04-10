10.times do
  user = FactoryBot.create(:user, password: "Something")
  20.times do
    tag = FactoryBot.create(:tag, user: user)
    project = FactoryBot.create(:project, user: user)
    10.times do
      FactoryBot.create(:task, user: user, project: project, tags: [tag])
    end
  end
end
