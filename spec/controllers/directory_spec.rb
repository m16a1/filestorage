require 'spec_helper'

describe DirectoryController do
  context 'get the directory' do
    before do
      Dir.stub(:exists?).with('/srv/www/absent_dir/').and_return false
      Dir.stub(:exists?).with('/srv/www/existent_dir/').and_return true
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
end