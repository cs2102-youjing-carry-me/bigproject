class ReportsController < ApplicationController
  def popular_pickup
    @points = Stuff.popular_pickup_points
  end
end
