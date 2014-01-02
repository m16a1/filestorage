require 'sinatra/base'
require 'sinatra/json'

require_relative 'patches/dir'
require_relative 'helpers/application'
require_relative 'helpers/status_codes'
require_relative 'controllers/file'
require_relative 'controllers/directory'

class FileStorage < Sinatra::Base
  use DirectoryController
  use FileController
end