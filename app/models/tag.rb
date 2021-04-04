class Tag < ApplicationRecord
  validates :title, presence: true

  has_many :issues
  has_many :tasks, through: :issues
  belongs_to :user
end
