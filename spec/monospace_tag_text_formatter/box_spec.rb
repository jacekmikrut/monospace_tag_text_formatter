require "spec_helper"

describe MonospaceTagTextFormatter::Box do

  subject { described_class.new("This is some text.") }

  describe "@original_chunk" do
    it { subject.instance_variable_get("@original_chunk").should be_a(MonospaceTagTextFormatter::Chunk) }
  end

  describe "@omission" do
    it { subject.instance_variable_get("@omission").should be_a(MonospaceTagTextFormatter::Chunk) }
  end
end
