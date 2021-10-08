class AddUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid, foreign_key: true, index: true

      t.string :name
      t.string :username
      t.string :image

      t.timestamps
    end

    add_index :user_profiles, :username, unique: true
  end
end

