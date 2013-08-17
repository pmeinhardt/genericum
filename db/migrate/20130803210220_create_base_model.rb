class CreateBaseModel < ActiveRecord::Migration
  def change
    create_table :substances do |t|
      t.string :name

      t.timestamps
    end

    create_table :drugs do |t|
      t.string :name
      t.string :form
      t.string :manufacturer
      t.string :distribution
      t.text :info

      t.timestamps
    end

    create_join_table :drugs, :substances do |t|
      t.index :substance_id
      t.index :drug_id
    end
  end
end
