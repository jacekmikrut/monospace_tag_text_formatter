$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")
require "monospace_tag_text_formatter/version"

Gem::Specification.new do |s|
  s.name          = "monospace_tag_text_formatter"
  s.version       = MonospaceTagTextFormatter::VERSION
  s.author        = "Jacek Mikrut"
  s.email         = "jacekmikrut.software@gmail.com"
  s.homepage      = "http://github.com/jacekmikrut/monospace_tag_text_formatter"
  s.summary       = "Extension for monospace_text_formatter Gem that handles HTML-like tags."
  s.description   = "Extension for monospace_text_formatter Gem. Treats HTML-like tags as zero-length and ensures they are properly closed during text truncation/splitting and reopened after line wrapping."

  s.files         = Dir["lib/**/*", "README*", "LICENSE*", "Changelog*"]
  s.require_path  = "lib"

  s.add_runtime_dependency "monospace_text_formatter", "0.0.2"

  s.add_development_dependency "rspec", "~> 2.0"
end
