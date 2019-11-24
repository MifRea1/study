require './test/test_helper'
require 'test/unit'
require 'rack/test'
require_relative './inatra'
require_relative './my_app'

class RackTest < Test::Unit::TestCase
  def test_it_says_hello_world
    browser = Rack::Test::Session.new(Rack::MockSession.new(Inatra))
    browser.get '/hello'
    assert browser.last_response.ok?
    assert_equal 'Hello World', browser.last_response.body
  end

  def test_status_404_if_route_not_exists
    browser = Rack::Test::Session.new(Rack::MockSession.new(Inatra))
    browser.get '/nothing/to/see/here'
    assert_equal 404, browser.last_response.status
  end

  def test_status_405_if_method_is_not_allowed
    browser = Rack::Test::Session.new(Rack::MockSession.new(Inatra))
    browser.post '/hello'
    assert_equal 405, browser.last_response.status
  end
end
