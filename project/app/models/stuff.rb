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
end
