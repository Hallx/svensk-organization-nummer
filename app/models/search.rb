class Search < ActiveRecord::Base
  has_many :companies
  
  attr_accessible :rank, :term
  
  
end
