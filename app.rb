require 'sinatra/base'
require 'sinatra/json'

require_relative 'patches/dir'
require_relative 'helpers/application'
require_relative 'helpers/status_codes'
require_relative 'controllers/file'
require_relative 'controllers/directory'
require_relative 'controllers/system'

class FileStorage < Sinatra::Base
  use SystemController
  use DirectoryController
  use FileController
end