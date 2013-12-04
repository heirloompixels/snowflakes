class Road
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :status, String
  property :requirements, String
end
