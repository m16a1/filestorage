require 'spec_helper'

describe FileStorage do
  before do
    File.stub(:exists?).with('/srv/www/absent_file.txt').and_return false
    File.stub(:exists?).with('/srv/www/existent_file.txt').and_return true
    File.stub_chain(:open, :read).and_return 'content'
    io = double('IO')
    File.stub(:open).with(kind_of(String), 'w').and_yield io
    io.stub(:write)
  end
  
  context 'get the file' do
    it 'returns status code 404 when file not found' do
      get '/absent_file.txt'
      expect(last_response.status).to eq 404
    end
    
    it 'returns status code 200 when file exists' do
      get '/existent_file.txt'
      expect(last_response.status).to eq 200
    end
    
    it 'returns file contents if file exists' do
      get '/existent_file.txt'
      expect(last_response.body).to eq 'content'
    end
  end
  
  context 'create new file' do
    it 'returns status code 406 if file exists' do
      post '/existent_file.txt'
      expect(last_response.status).to eq 406
    end
    
    it 'returns status code 500 if shit happens' do
      io = double('IO')
      File.stub(:open).with(kind_of(String), 'w').and_yield io
      io.stub(:write).and_raise Errno::EACCES
      post '/absent_file.txt'
      expect(last_response.status).to eq 500
    end
    
    it 'returns status code 201 if file was successfully created' do
      post '/absent_file.txt'
      expect(last_response.status).to eq 201
    end
  end
end