require 'spec_helper'

describe Dir do
  before do
    Dir.stub(:entries).with('/dir/*/').and_return %w(1 2 3)
  end
  
  it '#subdirs returns all sudbirectories' do
    expect(Dir.subdirs('/dir')).to eql %w(1 2 3)
  end
  
  it '#files returns file list' do
    Dir.stub(:entries).with('/dir/*').and_return %w(1 2 3 a b c)
    expect(Dir.files('/dir')).to eql %w(a b c)
  end
end