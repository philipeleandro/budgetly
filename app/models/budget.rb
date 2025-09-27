class Budget < ApplicationRecord
  belongs_to :user

  validates :year, :month, presence: true, numericality: { only_integer: true }
  validates :month, inclusion: { in: 1..12 }
  validates :month, uniqueness: { scope: [:year, :user_id] }
end
