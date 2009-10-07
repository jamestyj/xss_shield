require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::UrlHelper are properly escaped.
class UrlHelperTest < ActionView::TestCase

  def test_button_to
    assert_render(
      %(<%= button_to 'foo&bar', :action => :boo %>) => %(
        <form class="button-to" action="/test/foobar" method="post"><div>\
<input type="submit" value="foo&amp;bar"#{XHTML_TAGS}></div></form>))
  end

  def test_current_page?
    assert_render(
      %(<%= current_page? :action => :foobar %>) => %(true))
  end

  def test_link_to
    assert_render(
      %(<%= link_to 'foo&bar', :action => :boo %>) => %(
        <a href="/test/foobar">foo&amp;bar</a>))
  end

  def test_link_to_if
    assert_render(
      %(<%= link_to_if true, 'foo&bar', :action => :boo %>) => %(
        <a href="/test/foobar">foo&amp;bar</a>))
  end

  def test_link_to_unless
    assert_render(
      %(<%= link_to_unless false, 'foo&bar', :action => :boo %>) => %(
        <a href="/test/foobar">foo&amp;bar</a>))
  end

  def test_link_to_unless_current
    assert_render(
      %(<%= link_to_unless_current 'foo&bar', :action => :boo %>) => %(
        foo&amp;bar))
  end

  def test_mail_to
    assert_render(
      %(<%= mail_to 'foo@bar.com' %>) => %(
        <a href="mailto:foo@bar.com">foo@bar.com</a>))
  end

  def test_url_for
    assert_render %(<%= url_for :action => :foobar %>) => %(/test/foobar)
  end

end
