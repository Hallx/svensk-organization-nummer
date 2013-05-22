class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :term
      t.integer :rank
      t.integer :company_id

      t.timestamps
    end
  end
end
