class Park
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :difficulty, String
  property :groomed_or_cut, String
  property :status, String
  property :featured_terrain, String
  property :night_operations, String
end
