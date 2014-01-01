require 'spec_helper'

describe StatusCodesHelper do
  subject do
    c = Class.new
    c.extend(StatusCodesHelper)
  end

  it '#not_allowed calls the error method with code 405 and response body' do
    subject.should_receive(:error).once.with 405, 'body'
    subject.not_allowed 'body'
  end
  
  it '#created returns status code 201' do
    subject.should_receive(:status).once.with 201
    subject.created
  end
  
  it '#ok returns status code 200' do
    subject.should_receive(:status).once.with 200
    subject.ok
  end
end