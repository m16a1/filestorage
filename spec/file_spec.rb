require 'spec_helper'

describe FileStorage do
  before do
    File.stub(:exists?).with('/srv/www/absent_file.txt').and_return false
    File.stub(:exists?).with('/srv/www/existent_file.txt').and_return true
    File.stub_chain(:open, :read).and_return 'content'
  end
  
  context 'get the file' do
    it 'returns status 404 when file not found' do
      get '/absent_file.txt'
      expect(last_response.status).to eq 404
    end
    
    it 'returns status 200 when file exists' do
      get '/existent_file.txt'
      expect(last_response.status).to eq 200
    end
    
    it 'returns file contents if file exists' do
      get '/existent_file.txt'
      expect(last_response.body).to eq 'content'
    end
  end
end