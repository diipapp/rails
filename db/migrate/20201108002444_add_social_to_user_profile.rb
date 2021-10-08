class AddSocialToUserProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :user_profiles, :spotify,   :string
    add_column :user_profiles, :youtube,   :string
    add_column :user_profiles, :twitter,   :string
    add_column :user_profiles, :twitch,    :string
    add_column :user_profiles, :tiktok,    :string
    add_column :user_profiles, :instagram, :string
    add_column :user_profiles, :pinterest, :string
    add_column :user_profiles, :site,      :string
  end
end


