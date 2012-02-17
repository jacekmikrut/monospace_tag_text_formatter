module MonospaceTagTextFormatter
  class AtomicChunkFactory < MonospaceTextFormatter::AtomicChunkFactory

    REGEXP = /^(?:\n|[ \t]+|<\/?\w+[^>]+>|[^ \t\n<]+)/

    def new(string)
      AtomicChunk.new(string)
    end

    protected

    def regexp
      REGEXP
    end
  end
end
