module MonospaceTagTextFormatter
  class Box < MonospaceTextFormatter::Box

    private

    def string_to_chunk(string)
      Chunk.new(string)
    end

    def new_line(string_or_chunk, attrs={})
      Line.new(string_or_chunk, attrs)
    end
  end
end
