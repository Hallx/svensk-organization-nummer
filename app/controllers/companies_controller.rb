class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index
    #TODO: check for input validation
    #TODO: write tests
    
    # @companies = Company.all
    @companies = Company.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @companies }
    end
  end
end
