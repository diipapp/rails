class AddDiscardedAtToRecomendations < ActiveRecord::Migration[6.0]
  def change
    add_column :recomendations, :discarded_at, :datetime
    add_index :recomendations, :discarded_at
  end
end
