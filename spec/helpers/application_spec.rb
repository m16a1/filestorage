require 'spec_helper'

describe ApplicationHelper do
  subject do
    c = Class.new
    c.extend(ApplicationHelper)
  end
  
  context '#config' do
    it 'parses configuration file for the first time' do
      expect(subject.config).to eql OpenStruct.new fileserver_root: '/srv/www'
    end
  end
  
  it '#abs_path returns absolute file path' do
    subject.stub_chain(:config, :fileserver_root).and_return '/srv/'
    subject.stub_chain(:rel_path).and_return 'x'
    expect(subject.abs_path).to eql '/srv/x'    
  end
end