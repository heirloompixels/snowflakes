module Snowflake
  class App < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #

 get "/" do
  erb :report
 end

 get '/mtn.xml' do
   content_type 'text/xml', :charset => 'utf-8'
   @report = Report.last
   @trails = Trail.all
   @lifts = Lift.all
   @parks = Park.all
   @roads = Road.all
    builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.target! << "<!DOCTYPE MTN.XML PUBLIC 'MTN.XML 1.0' 'http://mtnxml.org/dtd/mtnxml-1.0.dtd'>\n"
      xml.report(:name => "Showdown Ski Area", :updated => @report.updated_at.strftime("%Y-%m-%d %H:%M:%S"),:units => "imperial") do
      xml.operations(:resortStatus=>@report.resort_status, :openTime=> @report.open_time, :closeTime=> @report.close_time,  :nightOpenTime =>@report.night_open_time, :nightCloseTime => @report.night_close_time, :totalAcres=>'640')
        xml.currentConditions do
          xml.resortWide(:totalAcresOpen => "640")
            xml.resortLocations do
              xml.location(:name => "Summit", :primarySurface => @report.primary_surface, :secondarySurface => @report.secondary_surface, :base => @report.base, :baseRange => @report.base_range, :stormTotal => @report.storm_total, :snowOverNight => @report.snow_over_night, :snow12Hours => @report.snow_12_hours, :snow24Hours => @report.snow_24_hours, :snow48Hours => @report.snow_48_hours, :snow72Hours => @report.snow_72_hours, :snow4Days => @report.snow_4_days, :snow5Days => @report.snow_5_days, :snow7Days => @report.snow_7_days, :snowSeasonTotal => @report.snow_season_total, :weatherConditions => @report.weather_conditions, :temperature => @report.temperature, :visibility => @report.visibility, :windDirection => @report.wind_direction, :windSpeed => @report.wind_speed)
            end
          xml.roads do
            @roads.each do |road|
              xml.road(:name=>road.name, :status=> road.status, :requirements=>road.requirements)
            end
          end
        end
        xml.forecast do
          xml.day(@report.weather_sunday, :name=>"Sunday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_monday, :name=>"Monday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_tuesday, :name=>"Tuesday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_wednesday, :name=>"Wednesday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_thursday, :name=>"Thursday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_friday, :name=>"Friday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
          xml.day(@report.weather_saturday, :name=>"Saturday", :high=>"", :low=>"", :snowFall=>"", :weather=>"")
        end
        xml.comments do
          xml.comment @report.forecast, :name => "forecast"
          xml.comment @report.trails_open, :name => "trailsOpen"
          xml.comment @report.lifts_open, :name => "liftsOpen"
          xml.comment @report.news, :name => "Special Events"
          xml.comment @report.notes, :name => "Comments"
          xml.comment @report.lodge_depth, :name => "lodgeDepth"
          xml.comment @report.summit_depth, :name => "summitDepth"
          xml.comment @report.days_hours_operation, :name => "daysAndHours"
          xml.comment @report.snow_sunday, :name => "snowSunday"
        end
        xml.facilities do
          xml.areas do
            xml.area(:name => "Showdown Ski Area") do
              xml.lifts do
                @lifts.each do |lift|
                  xml.lift(:name=>lift.name, :persons=>lift.persons, :type=>lift.type, :status=>lift.status, :nightStatus=>lift.night_status)
                end
              end
              xml.trails do
                @trails.each do |trail|
                  xml.trail(:name => trail.name, :difficulty => trail.difficulty, :status => trail.status, :groomed => trail.groomed, :snowMaking => trail.snow_making, :featuredTerrain => trail.featured_terrain, :nightOperation => trail.night_operation)
                end
              end
              xml.freestyleTerrain do
                xml.parks do
                  @parks.each do |park|
                    xml.park(:name => park.name, :difficulty => park.difficulty, :groomedOrCut=>park.groomed_or_cut, :featuredTerrain => park.featured_terrain, :nightOperation => park.night_operations)
                  end
                end
                xml.pipes do
                  #pipes placeholder
                end
              end
              xml.specialTerrain do
                #specialTerrain placeholder
              end
            end
          end
        end
      end
    end
  end




  end
end
