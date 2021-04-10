class Task < ApplicationRecord
  validates :title, presence: true
  validates :is_done, :inclusion => [true, false]

  belongs_to :user
  belongs_to :project, optional: true
  has_many :issues
  has_many :tags, through: :issues
  has_one_attached :attachment
  accepts_nested_attributes_for :issues

  scope :active, -> { where is_done: false }
  scope :finished, ->{ where is_done: true }
  scope :filter_by_tags, ->(tag_ids) do
    tags = []
    tag_ids.each { |tag_id| tags.push(Tag.find_by(id: tag_id)) }
    joins(:tags).references(:tags).where(tags: tags)
  end
  scope :search_by_title, ->(expr) { where("tasks.title ILIKE ?", "%#{expr}%") }
end