class Sinatra::Base
  def file_name
    request.path_info
  end
  
  def file_path
    settings.fileserver_root + file_name
  end
end