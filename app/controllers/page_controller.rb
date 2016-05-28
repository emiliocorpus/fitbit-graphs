class PageController < ApplicationController

  def home
  	if current_user
  		redirect_to action: 'user', id: current_user.id
  	end
  end

  def user
  	if current_user.id === params[:id].to_i
      p params['request']
      requested_data = parse_faraday(handle_graph(params['request']))
      if requested_data.has_key? 'errors'
        sign_out current_user
        redirect_to root_path
      else
        if params['request'] === 'badges'
          @data_set = {badges: requested_data, selected: params['request']} 
        else
          @data_set = parse_fitbit(requested_data)
          @data_set[:selected] = params['request']
        end
      end
  	else
  		redirect_to root_path
  	end
  end

  def summary
  end

  def about
  end

  private
  def parse_fitbit(data)
    labels = []
    values = []
    Hash[*data.first].values.first.each do |item|
      labels.push(item['dateTime'])
      if item['value'] === nil
        values.push(0)
      else
        values.push(item['value'].to_i)
      end
    end
    new_data = {
      values: values,
      days: 30,
      user_info: gather_user_info['user']
    }
  end

  def handle_graph(param)
    case param
    when 'calories'
      data = current_user.fitbit_client.activity_time_series(resource: 'calories', start_date: Date.today, period: '30d')
    when 'badges'
      data = current_user.fitbit_client.badges
    when 'steps'
      data = current_user.fitbit_client.activity_time_series(resource: 'steps', start_date: Date.today, period: '30d')
    else
      data = current_user.fitbit_client.activity_time_series(resource: 'calories', start_date: Date.today, period: '30d')
    end
    data
  end

  def gather_user_info
    parse_faraday(current_user.fitbit_client.user_info)
  end

  def parse_faraday(response)
    p response
    JSON.parse(response.body)
  end
end





# THIS IS ERROR MESSAGE FOR WHEN RATE LIMIT HAS BEEN EXCEEDED
# Started GET "/users/auth/fitbit_oauth2/callback?state=ed2677ee904511fb606fe8a3bcb0eea0b81571be2f185e8a&code=53fbf1c3ab9db0edea7fef723428c0d6b20f150d" for ::1 at 2016-05-24 17:54:01 -0400
# I, [2016-05-24T17:54:01.413937 #49640]  INFO -- omniauth: (fitbit_oauth2) Callback phase initiated.
# E, [2016-05-24T17:54:01.998109 #49640] ERROR -- omniauth: (fitbit_oauth2) Authentication failure! invalid_credentials: OAuth2::Error, :
# {"errors":[{"errorType":"request","fieldName":"n/a","message":"Rate limit exceeded for this user. Please try again at the start of the hour. More information about rate limiting is at <https://dev.fitbit.com/docs>."}],"success":false}
# Processing by Users::OmniauthCallbacksController#failure as HTML
#   Parameters: {"state"=>"ed2677ee904511fb606fe8a3bcb0eea0b81571be2f185e8a", "code"=>"53fbf1c3ab9db0edea7fef723428c0d6b20f150d"}









