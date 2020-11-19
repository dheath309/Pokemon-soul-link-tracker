class Pokemon < ApplicationRecord
  belongs_to :team
  validates :nickname, length: { minimum: 1 }
  validates :pokedex_id, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 893} # TODO NOTE This value may need changed 
  has_many :links, class_name: "Link", foreign_key: "pokemon1_id"
  has_many :linked_pokemon, through: :links, source: "pokemon2"

end
