class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  before_destroy :ensure_no_children

  private

  def ensure_no_children
    raise.ActiveRecord::InvalidForeignKey unless self.bookmarks.empty?
  end
end
