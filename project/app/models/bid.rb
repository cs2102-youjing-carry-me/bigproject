class Bid < ApplicationRecord
	self.primary_keys = :stuff_create_time, :owner_username, :bidder
  belongs_to :stuff
  belongs_to :user

  def self.get_stuff_bids(stuff_create_time, owner_username)
  	sql = "SELECT * FROM bids WHERE stuff_create_time='#{stuff_create_time} '"\
      "AND owner_username='#{owner_username}'"
    Bid.find_by_sql(sql)
  end
end
