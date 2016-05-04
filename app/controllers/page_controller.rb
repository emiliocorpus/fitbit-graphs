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

  	else
  		redirect_to root_path
  	end
  end
end
