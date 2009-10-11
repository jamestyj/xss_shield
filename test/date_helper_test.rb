require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::DateHelper are properly
# escaped.
class DateHelperTest < ActionView::TestCase

  def test_date_select
    assert_render_has_no_escaped_chars %(<%= date_select :foo, :created_on %>)
  end

  def test_datetime_select
    assert_render_has_no_escaped_chars(
      %(<%= datetime_select :foo, :created_on %>))
  end

  def test_distance_of_time_in_words
    assert_render({
      %(<%= distance_of_time_in_words time, time+10 %>) => %(less than a minute)
    }, { :locals => { :time => Time.now } })
  end

  def test_distance_of_time_in_words_to_now
    assert_render({
      %(<%= distance_of_time_in_words 10 %>) => %(less than a minute)
    })
  end

  def test_select_date
    assert_render_has_no_escaped_chars %(<%= select_date %>)
  end

  def test_select_datetime
    assert_render_has_no_escaped_chars %(<%= select_datetime %>)
  end

  def test_select_day
    assert_render_has_no_escaped_chars %(<%= select_day 1 %>)
  end

  def test_select_hour
    assert_render_has_no_escaped_chars %(<%= select_hour 1 %>)
  end

  def test_select_minute
    assert_render_has_no_escaped_chars %(<%= select_minute 1 %>)
  end

  def test_select_month
    assert_render_has_no_escaped_chars %(<%= select_month 1 %>)
  end

  def test_select_second
    assert_render_has_no_escaped_chars %(<%= select_second 1 %>)
  end

  def test_select_time
    assert_render_has_no_escaped_chars %(<%= select_time Time.now %>)
  end

  def test_select_year
    assert_render_has_no_escaped_chars %(<%= select_year 2000 %>)
  end

  def test_time_ago_in_words
    assert_render_has_no_escaped_chars %(<%= time_ago_in_words Time.now %>)
  end

  def test_time_select
    assert_render_has_no_escaped_chars %(<%= time_select :foo, :bar %>)
  end
end
