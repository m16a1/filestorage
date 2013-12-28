require 'sinatra/base'
require 'sinatra/config_file'

require_relative 'monkey_patches/sinatra_base'


class FileStorage < Sinatra::Base
  register Sinatra::ConfigFileß
  
  config_file './config.yml'
  
  get '/*' do
    halt 404 unless File.exists? file_path
    File.open(file_path).read
  end
  
  post '/*' do
    halt 405 if File.exists? file_path
    File.open(file_path, 'w') {|f| f.write(request.body) }
    status 201
  end
  
  head '/*' do
    halt 404 unless File.exists? file_path
    status 200
  end
end