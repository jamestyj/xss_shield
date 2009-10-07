# Loads the test environment. First try to load the Rails environment if we're
# in a Rails project. Otherwise just load the libraries that we need.
CUR_DIR = File.dirname(__FILE__)
$LOAD_PATH << "#{CUR_DIR}/../lib"
begin
  require File.expand_path "#{CUR_DIR}/../../../../test/test_helper"
rescue LoadError
  require 'rubygems'
  gem 'rails', '=2.3.4'
  require 'active_record'
  require 'action_controller'
  require 'action_controller/test_process'
  require 'action_view/test_case'
  require 'mocha'
  require 'test/unit'
end
require 'init'

# Disable deprecation warnings.
ActiveSupport::Deprecation.silenced = true

# Rails creates all HTML form elements as XHTML by default. We override this in
# Studio, so make sure the tests here handle that.
XHTML_TAGS = ' /'     # set this to ' /' if  you don't override this in your app

class ActionView::Base
  # Disable forgery protection.
  def protect_against_forgery?
    false
  end
end

# Define helper methods here for use in the rest of the test classes.
class Test::Unit::TestCase

  VIEW_PATH = File.join(File.dirname(__FILE__), 'fixtures')
  ActionController::Base.prepend_view_path(VIEW_PATH)

  private

  def assert_render_has_no_escaped_chars(input, options = {})
    actual = render_erb(input, options[:locals])
    assert !actual.include?('&lt;'), "Output contains &lt;"
    assert !actual.include?('&gt;'), "Output contains &gt;"
  end

  def assert_render(args, options = {})
    args.each do |erb, expected|
      expected.strip!
      begin
        actual = render_erb(erb, options[:locals])
      rescue Exception => ex
        puts "ERB: #{erb} => Expected: #{expected}"
        puts ex.message
        puts ex.backtrace
      end
      assert_dom_equal actual, expected, "ERB: #{erb}"
    end
  end

  def render_erb(erb, variables)
    variables ||= {}

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

    template = ActionView::InlineTemplate.new(erb)
    template.stubs(:relative_path).returns('/')

    # Set instance variables
    locals = variables.dup
    variables.each do |key, value|
      if key.to_s.start_with?('@')
        view.instance_variable_set(key, value)
        locals.delete(key)
      end
    end

    template.render(view, locals).strip
  end

end
