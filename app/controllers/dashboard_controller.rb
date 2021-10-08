class  DashboardController < ApplicationController

  def show
    @categories = Category.all.order(order: :asc)
  end

end