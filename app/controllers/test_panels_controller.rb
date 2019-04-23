class TestPanelsController < ApplicationController

  def show

    test_panel_id = params[:id]
    test_panel = TestPanel::DATA.find { |panel| panel[:id] == test_panel_id.upcase }

    if test_panel.nil?
      render json: {
          message: 'No test panels were found',
          status: 404
      }
    else
      @my_panel = {}
      my_tests = gather_tests(test_panel)
      setup_test_panel_data(test_panel, my_tests)
      render '/test_panels'
    end

  end

  def gather_tests(test_panel)
    my_tests = []
    test_panel[:tests].each do |test|
      my_tests.push Test::DATA.find { |item| item[:id] == test}
    end
    my_tests
  end

  def setup_test_panel_data(test_panel, my_tests)
    @my_panel[:id] = test_panel[:id]
    @my_panel[:price] = test_panel[:price]
    @my_panel[:sample_tube_volumes] = my_tests.map { |item| item[:sample_tube_type].to_s  }
    @my_panel[:sample_volume_requirement] = 0

    my_tests.each do |test|
      @my_panel[:sample_volume_requirement] += test[:sample_volume_requirement]
    end
    
    @my_panel[:included] = my_tests
  end




end