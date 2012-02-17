module MonospaceTagTextFormatter
  class AtomicChunkFactory < MonospaceTextFormatter::AtomicChunkFactory

    REGEXP = /^(?:\n|[ \t]+|&lt;|&gt;|<\/?\w+[^>]+>|(?:[^ \t\n<&]|&(?!lt;)(?!gt;))+)/

    def new(string)
      AtomicChunk.new(string)
    end

    protected

    def regexp
      REGEXP
    end
  end
end
