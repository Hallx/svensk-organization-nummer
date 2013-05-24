class CachedResult < ActiveRecord::Base
  attr_accessible :result, :search_term
  serialize :result, Array
  
  before_save :delete_records_with_same_search_term
  # after_find :delete_old_record
  
  def delete_records_with_same_search_term
    old_results = CachedResult.where(:search_term => self.search_term)
    old_results.each { |x| x.destroy }
  end
  
  #TODO: expire the cache result if it's old
  # def delete_old_record
    # if self.created_at > (Time.now - 1.week)
      # self.destroy
      # return nil
    # end
  # end
  
end
