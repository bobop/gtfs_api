desc "Imports GTFS to DB"
task :import_gtfs => :environment do
  puts "About to Import GTFS zip"
  # source = GTFS::Source.build('http://store.datagm.org.uk/sets/tfgm/tfgmgtfs.zip')
  # source = GTFS::Source.build('http://gtfsapi.herokuapp.com/gtfs.zip')
  source_url = 'http://store.datagm.org.uk/sets/tfgm/tfgmgtfs.zip'
  @tmp_dir = Dir.mktmpdir
  # ObjectSpace.define_finalizer(self, self.class.finalize(@tmp_dir))

  Dir.mktmpdir do |tmp|
    file_name = File.join(tmp, "/gtfs_temp_#{Time.now}.zip")
    uri = URI.parse(source_url)
    response = Net::HTTP.get_response(uri)
    open(file_name, 'wb') do |file|
      file.write response.body
    end
    puts "Imported GTFS zip"
    # extract_to_cache(file_name)
    Zip::ZipFile.open(file_name) do |zip|
      # puts zip.entries.inspect
      zip.entries.each do |entry|
        filename = entry.name.split('/')[-1]
        zip.extract(entry.name, File.join(@tmp_dir, '/', filename))
      end
    end

    puts "IMPORTING AGENCIES"
    CSV.parse(open(File.join(@tmp_dir, '/', 'agency.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      Agency.create!(agency_id: row[0], agency_lang: row[4], agency_name: row[1], agency_timezone: row[3], agency_url: row[2])
    end

    puts "IMPORTING CALENDARS"
    CSV.parse(open(File.join(@tmp_dir, '/', 'calendar.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      Calendar.create!(service_id: row[0],monday: row[1],tuesday: row[2],wednesday: row[3],thursday: row[4],friday: row[5],saturday: row[6],sunday: row[7],start_date: Date.parse(row[8]),end_date: Date.parse(row[9]))
    end

    puts "IMPORTING CALENDAR DATES"
    CSV.parse(open(File.join(@tmp_dir, '/', 'calendar_dates.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      # calendar = Calendar.where(service_id: row[0]).first
      cd = CalendarDate.new(service_id: row[0],date: Date.parse(row[1]),exception_type: row[2])
      cd.calendar = Calendar.where(service_id: row[0]).first
      cd.save!
    end

    puts "IMPORTING STOPS"
    CSV.parse(open(File.join(@tmp_dir, '/', 'stops.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      Stop.create!(stop_id: row[0],stop_code: row[1],stop_name: row[2],stop_lat: row[3],stop_lon: row[4],stop_url: row[5])
    end

    puts "IMPORTING ROUTES"
    CSV.parse(open(File.join(@tmp_dir, '/', 'routes.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      r = Route.new(route_id: row[0],route_short_name: row[2],route_long_name: row[3],route_type: row[4])
      r.agency = Agency.where(agency_id: row[1]).first
      r.save!
    end

    puts "IMPORTING TRIPS"
    CSV.parse(open(File.join(@tmp_dir, '/', 'trips.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      t = Trip.new(route_str: row[0],service_id: row[1],trip_id: row[2],trip_headsign: row[3])
      t.route = Route.where(route_id: row[0]).first
      t.calendar = Calendar.where(service_id: row[1]).first
      t.save!
    end

    puts "IMPORTING STOP TIMES"
    CSV.parse(open(File.join(@tmp_dir, '/', 'stop_times.txt'), 'r:bom|utf-8'), :headers => true) do |row|
      t = StopTime.new(trip_str: row[0],arrival_time: row[1],departure_time: row[2],stop_str: row[3],stop_sequence: row[4],pickup_type: row[5],drop_off_type: row[6])
      t.trip = Trip.where(trip_id: row[0]).first
      t.stop = Stop.where(stop_id: row[3]).first
      t.save!
    end
  end
  
  puts "Finished Import of GTFS data!"
end