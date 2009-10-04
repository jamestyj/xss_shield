require File.dirname(__FILE__) + '/../test/test_helper'

# Test that helpers from ActionView::Helpers::PrototypeHelper are escaped
# correctly.
class PrototypeHelperTest < Test::Unit::TestCase

  def test_evaluate_remote_response
    assert_render(
      %(<%= evaluate_remote_response %>) => %(eval(request.responseText)))
  end

  # Alias for remote_form_for.
  def test_form_remote_for
    assert_render_has_no_escaped_chars(
      %(<% form_remote_for :post do |f| %><% end %>))
  end

  def test_form_remote_tag
    assert_render_has_no_escaped_chars(%(<% form_remote_tag do %><% end %>))
  end

  def test_link_to_remote
    assert_render_has_no_escaped_chars(
      %(<%= link_to_remote 'foo&bar', :update => "alert('foo&bar')" %>))
  end

  def test_observe_field
    assert_render_has_no_escaped_chars(%(<%= observe_field 'foo&bar' %>))
  end

  def test_observe_form
    assert_render_has_no_escaped_chars %(<%= observe_form 'foo&bar' %>)
  end
  def test_periodically_call_remote
    assert_render(
      %(<%= periodically_call_remote %>) => %(
        <script type="text/javascript">\n//<![CDATA[\nfunc_poller = \
$.timer(10000, function() {var currentElement=this; Q.add({complete:\
function(msg){fill_or_exec(msg,'replace','nothing');},});});\n//]]>\n</script>))
  end

  def test_remote_form_for
    assert_render_has_no_escaped_chars(
      %(<% remote_form_for :post do |f| %><% end %>))
  end

  def test_remote_function
    assert_render_has_no_escaped_chars(
      %(<% remote_form_for :post do |f| %><% end %>))
  end

  def test_submit_to_remote
    assert_render(
      %(<%= submit_to_remote 'foo&bar', 'f&b' %>) => %(
        <input name="foo&amp;bar" type="button" value="f&amp;b" onclick="var \
currentElement=this; Q.add({data: Form.serialize(this.form),complete:\
function(msg){fill_or_exec(msg,'replace','nothing');},});; return false;"#{XHTML_TAGS}>))
  end

end
