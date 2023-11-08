class Book < ApplicationRecord
  belongs_to :user

  validates :title, :author, presence: true
  validate :valid_publication_date?

  def valid_publication_date?
    errors.add(:publication_date, :blank) unless publication_date.present?
    publication_date&.to_date
  rescue Date::Error
    errors.add(:publication_date, :invalid)
  end
end
