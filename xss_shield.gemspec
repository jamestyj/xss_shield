# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xss_shield}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Tan"]
  s.date = %q{2009-10-07}
  s.description = %q{This Rails plugin provides automatic cross site scripting (XSS) protection for your views. Once installed, you no longer have to manually and painstakingly sanitize all your views with HTML escaping.}
  s.email = %q{jamestyj@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/xss_shield.rb",
     "lib/xss_shield/erb_hacks.rb",
     "lib/xss_shield/safe_string.rb",
     "lib/xss_shield/secure_helpers.rb",
     "test/active_record_helper_test.rb",
     "test/asset_package_test.rb",
     "test/asset_tag_helper_test.rb",
     "test/date_helper_test.rb",
     "test/erb_util_test.rb",
     "test/fixtures/hello_world.erb",
     "test/form_helper_test.rb",
     "test/form_options_helper_test.rb",
     "test/form_tag_helper_test.rb",
     "test/javascript_helper_test.rb",
     "test/prototype_helper_test.rb",
     "test/safe_string_test.rb",
     "test/template_object_test.rb",
     "test/test_helper.rb",
     "test/url_helper_test.rb",
     "xss_shield.gemspec"
  ]
  s.homepage = %q{http://github.com/jamestyj/xss_shield}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Protect your Rails site from XSS attacks.}
  s.test_files = [
    "test/asset_tag_helper_test.rb",
     "test/asset_package_test.rb",
     "test/prototype_helper_test.rb",
     "test/erb_util_test.rb",
     "test/date_helper_test.rb",
     "test/template_object_test.rb",
     "test/form_options_helper_test.rb",
     "test/url_helper_test.rb",
     "test/test_helper.rb",
     "test/active_record_helper_test.rb",
     "test/javascript_helper_test.rb",
     "test/safe_string_test.rb",
     "test/form_helper_test.rb",
     "test/form_tag_helper_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end