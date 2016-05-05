class FitbitApiController < ApplicationController

	before_filter :authenticate_user!

	def data_request
		pry
		client = current_user.fitbit_client
		today = Date.today
		month_ago = today - 30
		output = client.heartrate_time_series(start_date: month_ago.strftime, period: '30d')
	  	@output = output

	end
end
