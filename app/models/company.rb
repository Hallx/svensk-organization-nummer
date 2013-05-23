#TODO: split models into search and company

class Company
  # include ActiveModel::Validations
  # include ActiveModel::Conversion
  # extend ActiveModel::Naming

  #TODO: add rankings of results
  # attr_accessor :name, :organization_number, :search_term, :rank
  # validates :name, :presence => true
  # validates :organization_number, :format => {:with => /^\d{6}\-[X\d]{4}$/}

  def self.search(search_parameters)
    #TODO: move to appropriate place
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
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end
