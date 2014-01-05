class SystemController < Sinatra::Base
  helpers ApplicationHelper, StatusCodesHelper
  PROTOCOL_VERSION = '0.1'

  get '/system/version' do
    PROTOCOL_VERSION
  end
end