class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.primary_key = 'username'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stuffs, dependent: :destroy
  has_many :bids, dependent: :destroy

  def email_required?
  	false
  end

  def email_changed?
  	false
  end

  def self.new_user(params)
    username = ActiveRecord::Base::sanitize(params[:username])
    password = ActiveRecord::Base::sanitize(params[:password])
    isAdmin = ActiveRecord::Base::sanitize(params[:isAdmin])
    sql = "INSERT INTO users (username, password, isAdmin) VALUES (#{username}, #{password}, #{isAdmin});"
    ActiveRecord::Base.connection.execute sql
    params[:username]
  end

  def self.get_user(username)
    sql = "SELECT * FROM users WHERE username='%#{username}%'"
    User.find_by_sql(sql)
  end

  def self.search_user(username, is_admin, points_lower_limit, points_upper_limit)
    sql = "SELECT * FROM users WHERE username LIKE '%#{username}%'"
    sql = sql + "AND isAdmin = 1" if is_admin == "on"
    sql = sql + "AND points >= '#{points_lower_limit}'" if !points_lower_limit.blank?
    sql = sql + "AND points <= '#{points_upper_limit}'" if !points_upper_limit.blank?
    User.find_by_sql(sql)
  end
end
