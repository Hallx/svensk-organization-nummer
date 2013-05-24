require 'test_helper'

class WebServiceTest < ActiveSupport::TestCase
  test "verify there is no nil company in array" do
    
    companies = WebService.get_companies("kentor it kentor ab")
    
    assert_equal(10, companies.size)
    for company in companies do
      assert_not_nil(company)
      assert(!company.empty?)
      
      assert_not_nil(company[:name])
    end
  end
  
  test "verify there are ten items array" do
    companies = WebService.get_companies("kento it kentor ab")
    assert_equal(10, companies.size)
  end
  
  
  #TODO: mock up the result pages from local storage and test against it
end