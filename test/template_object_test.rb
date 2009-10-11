require File.dirname(__FILE__) + '/../test/test_helper'

# Test that ERBs still work correctly.
# See /usr/lib/ruby/gems/1.8/gems/actionpack-2.1.0/test/template/template_object_test.rb.
class TemplateObjectTest < Test::Unit::TestCase

  def setup
    @template_path = VIEW_PATH + "/hello_world.erb"
  end

  def test_create_valid_template
    template = ActionView::Template.new(@template_path, true)

    assert_equal ActionView::TemplateHandlers::XssShieldERB, template.handler
    assert_equal @template_path, template.path
    assert_nil template.instance_variable_get(:"@source")
    assert_equal "erb", template.extension
  end

end
