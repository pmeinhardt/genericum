# encoding: utf-8

Fabricator(:substance) do
  name { sequence(:substance_name) { |i| "Substance-#{i}" } }
end
