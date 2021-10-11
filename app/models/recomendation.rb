class Recomendation < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  has_many :analytics, -> { where type_analytic: "tip" }, foreign_key: :type_id, primary_key: :id

  validates_associated :user, :category
  validates :title, :link, :image, presence: true
  validates :link, format: URI::regexp(%w[http https])
  
  # validate  :limits_by_category
 
  private

    # def limits_by_category
    #   if user && new_record?
    #     if user.recomendations.where(category_id: category.id).count == 9
    #       errors.add(:limit, "max")
    #     end
    #   end
    # end

end