class SuppliersController < ApplicationController
  before_action :set_suppliers, only: [:show]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  private
  def set_suppliers
    @supplier = Supplier.find(params[:id])
  end
end