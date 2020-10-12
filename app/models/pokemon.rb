class Pokemon < ApplicationRecord
  belongs_to :team
  validates :nickname, length: { minimum: 1 }
  validates :pokedex_id, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 893}
end
