require "rubygems"
require "bundler"

Bundler.require(:default, ENV["RACK_ENV"] || "development")

Dir[File.join(settings.root, "lib/**/*.rb")].each { |file| require file }

configure :test do
  set :database, "postgresql://localhost/pharma-test"
end

configure :development do
  set :database, "postgresql://localhost/pharma-dev"
end

configure :production do
  set :database, ENV["DATABASE_URL"]
end

configure do
  set :json_encoder, JSON
end

error ActiveRecord::RecordNotFound do
  halt 404
end

get "/" do
  erb :index
end

get "/search.json" do
  query = params[:query]
  @substances = Substance.search(query).limit(5)
  @drugs = Drug.search(query).limit(5)
  json drugs: @drugs.as_json, substances: @substances.as_json
end

get "/substances.json" do
  @substances = Substance.all
  json @substances.as_json
end

get "/substances/:id.json" do
  @substance = Substance.find(params[:id])
  json @substance.as_json
end

get "/substances/:id/drugs.json" do
  @substance = Substance.find(params[:id])
  json @substance.drugs.as_json
end

get "/drugs.json" do
  @drugs = Drug.all
  json @drugs.as_json
end

get "/drugs/:id.json" do
  @drug = Drug.find(params[:id])
  json @drug.as_json
end

get "/drugs/:id/substances.json" do
  @drug = Drug.find(params[:id])
  json @drug.substances.as_json
end
