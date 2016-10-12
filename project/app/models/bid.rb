class Bid < ApplicationRecord
  belongs_to :stuff
  belongs_to :user
end
