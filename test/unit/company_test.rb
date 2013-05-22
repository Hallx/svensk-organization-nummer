require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  
  test "search parameter is null" do
    #TODO: remove later
    companies = Company.search(nil)
    
    assert_not_nil(companies)
    assert(companies.first.valid?)
  end
  
  test "search parameter is already in database" do
    companies = Company.search("g2")
    
    assert_not_nil(companies)
    assert_not_nil(companies.first)
    assert(companies.first.valid?)
    assert_equal("mystring2", companies.first.name.downcase!)
    assert_not_equal(Company.all.size, companies.size)
  end
  
  test "search parameter is not in database but is on allabolag" do
    companies = Company.search("apoex ab")
    
    assert_not_nil(companies)
    assert_not_nil(companies.first)
    assert(companies.first.valid?)
    assert_equal("apoex ab", companies.first.name.downcase!)
    assert_not_equal(Company.all.size, companies.size)
  end
  
  test "search parameter is not in database and isnt valid on allabolag" do  
    companies = Company.search("gol345")
    
    assert_not_nil(companies)
    assert_nil(companies.first)
    assert_equal(0, companies.size)
  end
  
  test "search parameter gives the correct company details from allabolag" do
    companies = Company.search("kentor it ab")
    
    assert_not_nil(companies)
    assert_not_nil(companies.first)
    
    kentor = companies.first
    assert(kentor.valid?)
    assert_equal("kentor it ab", kentor.name.downcase!)
    assert_equal("556284-2319", kentor.organization_number)

  end
end
