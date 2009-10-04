require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::ActiveRecordHelper are properly
# escaped.
class ActiveRecordHelper < Test::Unit::TestCase

  def setup
    @errors = mock()
    foobar = mock()
    foobar.stubs(:collect).returns(['foo&name'])
    Object.stubs(:content_columns).returns(foobar)
    @foo = Object.new 
    @foo.stubs(:errors).returns(@errors)
    @options = { :locals => { :@foo => @foo } }
  end

  def test_error_message_on
    @errors.stubs(:on).with(:bar).returns('foo&bar')
    assert_render({
      %(<%= error_message_on :foo, :bar %>) => %(
        <div class="formError">foo&bar</div>)
    }, @options)
  end

  def test_error_messages_for
    @errors.stubs(:count).returns(1)
    @errors.stubs(:full_messages).returns('foo&bar')
    assert_render({
      %(<%= error_messages_for :foo %>) => %(
        <div class="errorExplanation" id="errorExplanation"><h2>1 error \
prohibited this foo from being saved</h2><p>There were problems with the \
following fields:</p><ul><li>foo&bar</li></ul></div>)
    }, @options)
  end

  def test_form
    @foo.stubs(:new_record?).returns(true)
    assert_render({
      %(<%= form :foo %>) => %(
        <form action="/test/foobar" method="post">foo&name<input name="commit" \
type="submit" value="Create"#{XHTML_TAGS}></form>)
    }, @options)
  end

  def test_input
    @foo.stubs(:column_for_attribute).returns(stub(:type => :string))
    @foo.stubs(:bar).returns('foo&bar&val')
    assert_render({
      %(<%= input :foo, :bar %>) => %(
        <input name="foo[bar]" size="30" type="text" id="foo_bar" value="\
foo&amp;bar&amp;val" />)
    }, @options)
  end

end
