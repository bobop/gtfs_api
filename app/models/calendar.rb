class Calendar < ActiveRecord::Base
  attr_accessible :end_date, :friday, :monday, :saturday, :service_id, :start_date, :sunday, :thursday, :tuesday, :wednesday
end
