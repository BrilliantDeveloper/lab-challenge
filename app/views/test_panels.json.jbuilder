

json.data do
  json.type 'test_panels'
  json.id @my_panel[:id]
  json.attributes do
    json.price @my_panel[:price]
    json.sample_tube_types @my_panel[:sample_tube_volumes]
    json.sample_volume_requirements @my_panel[:sample_volume_requirement]
  end
  json.relationships do
    json.test do
      json.data @my_panel[:included] do |item|
        json.id item[:id]
        json.type 'test'
      end

    end
  end
end

#only show test details if requested in query param
include = params[:include]

if !include.nil? && include.downcase == 'test'
  json.included @my_panel[:included] do |test|
    json.type test[:type]
    json.id test[:id]
    json.attributes do
      json.name test[:name]
      json.sample_volume_requirement test[:sample_volume_requirement]
      json.sample_tube_type test[:sample_tube_type]
    end
  end
end
