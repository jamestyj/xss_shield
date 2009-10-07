require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ERB::Util are properly escaped.
class ErbUtilTest< ActionView::TestCase

  # h is an alias for html_escape.
  def test_html_escape
    assert_render({
      # Test that we automatically escape
      %(<%= "Foo & Bar" %>)     => %(Foo &amp; Bar),
      %(<%= "Foo &amp; Bar" %>) => %(Foo &amp;amp; Bar),

      # Test that we don't escape twice with h
      %(<%= h "Foo & Bar" %>)     => %(Foo &amp; Bar),
      %(<%= h "Foo &amp; Bar" %>) => %(Foo &amp;amp; Bar),

      # Test that xss_safe works
      %(<%= "Foo & Bar".xss_safe %>)     => %(Foo & Bar),
      %(<%= "Foo &amp; Bar".xss_safe %>) => %(Foo &amp; Bar),
    })
  end

  # j is an alias for json_escape.
  def test_json_escape
    assert_render(
      %(<%= j "is a > 0 & a < 10?" %>) => 
      %(is a \\u003E 0 \\u0026 a \\u003C 10?))
  end
    
end
