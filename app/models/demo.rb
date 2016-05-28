class Demo < ActiveRecord::Base
	serialize :data, JSON
end
