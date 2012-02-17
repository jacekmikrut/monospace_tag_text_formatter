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

    context 'called with "&lt;/tag&gt;text"' do
      let(:string) { "&lt;/tag&gt;text" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("&lt;")) }
      describe("remaining string") { it { result; string.should == "/tag&gt;text" } }
    end

    context 'called with "/tag&gt;text"' do
      let(:string) { "/tag&gt;text" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("/tag")) }
      describe("remaining string") { it { result; string.should == "&gt;text" } }
    end

    context 'called with "&gt;text"' do
      let(:string) { "&gt;text" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("&gt;")) }
      describe("remaining string") { it { result; string.should == "text" } }
    end

    context 'called with "before&abc;after"' do
      let(:string) { "before&abc;after" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("before&abc;after")) }
      describe("remaining string") { it { result; string.should == "" } }
    end

    context 'called with "&abc;after"' do
      let(:string) { "&abc;after" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("&abc;after")) }
      describe("remaining string") { it { result; string.should == "" } }
    end

    context 'called with "&& text"' do
      let(:string) { "&& text" }
      it { result.should eq(MonospaceTagTextFormatter::AtomicChunk.new("&&")) }
      describe("remaining string") { it { result; string.should == " text" } }
    end
  end
end
