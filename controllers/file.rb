class FileController < Sinatra::Base
  helpers ApplicationHelper, StatusCodesHelper

  get '/*' do
    not_found unless File.exists? abs_path
    File.open(abs_path).read
  end

  post '/*' do
    not_allowed if File.exists? abs_path
    File.open(abs_path, 'wb') {|f| f.write(request.body) }
    created
  end

  head '/*' do
    not_found unless File.exists? abs_path
  end

  put '/*' do
    not_found unless File.exists? abs_path
    File.open(abs_path, 'wb') {|f| f.write(request.body) }
  end

  delete '/*' do
    not_found unless File.exists? abs_path
    File.delete abs_path
    no_content
  end
end