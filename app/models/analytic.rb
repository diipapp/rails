class Analytic < ApplicationRecord

  belongs_to :user
  belongs_to :category,      foreign_key: :type_id, primary_key: :id, optional: true
  belongs_to :recomendation, foreign_key: :type_id, primary_key: :id, optional: true

  validates :type_analytic, inclusion: { in: %w(category tip) }

  private

    def self.increment(user_id, type_analytic, type_id)
      Analytic.find_or_create_by(user_id: user_id, type_analytic: type_analytic, type_id: type_id)
              .increment!(:total)
    end

end