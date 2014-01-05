require 'spec_helper'

describe SystemController do
  it 'returns protocol version' do
    get '/system/version'
    expect(last_response.body).to match /^[\d\.]+$/
  end
end