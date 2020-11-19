class Link < ApplicationRecord
  belongs_to :pokemon1, class_name: "Pokemon", foreign_key: "pokemon1_id"
  belongs_to :pokemon2, class_name: "Pokemon", foreign_key: "pokemon2_id"
end
