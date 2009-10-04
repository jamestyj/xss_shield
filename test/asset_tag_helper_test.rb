require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::AssetTagHelper are properly
# escaped.
class AssetTagHelper < Test::Unit::TestCase

  def test_auto_discovery_link_tag
    assert_render(
      %(<%= auto_discovery_link_tag "foo&bar" %>) => %(
        <link href="/test/foobar" title="FOO&amp;BAR" rel="alternate" type="\
foo&amp;bar"#{XHTML_TAGS}>))
  end

  def test_image_path
    assert_render(
      %(<%= image_path "foo&bar" %>) => %(/images/foo&amp;bar))
  end

  def test_image_tag
    assert_render(
      %(<%= image_tag "foo&bar" %>) => %(
        <img src="/images/foo&amp;bar" alt="Foo&amp;bar"#{XHTML_TAGS}>))
  end

  def test_javascript_include_tag
    assert_render(
      %(<%= javascript_include_tag "foo&bar" %>) => %(
        <script type="text/javascript" src="/javascripts/foo&amp;bar.js"></script>))
  end

  def test_javascript_path
    assert_render(
      %(<%= javascript_path "foo&bar" %>) => %(/javascripts/foo&amp;bar.js))
  end

  # Alias for image_path.
  def test_path_to_image
    assert_render(
      %(<%= path_to_image "foo&bar" %>) => %(/images/foo&amp;bar))
  end

  # Alias for javascript_path.
  def test_path_to_javascript
    assert_render(
      %(<%= path_to_javascript "foo&bar" %>) => %(/javascripts/foo&amp;bar.js))
  end

  # Alias for stylesheet_path.
  def test_path_to_stylesheet
    assert_render(
      %(<%= path_to_stylesheet "foo&bar" %>) => %(/stylesheets/foo&amp;bar.css))
  end

  def test_stylesheet_link_tag
    assert_render(
      %(<%= stylesheet_link_tag "foo&bar" %>) => %(
        <link href="/stylesheets/foo&amp;bar.css" rel="stylesheet" type=\
"text/css" media="screen"#{XHTML_TAGS}>))
  end

  def test_stylesheet_path
    assert_render(
      %(<%= stylesheet_path "foo&bar" %>) => %(/stylesheets/foo&amp;bar.css))
  end

end
