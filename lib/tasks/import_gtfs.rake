desc "Imports GTFS to DB"
task :import_gtfs do
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
        CSV.parse(open(File.join(@tmp_dir, '/', filename), 'r:bom|utf-8'), :headers => true) do |row|
          puts row
        end
      end
    end
  end
  
  # source.routes.each do |r|
  #   puts r
  # end
end