class Pokemon < ApplicationRecord
  belongs_to :team, touch: true
  validates :pokedex_id, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 898} # TODO Will need updated when new pokemon are available 
  has_many :links, class_name: "Link", foreign_key: "pokemon1_id"
  has_many :linked_pokemon, through: :links, source: "pokemon2"

end
