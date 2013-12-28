require 'sinatra/base'

require_relative 'helpers/application'
require_relative 'helpers/status_codes'
require_relative 'controllers/file_controller'

class FileStorage < Sinatra::Base
  use FileController
end