class CompaniesController < ApplicationController
  # GET /companies/search
  # GET /companies/search.json
  def search
    #TODO: check for input validation
    #TODO: write tests
    
    @companies = Company.search(params[:search_string])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @companies }
    end
  end
end
