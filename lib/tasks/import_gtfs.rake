desc "Imports GTFS to DB"
task :import_gtfs do
  puts "About to Import GTFS zip"
  # source = GTFS::Source.build('http://store.datagm.org.uk/sets/tfgm/tfgmgtfs.zip')
  source = GTFS::Source.build('http://gtfsapi.herokuapp.com/gtfs.zip')
  puts "Imported GTFS zip"
  source.routes.each do |r|
    puts r
  end
end