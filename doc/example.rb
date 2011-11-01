require 'psych'
require_relative '../lib/frontmatter'
include FrontMatter
doc = <<-eos
---
title: Test
date: 2011-01-01
layout: default
---
Bla blah
eos


parse(doc)
