class CalendarDate < ActiveRecord::Base
  belongs_to :calendar
  attr_accessible :date, :exception_type, :service_id
end
