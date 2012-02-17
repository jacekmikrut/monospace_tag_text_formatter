require "spec_helper"

describe MonospaceTagTextFormatter::AtomicChunkFactory do

  describe "#new" do
    let(:string      ) { stub(:string      ) }
    let(:atomic_chunk) { stub(:atomic_chunk) }

    it "should return a new instance of MonospaceTagTextFormatter::AtomicChunk initialized with given string" do
      MonospaceTagTextFormatter::AtomicChunk.should_receive(:new).with(string).and_return(atomic_chunk)
      subject.new(string).should equal(atomic_chunk)
    end
  end

  describe "#slice_from!" do
    let(:result) { subject.slice_from!(string) }

    context 'called with "<tag>text</tag>"' do
      let(:string) { "<tag>text</tag>" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("<tag>")) }
      describe("remaining string") { it { result; string.should == "text</tag>" } }
    end

    context 'called with "text</tag>"' do
      let(:string) { "text</tag>" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("text")) }
      describe("remaining string") { it { result; string.should == "</tag>" } }
    end

    context 'called with "</tag>"' do
      let(:string) { "</tag>" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("</tag>")) }
      describe("remaining string") { it { result; string.should == "" } }
    end
  end
end
