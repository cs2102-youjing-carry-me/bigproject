class Bid < ApplicationRecord
	self.primary_keys = :stuff_create_time, :owner_username, :bidder
  belongs_to :stuff
  belongs_to :user
end
