require "spec_helper"

describe "application" do
  def app
    Sinatra::Application
  end

  def response
    last_response
  end

  def json
    @json ||= JSON.parse(last_response.body)
  end

  describe "/" do
    it "renders the index page" do
      get "/"
      response.should be_ok
    end
  end

  describe "/search.json" do
    let(:query) { "para" }

    before do
      Fabricate(:substance, name: "Paracetamol")
      Fabricate(:drug, name: "Paracetamol 500mg Tbl")
      get "/search.json", query: query
    end

    it "returns substances matching the query" do
      json["substances"].should == Substance.search(query).map(&:as_json)
    end

    it "returns drugs matching the query" do
      json["drugs"].should == Drug.search(query).map(&:as_json)
    end
  end

  describe "/substances.json" do
    before do
      Fabricate(:substance)
      Fabricate(:substance)
      get "/substances.json"
    end

    it "returns all substances" do
      json.should == Substance.all.map(&:as_json)
    end
  end

  describe "/substances/:id.json" do
    let(:substance) { Fabricate(:substance).reload }

    it "returns the substance for the given id" do
      get "/substances/#{substance.id}.json"
      json.should == substance.as_json
    end

    it "returns a 404 for invalid ids" do
      get "/substances/#{substance.id + 1}.json"
      response.status.should == 404
    end
  end

  describe "/substances/:id/drugs.json" do
    let(:substance) { Fabricate(:substance) }

    before do
      substance.drugs << Fabricate(:drug)
      substance.drugs << Fabricate(:drug)
    end

    it "returns all drugs containing the substance" do
      get "/substances/#{substance.id}/drugs.json"
      json.should == substance.drugs.map(&:as_json)
    end

    it "returns a 404 for invalid substance ids" do
      get "/substances/#{substance.id + 1}/drugs.json"
      response.status.should == 404
    end
  end

  describe "/drugs.json" do
    before do
      Fabricate(:drug)
      Fabricate(:drug)
      get "/drugs.json"
    end

    it "returns all drugs" do
      json.should == Drug.all.map(&:as_json)
    end
  end

  describe "/drugs/:id.json" do
    let(:drug) { Fabricate(:drug).reload }

    it "returns the drug for the given id" do
      get "/drugs/#{drug.id}.json"
      json.should == drug.as_json
    end

    it "returns a 404 for invalid ids" do
      get "/drugs/#{drug.id + 1}.json"
      response.status.should == 404
    end
  end

  describe "/drugs/:id/substances.json" do
    let(:drug) { Fabricate(:drug) }

    before do
      drug.substances << Fabricate(:substance)
      drug.substances << Fabricate(:substance)
    end

    it "returns all substances the drug contains" do
      get "/drugs/#{drug.id}/substances.json"
      json.should == drug.substances.map(&:as_json)
    end

    it "returns a 404 for invalid drug ids" do
      get "/drugs/#{drug.id + 1}/substances.json"
      response.status.should == 404
    end
  end
end
