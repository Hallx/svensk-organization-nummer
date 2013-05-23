class CreateCachedResults < ActiveRecord::Migration
  def change
    create_table :cached_results do |t|
      t.string :search_term
      t.string :result

      t.timestamps
    end
  end
end
