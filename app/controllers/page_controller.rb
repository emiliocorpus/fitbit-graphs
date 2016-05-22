class PageController < ApplicationController

  def home
  	if current_user
      p params
  		redirect_to action: 'user', id: current_user.id
  	else
  		p "==="*50
  	end
  end

  def user
  	if current_user
        user_data = current_user.fitbit_client
        output = user_data.heartrate_time_series(start_date: Date.today, period: '30d').body
        raw_data = parse_faraday(output)
        binding.pry
        data = parse_fitbit(raw_data["activities-heart"])

        # FOR ERROR CHECKING MUST REFRESH TOKEN, TRY REFRESH TOKEN MESSAGE

        @data_set = data
  	else
  		redirect_to root_path
  	end
  end

  private
  def parse_fitbit(data)
    labels = []
    values = []
    data.each do |item|
      labels.push(item['dateTime'])
      if item['value']['heartRateZones'].first['caloriesOut'] === nil
        values.push(0)
      else
        values.push(item['value']['heartRateZones'].first['caloriesOut'])
      end

    end

    new_data = {
      values: values,
      days: 30
    }
  end

  def parse_faraday(body)
    JSON.parse(body)
  end


  def value_parser(value)
    # function to format the date time to fixnum
  end

end


# [{"dateTime"=>"2016-03-08",
#   "value"=>
#    {"customHeartRateZones"=>[],
#     "heartRateZones"=>
#      [{"caloriesOut"=>2158.8759,
#        "max"=>97,
#        "min"=>30,
#        "minutes"=>1079,
#        "name"=>"Out of Range"},
#       {"caloriesOut"=>856.154,
#        "max"=>135,
#        "min"=>97,
#        "minutes"=>90,
#        "name"=>"Fat Burn"},
#       {"caloriesOut"=>293.95465,
#        "max"=>164,
#        "min"=>135,
#        "minutes"=>22,
#        "name"=>"Cardio"},
#       {"caloriesOut"=>0, "max"=>220, "min"=>164, "minutes"=>0, "name"=>"Peak"}],
#     "restingHeartRate"=>49}},

# .....


# ]







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