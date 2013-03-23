class AgencySerializer < ActiveModel::Serializer
  attributes :agency_id, :agency_name, :agency_url, :agency_timezone, :agency_lang
end
