require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = cached_results(:one)
  end

  test "should get search" do
    get :search, :search_string => "mystring"
    assert_response :success
    assert_not_nil assigns(:companies)
  end
  
  test "should get search with long search string" do
    get :search, :search_string => "kentor it kentor ab"
    assert_response :success
    assert_not_nil assigns(:companies)
  end
  
  
  #test no search string
  #   
end
