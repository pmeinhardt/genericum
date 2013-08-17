require "spec_helper"

describe Drug do
  describe "#name" do
    it "is required" do
      drug = Fabricate.build(:drug, name: "")
      drug.should be_invalid
    end
  end

  describe ".search" do
    let(:query) { "para" }

    before do
      @paracetamol = Fabricate(:drug, name: "Paracetamol 500mg Tbl")
      @aspirin = Fabricate(:drug, name: "Aspirin 500mg Tbl")
    end

    it "returns matching drugs" do
      Drug.search(query).to_a.should == [@paracetamol]
    end
  end
end
