class CreateRecomendation < ActiveRecord::Migration[6.0]
  def change
    create_table :recomendations, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: true, index: true
      t.belongs_to :category, null: false, type: :uuid, foreign_key: true, index: true

      t.string :title
      t.string :link, limit: 2083
      t.string :image
      t.string :price
      t.boolean :visible
      t.integer :order

      t.timestamps
    end
  end
end
