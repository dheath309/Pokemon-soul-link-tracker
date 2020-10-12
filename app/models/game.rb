class Game < ApplicationRecord
  validates :room_id, length: { in: 7..20 }
end
