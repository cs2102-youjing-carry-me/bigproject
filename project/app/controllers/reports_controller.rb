class ReportsController < ApplicationController
  def popular_pickup
    @points = Stuff.popular_pickup_points
  end

  def popular_return
    @points = Stuff.popular_return_points
  end
end
