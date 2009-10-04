require File.dirname(__FILE__) + '/../test/test_helper'

class SafeStringTest < Test::Unit::TestCase

  include ERB::Util

  def test_safe_string
    assert_equal "foo", "foo".to_xss_safe
    assert_equal "foo &amp; bar", "foo & bar".to_xss_safe
    assert_equal "foo &amp; bar", "foo & bar".to_xss_safe
    assert_equal "foo &amp;amp; bar", "foo &amp; bar".to_xss_safe
    assert_equal "foo &amp; bar", "foo & bar".to_xss_safe.to_xss_safe
    assert_equal "foo &amp; bar", h("foo & bar").to_xss_safe
    assert_equal "foo &amp;amp; bar", h(h("foo & bar"))
    
    assert_not_equal "foo".xss_safe.object_id, "foo".xss_safe.object_id
    x = "foo & bar".xss_safe
    assert_equal x.xss_safe, x
    # Not sure if this makes sense
    assert_not_equal x.xss_safe.object_id, x.object_id

    assert_equal x.to_s, x
    assert_equal x.to_s.object_id, x.object_id
  end
  
  def test_nonstring_objects
    assert_equal "15", 15.to_xss_safe
    assert_equal SafeString, 15.to_xss_safe.class
  end
  
  def test_nil
    assert_equal "", nil.to_xss_safe
    assert_equal SafeString, nil.to_xss_safe.class
    assert_equal nil, nil.xss_safe
  end
  
end
