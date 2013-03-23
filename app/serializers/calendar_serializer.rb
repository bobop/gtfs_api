class CalendarSerializer < ActiveModel::Serializer
  attributes :service_id, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :start_date, :end_date
  has_many :calendar_dates
end
