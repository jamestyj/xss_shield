require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::JavaScriptHelper are properly
# escaped.
class JavascriptHelperTest < Test::Unit::TestCase

  def test_button_to_function
    assert_render(
      %(<%= button_to_function 'foo&bar', "alert('foo&bar')" %>) => %(
        <input type="button" value="foo&amp;bar" onclick="alert('foo&amp;bar');\
"#{XHTML_TAGS}>))
  end

  def test_escape_javascript
    assert_render(
      %(<%= escape_javascript "alert('foo&bar');" %>) => 
      %(alert(\\'foo&amp;bar\\');))
  end

  def test_javascript_tag
    assert_render(
      %(<%= javascript_tag "alert('foo&bar');" %>) => %(
        <script type="text/javascript">\n//<![CDATA[\nalert('foo&bar');\n//]]>\
\n</script>))
  end

  def test_link_to_function
    assert_render(
      %(<%= link_to_function 'foo&bar', "alert('foo&bar')" %>) => %(
        <a href="#" onclick="alert('foo&amp;bar'); return false;">foo&bar</a>))
  end

end
