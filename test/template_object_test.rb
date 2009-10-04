require File.dirname(__FILE__) + '/../test/test_helper'

# Test that ERBs still work correctly.
# See /usr/lib/ruby/gems/1.8/gems/actionpack-2.1.0/test/template/template_object_test.rb.
class TemplateObjectTest < Test::Unit::TestCase

  def setup
    @view = ActionView::Base.new(VIEW_PATH)
    @path = "hello_world.erb"
  end

  def test_should_create_valid_template
    template = ActionView::Template.new(@view, @path, true)

    assert_kind_of ActionView::TemplateHandlers::ERB, template.handler
    assert_equal "hello_world.erb", template.path
    assert_nil template.instance_variable_get(:"@source")
    assert_equal "erb", template.extension
  end

  def test_should_prepare_template_properly
    template = ActionView::Template.new(@view, @path, true)
    view = template.instance_variable_get(:"@view")

    view.expects(:evaluate_assigns)
    template.handler.expects(:compile_template).with(template)
    view.expects(:method_names).returns({})

    template.prepare!
  end

end

