class Trail
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :status, String
  property :groomed, String
  property :snow_making, String
  property :featured_terrain, String
  property :night_operation, String
  property :difficulty, String
  property :type, String
end
