class Follow < ApplicationRecord
  belongs_to :follower, class_name: "Player"
  belongs_to :followed, class_name: "Player"

  # Validasi custom supaya tidak bisa follow diri sendiri
  validate :cannot_follow_self

  private

  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:follower_id, "cannot follow yourself")
    end
  end
end
