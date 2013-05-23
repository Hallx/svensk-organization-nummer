require 'test_helper'

class CachedResultTest < ActiveSupport::TestCase
  test "store cache" do 
    result_stored = CachedResult.create(:search_term => "honolulu", 
      :result => [{"one" => "two", "multi" => {"hi" => "ok"}}, {"five" => 7, "multi" => {"hi" => "ok"}}])    
    # result_stored.save
    
    result_read = CachedResult.where(:search_term => "honolulu").first
    assert_equal(result_stored, result_read)
    assert_equal(result_stored.result, result_read.result)
  end
  
  test "overwrite cache" do
    assert_not_nil(CachedResult.where(:search_term => "mystring").first)
    
    new_result = CachedResult.new(:search_term => "mystring",
       :result => [{"one" => "two", "multi" => {"hi" => "ok"}}, {"five" => 7, "multi" => {"hi" => "ok"}}])
    new_result.save
    results_read = CachedResult.where(:search_term => "mystring")
    assert_equal(1, results_read.size)
    assert_equal(new_result.result, results_read.first.result)
  end
  
  #TODO: expire cache
end
