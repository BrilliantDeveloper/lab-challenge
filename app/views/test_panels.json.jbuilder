

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
      json.data do
        json.array! @my_panel[:included], :id, :type
      end
byebug
    end
  end
end