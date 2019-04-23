class TestPanelsController < ApplicationController

  def show
    test_panel_id = params[:id]
    include_test = params[:include]
    #byebug
    test_panel = TestPanel::DATA.find { |panel| panel[:id] == test_panel_id }

    #gather tests
    my_tests = []
    test_panel[:tests].each do |test|
      my_tests.push Test::DATA.find { |item| item[:id] == test}
    end

    @my_panel = {}
    @my_panel[:id] = test_panel[:id]
    @my_panel[:price] = test_panel[:price]
    @my_panel[:sample_tube_volumes] = my_tests.map { |item| item[:sample_tube_type].to_s  }
    @my_panel[:sample_volume_requirement] = 0

    my_tests.each do |test|
      @my_panel[:sample_volume_requirement] += test[:sample_volume_requirement]
    end



    my_tests.each do |item|
      item[:type] = 'test'
    end

    @my_panel[:included] = my_tests





    render '/test_panels'

  end

  



end