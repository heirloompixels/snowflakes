require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

context "Park Model" do
  context 'can be created' do
    setup do
      Park.new
    end

    asserts("that record is not nil") { !topic.nil? }
  end
end
