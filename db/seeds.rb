10.times do
  user = FactoryBot.create(:user, password: "Something")
  10.times do
    project = FactoryBot.create(:project, user: user)
    10.times do
      FactoryBot.create(:task, user: user, project: project)
    end
  end
end
