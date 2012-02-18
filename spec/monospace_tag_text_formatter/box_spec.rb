require "spec_helper"

describe MonospaceTagTextFormatter::Box do

  subject { described_class.new("This is some text.") }

  describe "@original_chunk" do
    it { subject.instance_variable_get("@original_chunk").should be_a(MonospaceTagTextFormatter::Chunk) }
  end

  describe "@omission" do
    it { subject.instance_variable_get("@omission").should be_a(MonospaceTagTextFormatter::Chunk) }
  end

  describe "@empty_top_lines" do
    context "when :valign is :middle" do
      before { subject.attributes(:height => 3, :valign => :middle) }
      it { subject.send(:empty_top_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end

    context "when :valign is :bottom" do
      before { subject.attributes(:height => 2, :valign => :bottom) }
      it { subject.send(:empty_top_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end
  end

  describe "@content_lines" do
    context 'when the text is ""' do
      subject { described_class.new("") }
      it { subject.send(:content_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end

    context 'when the text is "This is some text."' do
      subject { described_class.new("This is some text.") }
      it { subject.send(:content_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end
  end

  describe "@empty_bottom_lines" do
    context "when :valign is :top" do
      before { subject.attributes(:height => 2, :valign => :top) }
      it { subject.send(:empty_bottom_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end

    context "when :valign is :middle" do
      before { subject.attributes(:height => 3, :valign => :middle) }
      it { subject.send(:empty_bottom_lines).first.should be_a(MonospaceTagTextFormatter::Line) }
    end
  end
end
