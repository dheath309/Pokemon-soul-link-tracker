class Pokemon < ApplicationRecord
  belongs_to :team
  validates :nickname, length: { minimum: 1 }
end
