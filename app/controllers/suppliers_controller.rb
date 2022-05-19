class SuppliersController < ApplicationController
  before_action :set_suppliers, only: [:show]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      flash[:notice] = "Fornecedor Cadastrado com Sucesso"
      redirect_to suppliers_path
    else
      flash.now[:notice] = "Fornecedor não cadastrado." # utilizada apenas na requisição que ela é criada
      render 'new'
    end
  end

  private
  def set_suppliers
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end
end