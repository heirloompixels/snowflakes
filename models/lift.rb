class Lift
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :persons, String
  property :type, String
  property :status, String
  property :night_status, String
end
