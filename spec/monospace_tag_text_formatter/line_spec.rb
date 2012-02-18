require "spec_helper"

describe MonospaceTagTextFormatter::Line do

  subject { described_class.new("This is some text.") }

  describe "@original_chunk" do
    it { subject.instance_variable_get("@original_chunk").should be_a(MonospaceTagTextFormatter::Chunk) }
  end

  describe "@omission" do
    it { subject.instance_variable_get("@omission").should be_a(MonospaceTagTextFormatter::Chunk) }
  end

  describe "#width=" do

    subject { MonospaceTagTextFormatter::Line.new("<tag>This is some text.</tag>") }

    it "should update the width" do

      subject.width = 20
      subject.width.should == 20
      subject.to_s.should == "<tag>This is some text.</tag>  "

      subject.width = 18
      subject.width.should == 18
      subject.to_s.should == "<tag>This is some text.</tag>"

      subject.width = 11
      subject.width.should == 11
      subject.to_s.should == "<tag>This is</tag> ..."

      subject.width = 0
      subject.width.should == 0
      subject.to_s.should == ""

      subject.width = nil
      subject.width.should == 18
      subject.to_s.should == "<tag>This is some text.</tag>"
    end
  end
end
