class FitbitApiController < ApplicationController

	before_filter :authenticate_user!

	def data_request
	  client = current_user.fitbit_client
	  case params[:resource]

		when 'heart';
		today = Date.today
		month_ago = today - 30

	  	output = client.heartrate_time_series(start_date: month_ago.strftime, period: '30d')
	  end

	  render json: output
	end
end
