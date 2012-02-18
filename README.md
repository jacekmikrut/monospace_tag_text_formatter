MonospaceTagTextFormatter
=========================

MonospaceTagTextFormatter is a Ruby Gem that is an **extension to [MonospaceTextFormatter](http://github.com/jacekmikrut/monospace_text_formatter)** Ruby Gem.

Features
--------

* It **treats HTML-like tags as zero-length**, according to an assumption that these tags are going to be eventually removed or replaced before the text is displayed (for instance, they may be converted into color ANSI escape sequences by [AnsiChameleon](http://github.com/jacekmikrut/ansi_chameleon) Ruby Gem).

Thanks to that, for example, the following text will not be truncated:

```ruby
  MonospaceTagTextFormatter::Line.new("<tag>Some text.</tag>", :width => 10).to_s
   => "<tag>Some text.</tag>"
```

* It **treats "&amp;lt;" and "&amp;gt;" character entities as having the length equal to 1 character**, according to an assumption that these entities were used to escape HTML-like tags and are going to be replaced with "&lt;" and "&gt;" signs.

For instance, the following text will not be truncated:

```ruby
  MonospaceTagTextFormatter::Line.new("&lt;div&gt;Some text.&lt;/div&gt;", :width => 21).to_s
   => "&lt;div&gt;Some text.&lt;/div&gt;"
```

* It **ensures that HTML-like tags are properly closed when a text is truncated**.

An example:

```ruby
  MonospaceTagTextFormatter::Line.new("<tag>This is some text.</tag>", :width => 8).to_s
   => "<tag>This</tag> ..."
```

* When a text is wrapped, it **closes opened tags at the end of each line, and reopens them at the beginning of the next line**, according to an assumption that these tags correspond to some text formatting. Thanks to that feature, formatting of each line is preserved.

```ruby
  MonospaceTagTextFormatter::Box.new("<tag>This is a bit longer text.</tag>", :width => 8).lines
   => ["<tag>This is</tag> ",
       "<tag>a bit</tag>   ",
       "<tag>longer</tag>  ",
       "<tag>text.</tag>   "]
```

Installation
------------

As a Ruby Gem, MonospaceTagTextFormatter can be installed either by running

```bash
  gem install monospace_tag_text_formatter
```

or adding

```ruby
  gem "monospace_tag_text_formatter"
```

to the Gemfile and then invoking `bundle install`.

License
-------

License is included in the LICENSE file.
