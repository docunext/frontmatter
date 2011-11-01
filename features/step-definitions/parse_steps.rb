begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'cucumber/formatter/unicode'
$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'frontmatter'

Before do
end

After do
end

Given /^([A-Z0-9a-z\._\/\-\ ]+) as a path to a file ([not])?\ ?containing frontmatter$/ do |path, check|
  @doc = path
  @not  = check
end

Given /^I have a document containing frontmatter$/ do
@doc = <<-eos
---
title: Test
date: 2011-01-01
layout: default
---
Bla blah
eos
end

When /^I call ([A-Z0-9a-z_\?]+)$/ do |method|
  @front_matter_content = FrontMatter.send(method.to_sym, @doc)
end

Then /^I should receive\ ?a? ([A-Za-z]+)$/ do |object|
  if ['true', 'false'].include? object
    @front_matter_content.to_s.should == object
  else
    @front_matter_content.class.name.should == object
  end
end

Then /^the hash should have a :([a-z]+) key$/ do |key|
  @front_matter_content.has_key?(key.to_sym).should == true
end
