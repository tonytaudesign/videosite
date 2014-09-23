class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
 			t.integer :age
      t.string :sex
      t.string :location
      t.string :keywords
      t.timestamps
    end
  end
end
