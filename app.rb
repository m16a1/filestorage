require 'sinatra/base'
require 'sinatra/config_file'

class FileStorage < Sinatra::Base
  register Sinatra::ConfigFile
  
  config_file './config.yml'
  
  before do
    @file_name = request.path_info
    @file_path = settings.fileserver_root + @file_name
  end
  
  get '/*' do
    halt 404 unless File.exists? @file_path
    File.open(@file_path).read
  end
end