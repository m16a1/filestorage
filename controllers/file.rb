class FileController < Sinatra::Base
  helpers ApplicationHelper, StatusCodesHelper
  
  get '/*' do
    not_found unless File.exists? abs_path
    File.open(abs_path).read
  end
  
  post '/*' do
    not_allowed if File.exists? abs_path
    File.open(abs_path, 'w') {|f| f.write(request.body) }
    created
  end
  
  head '/*' do
    not_found unless File.exists? abs_path
  end
end