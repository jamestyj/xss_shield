class Module
  def mark_methods_as_xss_safe(*ms)
    ms.each do |m|
      begin
        instance_method("#{m}_with_xss_protection")
      rescue NameError
        define_method :"#{m}_with_xss_protection" do |*args|
          send(:"#{m}_without_xss_protection", *args).mark_as_xss_protected
        end
        alias_method_chain m, :xss_protection
      end
    end
  end
end

# Mark known helpers as xss_safe only if their arguments are guaranteed to be
# safe. Don't mark methods that take a block as xss_safe.
class ActionView::Base
  # ActionView::Helpers::AssetTagHelper
  mark_methods_as_xss_safe :auto_discovery_link_tag,
                           :javascript_include_tag,
                           :stylesheet_link_tag,
                           :image_tag

  # ActionView::Helpers::JavaScriptHelper
  mark_methods_as_xss_safe :link_to_function,
                           :button_to_function,
                           :javascript_tag

  # ActionView::Helpers::FormHelper
  mark_methods_as_xss_safe :check_box,
                           :file_field,
                           :hidden_field,
                           :label,
                           :password_field,
                           :radio_button,
                           :text_area,
                           :text_field

  # ActionView::Helpers::FormTagHelper
  mark_methods_as_xss_safe :check_box_tag,
                           :file_field_tag,
                           :form_tag_html,
                           :hidden_field_tag,
                           :image_submit_tag,
                           :label_tag,
                           :password_field_tag,
                           :radio_button_tag,
                           :select_tag,
                           :submit_tag,
                           :text_area_tag,
                           :text_field_tag

  # ActionView::Helpers::FormOptionsHelper
  mark_methods_as_xss_safe :select, 
                           :options_for_select,
                           :collection_select,
                           :country_select,
                           :time_zone_select,
                           :options_from_collection_for_select,
                           :option_groups_from_collection_for_select,
                           :country_options_for_select,
                           :time_zone_options_for_select

  # ActionView::Helpers::PrototypeHelper
  mark_methods_as_xss_safe :submit_to_remote

  # ActionView::Helpers::ActiveRecordHelper
  mark_methods_as_xss_safe :error_message_on,
                           :error_messages_for,
                           :input

  # ActionView::Helpers::DateHelper
  mark_methods_as_xss_safe :date_select,
                           :datetime_select,
                           :select_date,
                           :select_datetime,
                           :select_time,
                           :select_month,
                           :select_minute,
                           :select_hour,
                           :select_day,
                           :select_year,
                           :select_second,
                           :time_select

  # ActionView::Helpers::UrlHelper
  mark_methods_as_xss_safe :mail_to

  # General 
  mark_methods_as_xss_safe :render

  def link_to_with_xss_protection(text, *args)
    link_to_without_xss_protection(text.to_s_xss_protected, *args).mark_as_xss_protected
  end
  alias_method_chain :link_to, :xss_protection

  def button_to_with_xss_protection(text, *args)
    button_to_without_xss_protection(text.to_s_xss_protected, *args).mark_as_xss_protected
  end
  alias_method_chain :button_to, :xss_protection
end

# AssetPackager plugin.
if defined? Synthesis
  module Synthesis::AssetPackageHelper
    mark_methods_as_xss_safe :stylesheet_link_merged,
                             :javascript_include_merged
  end
end

# WillPaginate plugin.
if defined? WillPaginate
  module WillPaginate::ViewHelpers
    mark_methods_as_xss_safe :will_paginate
  end
end

