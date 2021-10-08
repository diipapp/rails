class AddTableAnalytics < ActiveRecord::Migration[6.0]
  def change
    drop_table(:analytics, if_exists: true)
    create_table :analytics, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: true, index: true
      t.string :type_analytic,    :null => false, :limit => 20  
      t.uuid :type_id,          :null => false

      t.integer :total

      t.timestamps
    end
  end
end
