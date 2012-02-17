require "spec_helper"

describe MonospaceTagTextFormatter::AtomicChunk do

  context 'with "" (empty) content' do
    subject { described_class.new("") }
    its(:display_string) { should == "" }
    its(:display_length) { should == 0 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_true }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "" }
  end

  context 'with "  " (blank) content' do
    subject { described_class.new("  ") }
    its(:display_string) { should == "  " }
    its(:display_length) { should == 2 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_true }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "  " }
  end

  context 'with "\n" (newline) content' do
    subject { described_class.new("\n") }
    its(:display_string) { should == "\n" }
    its(:display_length) { should == 1 }
    its(:newline?      ) { should be_true }
    its(:blank?        ) { should be_true }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "\n" }
  end

  context 'with "some text" content' do
    subject { described_class.new("some text") }
    its(:display_string) { should == "some text" }
    its(:display_length) { should == 9 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "some text" }
  end

  context 'with "<tag>" content' do
    subject { described_class.new("<tag>") }
    its(:display_string) { should == "" }
    its(:display_length) { should == 0 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_true }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should == :tag }
    its(:to_s          ) { should == "<tag>" }
  end

  context 'with "</tag>" content' do
    subject { described_class.new("</tag>") }
    its(:display_string) { should == "" }
    its(:display_length) { should == 0 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_true }
    its(:tag_name      ) { should == :tag }
    its(:to_s          ) { should == "</tag>" }
  end

  context %q{with '<tag attr_1="value1" attr_2="value2">' content} do
    subject { described_class.new('<tag attr_1="value1" attr_2="value2">') }
    its(:display_string) { should == "" }
    its(:display_length) { should == 0 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_true }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should == :tag }
    its(:to_s          ) { should == '<tag attr_1="value1" attr_2="value2">' }
  end

  context 'with "<>" content' do
    subject { described_class.new("<>") }
    its(:display_string) { should == "<>" }
    its(:display_length) { should == 2 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "<>" }
  end

  context 'with "</>" content' do
    subject { described_class.new("</>") }
    its(:display_string) { should == "</>" }
    its(:display_length) { should == 3 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "</>" }
  end

  context 'with "&lt;" content' do
    subject { described_class.new("&lt;") }
    its(:display_string) { should == "&lt;" }
    its(:display_length) { should == 1 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "&lt;" }
  end

  context 'with "&gt;" content' do
    subject { described_class.new("&gt;") }
    its(:display_string) { should == "&gt;" }
    its(:display_length) { should == 1 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "&gt;" }
  end

  context 'with "&abcd;" content' do
    subject { described_class.new("&abcd;") }
    its(:display_string) { should == "&abcd;" }
    its(:display_length) { should == 6 }
    its(:newline?      ) { should be_false }
    its(:blank?        ) { should be_false }
    its(:opening_tag?  ) { should be_false }
    its(:closing_tag?  ) { should be_false }
    its(:tag_name      ) { should be_nil }
    its(:to_s          ) { should == "&abcd;" }
  end

  describe ".closing_tag" do

    context "MonospaceTagTextFormatter::AtomicChunk.closing_tag(:tag_name)" do
      subject { described_class.closing_tag(:tag_name) }
      it { should eq(described_class.new("</tag_name>")) }
    end
  end
end
