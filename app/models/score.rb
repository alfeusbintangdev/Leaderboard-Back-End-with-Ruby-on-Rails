class Score < ApplicationRecord
  belongs_to :player
  validates :value, presence: true
end
