class FitbitApiController < ApplicationController

	before_filter :authenticate_user!

	def data_request
	  client = current_user.fitbit_client
	  case params[:resource]

		when 'heart';

	  	output = client.heartrate_time_series(start_date:'2016-04-01', period: '30d')
	  end

	  render json: output
	end
end
