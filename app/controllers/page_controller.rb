class PageController < ApplicationController

  def home
  	if current_user 
  		redirect_to action: 'user', id: current_user.id
  	else
  		p "==="*50
  	end
  end

  def user
  	if current_user
        # today = Date.today
        # month_ago = today - 30
        # # output = current_user.fitbit_client.heartrate_time_series(start_date: month_ago.strftime, period: '30d')
        # @output = output["activities-heart"]
  	else
  		redirect_to root_path
  	end
  end
end







# "activities-heart" =>
#   [{"dateTime"=>"2016-03-06",
#       "value"=>
#        {"customHeartRateZones"=>[],
#         "heartRateZones"=>
#          [{"caloriesOut"=>2219.94348, "max"=>97, "min"=>30, "minutes"=>1204, "name"=>"Out of Range"},
#           {"caloriesOut"=>214.32536, "max"=>135, "min"=>97, "minutes"=>24, "name"=>"Fat Burn"},
#           {"caloriesOut"=>0, "max"=>164, "min"=>135, "minutes"=>0, "name"=>"Cardio"},
#           {"caloriesOut"=>0, "max"=>220, "min"=>164, "minutes"=>0, "name"=>"Peak"}],
#         "restingHeartRate"=>48}},