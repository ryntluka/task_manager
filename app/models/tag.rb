class Tag < ApplicationRecord
  validates :title, presence: true

  has_many :issues
  has_many :tasks, through: :issues
  accepts_nested_attributes_for :issues
  belongs_to :user
end
