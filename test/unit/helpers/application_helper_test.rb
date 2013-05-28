require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "#divvy_up_module returns 'divvyUp' when not in e2e_test env" do
    Rails.stub :env, 'production' do
      divvy_up_module.must_equal 'divvyUp'
    end
  end

  test "#divvy_up_module returns 'divvyUpE2eTest' when in e2e_test env" do
    Rails.stub :env, 'e2e_test' do
      divvy_up_module.must_equal 'divvyUpE2eTest'
    end
  end
end
