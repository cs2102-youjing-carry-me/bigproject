class Stuff < ApplicationRecord
	self.primary_keys = :create_time, :owner_username
  belongs_to :user
  has_many :bid

  def self.get_stuff(create_time, owner_username)
    sql = "SELECT * FROM stuffs WHERE create_time='#{create_time} '"\
      "AND owner_username='#{owner_username}'"
    Stuff.find_by_sql(sql).first
  end
end
