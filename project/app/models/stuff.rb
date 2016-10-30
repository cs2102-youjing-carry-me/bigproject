class Stuff < ApplicationRecord
	self.primary_keys = :create_time, :owner_username
  belongs_to :user
  has_many :bid

  def self.get_stuff(create_time, owner_username)
    sql = "SELECT * FROM stuffs WHERE create_time='#{create_time} '"\
      "AND owner_username='#{owner_username}'"
    Stuff.find_by_sql(sql).first
  end

  def self.new_stuff(params)
  	stuff_name = params[:stuff_name]
  	stuff_description = params[:stuff_description]
  	stuff_type = params[:stuff_type]
  	create_time = params[:create_time]
    owner_username = params[:owner_username]
    pick_up_point = params[:pick_up_point]
    return_point = params[:return_point]
    pick_up_time = params[:pick_up_time]
    return_time = params[:return_time]
    create_time = params[:create_time]

    sql = "INSERT INTO offers "\
      "(stuff_name, stuff_description, stuff_type, create_time, owner_username, pick_up_point, return_point, pick_up_time, return_time, create_time) "\
      "VALUES ('#{stuff_name}', '#{stuff_description}', '#{stuff_type}', '#{create_time}', '#{owner_username}', '#{pick_up_point}', '#{return_point}', '#{pick_up_time}', '#{return_point}', '#{create_time}');"
    ActiveRecord::Base.connection.execute sql

    [stuff_name, stuff_description, stuff_type, create_time, owner_username, pick_up_point, return_point, pick_up_time, return_time, create_time]
  end

  def self.search_stuff(stuff_name, stuff_type, pick_up_point, return_point, availability)
    sql = "SELECT * FROM stuffs WHERE stuff_name LIKE '%#{stuff_name}%'"
    sql = sql + "AND stuff_type = '#{stuff_type}'" if stuff_type.present?
    sql = sql + "AND pick_up_point LIKE '%#{pick_up_point}%'"
    sql = sql + "AND return_point LIKE '%#{return_point}%'"
    sql = sql + "AND availability IS NULL" if availability == "on"
    Stuff.find_by_sql(sql)
  end

  def self.popular_pickup_points
    sql = 'SELECT s.pick_up_point, COUNT(DISTINCT s.create_time, s.owner_username) AS num_stuffs, ' \
      'COUNT(DISTINCT b.stuff_create_time, b.owner_username, b.bidder_username) AS num_bids '\
      'FROM stuffs s LEFT JOIN bids b ON b.stuff_create_time = s.create_time AND '\
      'b.owner_username = s.owner_username '\
      'GROUP BY s.pick_up_point ORDER BY num_stuffs DESC, num_bids DESC'
    ActiveRecord::Base.connection.execute(sql).each
  end

  def self.popular_return_points
    sql = 'SELECT s.return_point, COUNT(DISTINCT s.create_time, s.owner_username) AS num_stuffs, ' \
      'COUNT(DISTINCT b.stuff_create_time, b.owner_username, b.bidder_username) AS num_bids '\
      'FROM stuffs s LEFT JOIN bids b ON b.stuff_create_time = s.create_time AND '\
      'b.owner_username = s.owner_username '\
      'GROUP BY s.return_point ORDER BY num_stuffs DESC, num_bids DESC'
    ActiveRecord::Base.connection.execute(sql).each
  end
end
