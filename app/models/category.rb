class Category < ApplicationRecord

  has_many :recomendations
  has_one :analytic, -> { where type_analytic: "category" }, foreign_key: :type_id, primary_key: :id

  before_save :create_slug
  
  def create_slug
    self.slug = I18n.transliterate(self.name).downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end