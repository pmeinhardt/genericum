require "spec_helper"

describe Substance do
  describe "#name" do
    it "is required" do
      substance = Fabricate.build(:substance, name: "")
      substance.should be_invalid
    end
  end

  describe "#drugs" do
    subject { Fabricate(:substance) }
    let(:drug) { Fabricate(:drug) }

    it "are distinct" do
      2.times { subject.drugs << drug }
      subject.drugs.count.should == 1
    end
  end

  describe ".search" do
    let(:query) { "para" }

    before do
      @paracetamol = Fabricate(:substance, name: "Paracetamol")
      @calcium = Fabricate(:substance, name: "Calcium")
    end

    it "returns matching substances" do
      Substance.search(query).to_a.should == [@paracetamol]
    end
  end
end
