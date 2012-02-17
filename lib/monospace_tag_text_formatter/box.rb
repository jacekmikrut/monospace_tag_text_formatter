module MonospaceTagTextFormatter
  class Box < MonospaceTextFormatter::Box

    private

    def string_to_chunk(string)
      Chunk.new(string)
    end
  end
end
