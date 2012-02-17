module MonospaceTagTextFormatter
  class Line < MonospaceTextFormatter::Line

    private

    def string_to_chunk(string)
      Chunk.new(string)
    end
  end
end
