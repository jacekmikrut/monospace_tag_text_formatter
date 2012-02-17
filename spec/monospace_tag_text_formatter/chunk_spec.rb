require "spec_helper"

describe MonospaceTagTextFormatter::Chunk do

  describe "new instance" do

    context %q{.new()} do
      subject { described_class.new() }
      its(:blank?        ) { should be_true }
      its(:display_length) { should == 0 }
      its(:to_s          ) { should == "" }
    end

    context %q{.new('')} do
      subject { described_class.new('') }
      its(:blank?        ) { should be_true }
      its(:display_length) { should == 0 }
      its(:to_s          ) { should == '' }
    end

    context %q{.new('word')} do
      subject { described_class.new('word') }
      its(:blank?        ) { should be_false }
      its(:display_length) { should == 4 }
      its(:to_s          ) { should == 'word' }
    end

    context %q{.new('This is some text.')} do
      subject { described_class.new('This is some text.') }
      its(:blank?        ) { should be_false }
      its(:display_length) { should == 18 }
      its(:to_s          ) { should == 'This is some text.' }
    end

    context %q{.new('<tag>')} do
      subject { described_class.new('<tag>') }
      its(:blank?        ) { should be_false }
      its(:display_length) { should == 0 }
      its(:to_s          ) { should == '<tag>' }
    end

    context %q{.new('A tag <tag>is here</tag>.')} do
      subject { described_class.new('A tag <tag>is here</tag>.') }
      its(:blank?        ) { should be_false }
      its(:display_length) { should == 14 }
      its(:to_s          ) { should == 'A tag <tag>is here</tag>.' }
    end

    context %q{.new('A tag <tag attr1="value1" attr2="value2">is here</tag>.')} do
      subject { described_class.new('A tag <tag attr1="value1" attr2="value2">is here</tag>.') }
      its(:blank?        ) { should be_false }
      its(:display_length) { should == 14 }
      its(:to_s          ) { should == 'A tag <tag attr1="value1" attr2="value2">is here</tag>.' }
    end
  end

  describe "#slice!" do

    context %q{MonospaceTagTextFormatter::Chunk.new('<tag>This is some text.</tag>')} do
      subject { described_class.new('<tag>This is some text.</tag>') }

      context ".slice!(10)" do
        it { subject.slice!(10).should == described_class.new('<tag>This is</tag>') }
        describe "the remaining chunk" do
          it { subject.slice!(10); subject.should == described_class.new('<tag>some text.</tag>') }
        end
      end
    end

    context %q{MonospaceTagTextFormatter::Chunk.new('<tag attr1="value1" attr2="value2">This is some text.</tag>')} do
      subject { described_class.new('<tag attr1="value1" attr2="value2">This is some text.</tag>') }

      context ".slice!(10)" do
        it { subject.slice!(10).should == described_class.new('<tag attr1="value1" attr2="value2">This is</tag>') }
        describe "the remaining chunk" do
          it { subject.slice!(10); subject.should == described_class.new('<tag attr1="value1" attr2="value2">some text.</tag>') }
        end
      end
    end

    context %q{MonospaceTagTextFormatter::Chunk.new('<tag_a>This <tag_b>is some</tag_b> text.</tag_a>')} do
      subject { described_class.new('<tag_a>This <tag_b>is some</tag_b> text.</tag_a>') }

      context ".slice!(10)" do
        it { subject.slice!(10).should == described_class.new('<tag_a>This <tag_b>is</tag_b></tag_a>') }
        describe "the remaining chunk" do
          it { subject.slice!(10); subject.should == described_class.new('<tag_a><tag_b>some</tag_b> text.</tag_a>') }
        end
      end
    end

    context %q{MonospaceTagTextFormatter::Chunk.new('<tag_a attr1="value1" attr2="value2">This <tag_b attr3="value3" attr4="value4">is some</tag_b> text.</tag_a>')} do
      subject { described_class.new('<tag_a attr1="value1" attr2="value2">This <tag_b attr3="value3" attr4="value4">is some</tag_b> text.</tag_a>') }

      context ".slice!(10)" do
        it { subject.slice!(10).should == described_class.new('<tag_a attr1="value1" attr2="value2">This <tag_b attr3="value3" attr4="value4">is</tag_b></tag_a>') }
        describe "the remaining chunk" do
          it { subject.slice!(10); subject.should == described_class.new('<tag_a attr1="value1" attr2="value2"><tag_b attr3="value3" attr4="value4">some</tag_b> text.</tag_a>') }
        end
      end
    end
  end
end
