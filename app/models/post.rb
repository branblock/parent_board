class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  # Posts generally are sorted by most recent
  scope :most_recent, -> { order(updated_at: :desc) }

  # acts_as_taggable_on gem implementation
  acts_as_taggable_on :tags

end
