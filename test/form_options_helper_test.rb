require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::FormOptionsHelper are properly
# escaped.
class FormOptionsHelperTest < Test::Unit::TestCase

  def setup
    @options = { 
      :locals => { :@collection => [ stub(:key => 'a&b', :val => 'c&d') ] } 
    }
  end

  def test_collection_select
    assert_render({
      %(<%= collection_select :foo, :bar, @collection, :key, :val %>) => %(
        <select name="foo[bar]" id="foo_bar"><option value="a&amp;b">c&amp;d</option></select>)
      }, @options)
  end

  def test_country_options_for_select
    assert_render_has_no_escaped_chars %(<%= country_options_for_select %>")
  end

  def test_country_select
    assert_render_has_no_escaped_chars %(<%= country_select :foo, :bar %>)
  end

  def test_option_groups_from_collection_for_select
    continents = [
      stub(:id => 1, 
           :name => 'a&b',
           :countries => [ stub(:id => 1, :name => 'c&d') ])
    ]
    assert_render({
      %(<%= option_groups_from_collection_for_select @continents, :countries, :name, :id, :name %>) => %(
        <optgroup label="a&amp;b"><option value="1">c&amp;d</option></optgroup>)
      }, 
      { :locals => { :@continents => continents } })
  end

  def test_options_for_select
    assert_render(
      %(<%= options_for_select 'a&b', 'c&d' %>) => %(
        <option value="a&amp;b">a&amp;b</option>))
  end

  def test_options_from_collection_for_select
    assert_render({
      %(<%= options_from_collection_for_select @collection, :key, :val %>) => %(
        <option value="a&amp;b">c&amp;d</option>)
      }, @options)
  end

  def test_select
    assert_render({
      %(<%= select :foo, :bar, [['a&b', 'c&d']] %>) => %(
        <select name="foo[bar]" id="foo_bar"><option value="c&amp;d">a&amp;b</option></select>)
      })
  end

  def test_time_zone_options_for_select
    assert_render_has_no_escaped_chars %(<%= time_zone_options_for_select %>")
  end

  def test_time_zone_select
    assert_render_has_no_escaped_chars %(<%= time_zone_select :foo, :bar %>)
  end

end
