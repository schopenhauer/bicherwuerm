class Idea < ApplicationRecord
  belongs_to :user

  #scope :mine, -> { where(user_id: current_user.id) }
end
