require 'spec_helper'

describe DirectoryController do
  before do
    Dir.stub(:exists?).with('/srv/www/absent_dir/').and_return false
    Dir.stub(:exists?).with('/srv/www/existent_dir/').and_return true
  end
  
  context 'get the directory listing' do
    before do
      Dir.stub(:files).and_return %w(Readme.md)
      Dir.stub(:subdirs).and_return %w(lib)
    end

    it 'returns "Not Found" error if directory not found' do
      get '/absent_dir/'
      expect(last_response.status).to eq HTTPCodes::NOT_FOUND
    end

    it 'returns status "OK" if directory exists' do
      get '/existent_dir/'
      expect(last_response.status).to eq HTTPCodes::OK
    end

    it 'returns directory listing' do
      get '/existent_dir/'
      expect(last_response.body).to eq [
        {name: "Readme.md", type: "file"},
        {name: "lib", type: "dir"}
      ].to_json
    end
  end

  context 'create directory' do
    it 'returns "Method Not Allowed" if directory exists' do
      post '/existent_dir/'
      expect(last_response.status).to eq HTTPCodes::NOT_ALLOWED
    end

    it 'returns status "Created" if directory successfully created' do
      Dir.should_receive(:mkdir).once.with('/srv/www/absent_dir/', 0700)
      post '/absent_dir/'
      expect(last_response.status).to eq HTTPCodes::CREATED
    end
  end

  context 'check directory existence' do
    it 'returns "Not Found" if directory was not found' do
      head '/absent_dir/'
      expect(last_response.status).to eq 404
    end
    it 'returns status "OK" if directory exists' do
      head '/existent_dir/'
      expect(last_response.status).to eq 200
    end
  end
end