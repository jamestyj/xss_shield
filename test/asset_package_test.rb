require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from Synthesis::AssetPackagerHelper are properly escaped.
class AssetPackagerTest < ActionView::TestCase

  $asset_packages_yml = {
    "javascripts" => [{ "base" => [ "foobar" ] }], 
    "stylesheets" => [{ "base" => [ "foobar" ] }] 
  }
  include Synthesis::AssetPackageHelper

rescue NameError
  puts "Skipping AssetPackger plugin tests"

else

  def test_stylesheet_link_merged
    assert_render(
      %(<%= stylesheet_link_merged :base %>) => %(
        <link href="/stylesheets/foobar.css" rel="stylesheet" media="screen"\
type="text/css"#{XHTML_TAGS}>)
    )
  end

  def test_javascript_include_merged
    assert_render(
      %(<%= javascript_include_merged :base %>) => %(
        <script type="text/javascript" src="/javascripts/foobar.js"></script>)
    )
  end

end
