require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::FormTagHelper are properly
# escaped.
class FormTagHelperTest < ActionView::TestCase

  def test_check_box_tag
    assert_render(
      %(<%= check_box_tag 'foobar' %>) => %(
        <input name="foobar" type="checkbox" id="foobar" value="1"#{XHTML_TAGS}>))
  end

  def test_field_set_tag
    assert_render(
      %(<% field_set_tag 'foo&bar' do %><%= text_field_tag 'boo' %><% end %>) => %(
        <fieldset><legend>foo&bar</legend><input name="boo" type="text" id=\
"boo"#{XHTML_TAGS}></fieldset>))
  end

  def test_file_field_tag
    assert_render(
      %(<%= file_field_tag 'foo&bar' %>) => %(
        <input name="foo&amp;bar" type="file" id="foo_bar"#{XHTML_TAGS}>))
  end

  def test_form_tag
    assert_render(
      %(<% form_tag '/foobar' do %><%= submit_tag 'f&b' %><% end %>) => %(
        <form action="/foobar" method="post"><input name="commit" type="submit"\
 value="f&amp;b"#{XHTML_TAGS}></form>))
  end

  def test_hidden_field_tag
    assert_render(
      %(<%= hidden_field_tag 'foo&bar' %>) => %(
        <input name="foo&amp;bar" type="hidden" id="foo_bar"#{XHTML_TAGS}>))
  end

  def test_image_submit_tag
    assert_render(
      %(<%= image_submit_tag 'foo&bar.png' %>) => %(
        <input type="image" src="/images/foo&amp;bar.png"#{XHTML_TAGS}>))
  end

  def test_label_tag
    assert_render(
      %(<%= label_tag 'foo&bar' %>) => %(
        <label for="foo_bar">Foo&bar</label>))
  end

  def test_password_field_tag
    assert_render(
      %(<%= password_field_tag 'foo&bar' %>) => %(
        <input name="foo&amp;bar" type="password" id="foo_bar"#{XHTML_TAGS}>))
  end

  def test_radio_button_tag
    assert_render(
      %(<%= radio_button_tag 'foo&bar', 'a&b' %>) => %(
        <input name="foo&amp;bar" type="radio" id="foo&amp;bar_ab" value=\
"a&amp;b"#{XHTML_TAGS}>))
  end

  def test_select_tag
    assert_render(
      %(<%= select_tag 'foo&bar' %>) => %(
        <select name="foo&amp;bar" id="foo_bar"></select>))
  end

  def test_submit_tag
    assert_render(
      %(<%= submit_tag 'foo&bar' %>) => %(
        <input name="commit" type="submit" value="foo&amp;bar"#{XHTML_TAGS}>))
  end

  def test_text_area_tag
    assert_render(
      %(<%= text_area_tag 'foo&bar' %>) => %(
        <textarea name="foo&amp;bar" id="foo_bar"></textarea>))
  end

  def test_text_field_tag
    assert_render(
      %(<%= text_field_tag 'foo&bar' %>) => %(
        <input name="foo&amp;bar" type="text" id="foo_bar"#{XHTML_TAGS}>))
  end

end
