# Loads the test environment. First try to load the Rails environment if we're
# in a Rails project. Otherwise just load the libraries that we need.
begin
  test_helper = File.expand_path "#{File.dirname(__FILE__)}/../../../../test/test_helper"
  puts "Loading #{test_helper}.rb ..."
  require test_helper 
rescue LoadError
  puts "No Rails environment found"
  require 'rubygems'
  gem 'activerecord'
  gem 'actionpack'
  require 'active_record'
  require 'action_controller'
  require 'mocha'
end

# Disable deprecation warnings.
ActiveSupport::Deprecation.silenced = true

# Rails creates all HTML form elements as XHTML by default. We override this in
# Studio, so make sure the tests here handle that.
XHTML_TAGS = ''     # set this to ' /' if  you don't override this in your app

class ActionView::Base
  # Include our javascript helpers.
  include JqueryHelper

  # Disable forgery protection.
  def protect_against_forgery?
    false
  end
end

# Define helper methods here for use in the rest of the test classes.
class Test::Unit::TestCase

  VIEW_PATH = File.join(File.dirname(__FILE__), 'fixtures')
  ActionView::TemplateFinder.process_view_paths(VIEW_PATH)

  private

  def assert_render_has_no_escaped_chars(input, options = {})
    actual = render_erb(input, options[:locals])
    assert !actual.include?('&lt;'), "Output contains &lt;"
    assert !actual.include?('&gt;'), "Output contains &gt;"
  end

  def assert_render(args, options = {})
    args.each do |erb, expected|
      expected.strip!
      actual = render_erb(erb, options[:locals])
      assert_dom_equal expected, actual, "#{erb} => #{expected}"
    end
  end

  def render_erb(erb, locals = {})
    # Need this to make asset packager happy.
    request = mock()
    request.stubs(:relative_url_root).returns('')
    request.stubs(:request_uri).returns('/test/foobar')
    request.stubs(:url_for).returns('/test/foobar')
    request.stubs(:protocol).returns('http://')
    request.stubs(:ssl?).returns(false)
    controller = mock()
    controller.stubs(:request).returns(request)
    controller.stubs(:url_for).returns('/test/foobar')

    view = ActionView::Base.new(VIEW_PATH, {}, controller)
    ActionView::InlineTemplate.new(view, erb, locals).render.strip
  end

end
