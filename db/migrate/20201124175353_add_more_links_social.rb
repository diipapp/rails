class AddMoreLinksSocial < ActiveRecord::Migration[6.0]
  def change
    add_column :user_profiles, :facebook, :string
    add_column :user_profiles, :medium, :string
    add_column :user_profiles, :behance, :string
    add_column :user_profiles, :linkedin, :string
    add_column :user_profiles, :whatsapp, :string
    add_column :user_profiles, :email, :string
  end
end