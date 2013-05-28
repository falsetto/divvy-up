module ApplicationHelper
  def divvy_up_module
    Rails.env == 'e2e_test' ? 'divvyUpE2eTest' : 'divvyUp'
  end
end
