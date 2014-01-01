require 'rack/test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

module HTTPCodes
  NOT_FOUND = 404
  OK = 200
  CREATED = 201
  NOT_ALLOWED = 405
  INTERNAL_ERROR = 500
end

RSpec.configure { |c| c.include RSpecMixin }