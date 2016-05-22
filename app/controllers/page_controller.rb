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
        
        new_data = parse_faraday(handle_graph(params['request']))
        @data_set = parse_fitbit(new_data)
  	else
  		redirect_to root_path
  	end
  end

  # FOR ERROR CHECKING MUST REFRESH TOKEN, TRY REFRESH TOKEN MESSAGE
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
      days: 30
    }
  end

  def handle_graph(param)
    case param
    when 'calories'
      data = current_user.fitbit_client.activity_time_series(resource: 'calories', start_date: Date.today, period: '30d')
    when 'heart_rate'
      data = current_user.fitbit_client.activity_time_series(resource: 'calories', start_date: Date.today, period: '30d')
    when 'steps'
      data = current_user.fitbit_client.activity_time_series(resource: 'steps', start_date: Date.today, period: '30d')
    when nil
      data = current_user.fitbit_client.activity_time_series(resource: 'calories', start_date: Date.today, period: '30d')
    end
    data
  end


  # activity_time_series(resource: nil, start_date: nil, period: '30d')

  def parse_faraday(response)
    JSON.parse(response.body)
  end


end