class DirectoryController < Sinatra::Base
  helpers ApplicationHelper, StatusCodesHelper

  get '/*/' do
    not_found unless Dir.exists? abs_path
    file_list = Dir.files(abs_path).map { |name| {name: name, type: 'file'} }
    dir_list = Dir.subdirs(abs_path).map { |name| {name: name, type: 'dir'} }
    json (file_list + dir_list)
  end

  post '/*/' do
    not_allowed if Dir.exists? abs_path
    Dir.mkdir abs_path, 0700
    created
  end

  head '/*/' do

  end
end