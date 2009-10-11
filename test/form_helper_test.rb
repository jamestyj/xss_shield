require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::FormHelper are properly escaped.
class FormHelperTest < ActionView::TestCase

  def setup
    @options = { :locals => { :@foo => stub(:bar => "f&b") } }
  end

  def test_check_box
    assert_render({
      %(<%= check_box :foo, :bar %>) => %(
        <input name="foo[bar]" type="hidden" value="0" />\
<input name="foo[bar]" id="foo_bar" value="1" type="checkbox" />)
      }, @options)
  end

  def test_fields_for
    assert_render({
      %(<% fields_for @foo.bar do |fields| %>Field: <%= fields.check_box :field %><% end %>) => %(
Field: <input name="f&amp;b[field]" type="hidden" value="0" />\
<input name="f&amp;b[field]" type="checkbox" id="f_b_field" value="1" />)
      }, @options)
  end

  def test_file_field
    assert_render({
      %(<%= file_field :foo, :bar, :class => "f&b" %>) => %(
        <input name="foo[bar]" size="30" class="f&amp;b" type="file" id="foo_bar" />)
      }, @options)
  end

  def test_form_for
    assert_render({
      %(<% form_for :foo do |f| %>Bar: <%= f.text_field :bar %><% end %>) => %(
<form method=\"post\" action=\"/test/foobar\">Bar: <input name=\"foo[bar]\" size=\"30\" id=\"foo_bar\" value=\"f&amp;b\" type=\"text\" /></form>)
      }, @options)
  end

  def test_hidden_field
    assert_render({
      %(<%= hidden_field :foo, :bar %>) => %(
        <input name="foo[bar]" type="hidden" id="foo_bar" value="f&amp;b" />)
      }, @options)
  end

  def test_label
    assert_render({
      %(<%= label :foo, :bar, 'f&b' %>) => %(<label for="foo_bar">f&b</label>)
      }, @options)
  end

  def test_password_field
    assert_render({
      %(<%= password_field :foo, :bar %>) => %(
<input name="foo[bar]" size="30" type="password" id="foo_bar" value="f&amp;b" />)
      }, @options)
  end

  def test_radio_button
    assert_render({
      %(<%= radio_button :foo, :bar, 'f&b' %>) => %(
<input name="foo[bar]" checked="checked" type="radio" id="foo_bar_fb" value="f&amp;b" />)
      }, @options)
  end

  def test_text_area
    assert_render({
      %(<%= text_area :foo, :bar %>) => %(
<textarea name="foo[bar]" id="foo_bar" rows="20" cols="40">f&amp;b</textarea>)
      }, @options)
  end

  def test_text_field
    assert_render({
      %(<%= text_field :foo, :bar %>) => %(
<input name="foo[bar]" size="30" type="text" id="foo_bar" value="f&amp;b" />)
      }, @options)
  end

end
