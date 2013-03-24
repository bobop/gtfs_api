class CalendarDateSerializer < ActiveModel::Serializer
  attributes :id, :service_id, :date, :exception_type
end
