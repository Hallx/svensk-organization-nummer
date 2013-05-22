require 'nokogiri'
require 'open-uri'

#TODO: split models into search and company

class Company < ActiveRecord::Base
  belongs_to :search
  
  attr_accessible :name, :organization_number, :search_term
  validates :name, :presence => true
  validates :organization_number, :format => {:with => /^\d{6}\-[X\d]{4}$/} 
  
 
  def self.search(search_parameters)
    if search_parameters
      search_parameters.downcase!
      companies = find(:all, :conditions => ['search_term = ?', "#{search_parameters}"])
      
      if companies.empty?
        get_companies_from_alla_bolag(search_parameters)
        companies = find(:all, :conditions => ['search_term = ?', "#{search_parameters}"])
      else
        return companies
      end
    else
      find(:all)
    end
  end
  
  def self.get_companies_from_alla_bolag(name)
    begin
      puts uri_name = URI.escape(name.split.join("+"))
      document = Nokogiri::HTML(open("http://www.allabolag.se/?what=#{uri_name}"))
      
      position = 0
      document.xpath('//*[@id="hitlistName"]/a').each do |element|
        process_company(element, name, position = position + 1)
      end
    # rescue
      # #TODO: some error handling
      # raise "error in parsing the search page"
    # ensure
      # return nil
    end
  end
  
  def self.process_company(element, name, position)
    #verify
    unless element.keys.size == 2
      if position < 2
        raise "error getting to the correct element" 
      else
        return
      end
    end
    puts "element name returned is #{element['title']}"
    # raise "name mismatch/not found" unless element['title'].downcase == name.downcase 
    
    id = element['href'].split("/")[3]
    
    #verify
    raise "incorrect size for id" unless id.size == 10
    raise "id is not valid - does not contain numbers" if id[0..5].match(/^\d+$/).nil?
    
    company = Company.new(:name => element['title'])
    company.search_term = name
    company.organization_number =
      if id[6..9].match(/^\d+$/).nil?
        "#{id[0..5]}-XXXX"
      else
        "#{id[0..5]}-#{id[6..9]}"
      end
    
    company.save
    return company
  end
end
