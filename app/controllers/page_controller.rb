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
          month_ago = Date.today - 30
          client = current_user.fitbit_client.heartrate_time_series(start_date: month_ago, period: '30d')
        # client = current_user.fitbit_client
        # today = Date.today
        # month_ago = today - 30
        # output = client.heartrate_time_series(start_date: month_ago.strftime, period: '30d')
        # @output = output.to_json
  	else
  		redirect_to root_path
  	end
  end
end
