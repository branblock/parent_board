class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  scope :most_recent, -> { order(updated_at: :desc) }
end
