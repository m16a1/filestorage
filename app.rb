require 'sinatra/base'
require 'sinatra/config_file'

class FileStorage < Sinatra::Base
  register Sinatra::ConfigFile
  
  config_file './config.yml'
  
  before do
    # TODO: sanitize file name
    @file_name = request.path_info
    @file_path = settings.fileserver_root + @file_name
  end
  
  get '/*' do
    halt 404 unless File.exists? @file_path
    File.open(@file_path).read
  end
  
  post '/*' do
    halt 406 if File.exists? @file_path
    File.open(@file_path, 'w') {|f| f.write(request.body) }
    status 201
  end
  
  head '/*' do
    halt 404 unless File.exists? @file_path
    status 200
  end
end