class Bid < ApplicationRecord
	self.primary_keys = :stuff_create_time, :owner_username, :bidder_username
  belongs_to :stuff
  belongs_to :user

  def self.get_bid(stuff_create_time, owner_username, bidder_username)
  	sql = "SELECT * FROM bids WHERE stuff_create_time='#{stuff_create_time}' AND "\
      "owner_username='#{owner_username}' AND "\
      "bidder_username='#{bidder_username}';"
    Bid.find_by_sql(sql).first
  end

  def self.new_bid(params)
    stuff_create_time = params[:stuff_create_time]
    owner_username = params[:owner_username]
    bidder_username = params[:bidder_username]
    bidding_points = params[:bidding_points]
    create_time = params[:create_time]

    stuff = Stuff.get_stuff(stuff_create_time, owner_username)
  	return false unless stuff.present?
  	bidder_username = User.get_user(bidder_username)
  	return false unless bidder_username.present?

    sql = "INSERT INTO bids "\
      "(stuff_create_time, owner_username, bidder_username, bidding_points, create_time) "\
      "VALUES ('#{stuff_create_time}', '#{owner_username}', '#{bidder_username}', '#{bidding_points}', '#{create_time}');"
    ActiveRecord::Base.connection.execute sql

    [stuff_create_time, owner_username, bidder_username, bidding_points, create_time]
  end

  def self.update_bid(stuff_create_time, owner_username, bidder_username, new_biding_points)
  	sql = "UPDATE bids "\
      "SET bidding_points = #{new_biding_points.to_i} "\
      "WHERE bids.stuff_create_time='#{stuff_create_time}' AND "\
      "bids.owner_username = '#{owner_username}' AND "\
      "bids.bidder_username = '#{bidder_username}';"
    ActiveRecord::Base.connection.execute sql
  end

  def self.pickup_bid(stuff_create_time, owner_username, bidder_username)
  	stuff = Stuff.get_stuff(stuff_create_time, owner_username)
  	return false unless stuff.present?
  	bidder_username = User.get_user(bidder_username)
  	return false unless bidder_username.present?
  	bid = Bid.get_bid(stuff_create_time, owner_username, bidder_username)
  	
  	sql1 = "UPDATE bids "\
      "SET status=1 "\
      "WHERE stuff_create_time='#{stuff_create_time}' AND "\
      "owner_username='#{owner_username}' AND "\
      "bidder='#{bidder_username_}';"
    ActiveRecord::Base.connection.execute sql1

    sql2 = "UPDATE stuffs "\
      "SET availability=1 "\
      "WHERE stuff_create_time='#{stuff_create_time}' AND "\
      "owner_username='#{owner_username}';"
    ActiveRecord::Base.connection.execute sql2

    sql3 = "UPDATE users "\
      "SET points = points - #{bid.bidding_points.to_i} "\
      "WHERE users.username='#{bidder_username}';"
    ActiveRecord::Base.connection.execute sql3

    sql4 = "UPDATE users "\
      "SET points = points + #{bid.bidding_points.to_i} "\
      "WHERE users.username='#{owner_username}';"
    ActiveRecord::Base.connection.execute sql4
  end

  def self.get_stuff_bids(stuff_create_time, owner_username)
  	sql = "SELECT * FROM bids WHERE stuff_create_time='#{stuff_create_time} '"\
      "AND owner_username='#{owner_username}'"
    Bid.find_by_sql(sql)
  end

  def self.get_taken_stuff_bid(stuff_create_time, owner_username)
  	sql = "SELECT * FROM bids WHERE stuff_create_time='#{stuff_create_time}' AND "\
      "owner_username='#{owner_username}' AND status = 1;"
      Bid.find_by_sql(sql).first
  end
end
