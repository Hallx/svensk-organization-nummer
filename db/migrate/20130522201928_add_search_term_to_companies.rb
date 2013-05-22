class AddSearchTermToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :search_term, :string
  end
end
