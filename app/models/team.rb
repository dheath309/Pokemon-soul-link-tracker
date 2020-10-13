class Team < ApplicationRecord
  belongs_to :game
  has_many :pokemons, dependent: :delete_all
end
