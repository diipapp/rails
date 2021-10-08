class CreateTableCategory < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.string :emoji
      t.string :slug
      t.integer :order

      t.timestamps
    end
  end
end
