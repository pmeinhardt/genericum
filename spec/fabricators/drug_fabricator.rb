# encoding: utf-8

Fabricator(:drug) do
  name { sequence(:drug_name) { |i| "Drug-#{i}" } }
  form "Tablet"
  manufacturer "Some Manufacturer"
  distribution "OTC"
  info "..."
end
