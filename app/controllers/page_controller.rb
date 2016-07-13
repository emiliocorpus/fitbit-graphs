class PageController < ApplicationController

  def home
  	if current_user
  		redirect_to action: 'user', id: current_user.id
  	end
  end

  def sign_out 
    sign_out current_user
    redirect_to root_path
  end

  def user
  	if current_user && current_user.id === params[:id].to_i
      # requested_data = parse_faraday(handle_graph(params['request']))
      requested_data = handle_graph(params['request']) 
      if requested_data.has_key? 'errors' || requested_data == nil
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

  def demo
    demo = Demo.first
    case params['request']
    when 'calories'
      @data = {:selected => 'calories',
              :values => demo.data['calories']}
    when 'steps'
      @data = {:selected => 'steps',
              :values => demo.data['steps']}
    when 'badges'
      @data = {:selected => 'badges',
              :badges => demo.data['badges']}
    else
      @data = {:selected => 'calories',
              :values => demo.data['calories']}
    end
    @data
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
    # parse_faraday(current_user.fitbit_client.user_info)
    current_user.fitbit_client.user_info
  end

  # currently not needed for production
  def parse_faraday(response)
    JSON.parse(response)
  end
end