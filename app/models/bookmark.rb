class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, presence: true, length: { maximum: 500 }, allow_blank: true
  validates :movie_id, uniqueness: { scope: [:list_id] }
end
