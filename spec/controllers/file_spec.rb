require 'spec_helper'

describe FileController do
  before do
    File.stub(:exists?).with('/srv/www/absent_file.txt').and_return false
    File.stub(:exists?).with('/srv/www/existent_file.txt').and_return true

    io = double('IO')
    File.stub(:open).with('/srv/www/existent_file.txt')
      .and_return io
    io.stub(:read).and_return 'content'

    File.stub(:open).with(kind_of(String), 'wb').and_yield io
    io.stub(:write)
  end

  context 'get the file' do
    it 'returns "Not Found" error if file not found' do
      get '/absent_file.txt'
      expect(last_response.status).to eq HTTPCodes::NOT_FOUND
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
    it 'returns status code 405 if file exists' do
      post '/existent_file.txt'
      expect(last_response.status).to eq 405
    end

    it 'returns status code 500 if shit happens' do
      io = double('IO')
      File.stub(:open).with(kind_of(String), 'wb').and_yield io
      io.stub(:write).and_raise Errno::EACCES
      post '/absent_file.txt'
      expect(last_response.status).to eq 500
    end

    it 'returns status code 201 if file was successfully created' do
      post '/absent_file.txt'
      expect(last_response.status).to eq 201
    end
  end

  context 'check file existence' do
    it 'returns status code 200 if file exists' do
      head '/existent_file.txt'
      expect(last_response.status).to eq 200
    end

    it 'returns status code 404 when file not found' do
      head '/absent_file.txt'
      expect(last_response.status).to eq 404
    end
  end

  context 'update file contents' do
    it 'returns "Not Found" error if file not found' do
      put '/absent_file.txt'
      expect(last_response.status).to eq HTTPCodes::NOT_FOUND
    end
    it 'returns "OK" if file successfully updated' do
      put '/existent_file.txt'
      expect(last_response.status).to eq HTTPCodes::OK
    end
  end

  context 'remove file' do
    it 'returns "Not Found" error if file not found' do
      delete '/absent_file.txt'
      expect(last_response.status).to eq HTTPCodes::NOT_FOUND
    end
    it 'returns "No Content" if file successfully removed' do
      File.should_receive(:delete).once.with('/srv/www/existent_file.txt')
      delete '/existent_file.txt'
      expect(last_response.status).to eq HTTPCodes::NO_CONTENT
    end
  end
end