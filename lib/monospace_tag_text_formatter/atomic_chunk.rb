module MonospaceTagTextFormatter
  class AtomicChunk < MonospaceTextFormatter::AtomicChunk

    def self.closing_tag(name)
      new("</#{name}>")
    end

    def display_string
      @display_string ||= @string.gsub(/^<\/?[^\/>][^>]*>$/, '')
    end

    def opening_tag?
      !!@string.match(/^<[^\/>][^>]*>$/)
    end

    def closing_tag?
      !!@string.match(/^<\/[^>]+>$/)
    end

    def tag_name
      m = @string.match(/^<\/?(?<name>\w+)[^>]*>$/) and m[:name].to_sym
    end
  end
end
