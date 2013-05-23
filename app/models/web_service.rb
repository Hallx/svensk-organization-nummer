require 'nokogiri'
require 'open-uri'

class WebService  
  def self.get_companies(search_term)
    begin
      companies = []
      puts uri_name = URI.escape(search_term.split.join("+"))
      document = Nokogiri::HTML(open("http://www.allabolag.se/?what=#{uri_name}"))
      
      position = 0
      document.xpath('//*[@id="hitlistName"]/a').each do |element|
        companies.push(process_company(element, search_term, position = position + 1))
      end
      return companies
    # rescue
      # #TODO: some error handling
      # raise "error in parsing the search page"
    # ensure
      # return nil
    end
  end
  
  def self.process_company(element, search_term, position)
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
    
    company = {:name => element['title']}
    company[:search_term] = search_term
    company[:rank] = position
    company[:organization_number] =
      if id[6..9].match(/^\d+$/).nil?
        "#{id[0..5]}-XXXX"
      else
        "#{id[0..5]}-#{id[6..9]}"
      end

    return company
  end

end