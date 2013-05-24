class Company
  def self.search(search_parameters)
    return [] if search_parameters.blank?    
    search_parameters.downcase!
    
    cached_result = CachedResult.where(:search_term => search_parameters).first
    if cached_result.nil? || cached_result.created_at < 1.week.ago
      companies = WebService.get_companies(search_parameters)
      CachedResult.create!(:search_term => search_parameters, :result => companies)
      cached_result = CachedResult.where(:search_term => search_parameters).first
    end
    return cached_result.result
  end
end
