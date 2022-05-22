class ProductModelsController < ApplicationController
  before_action :set_product_models, only: [:show]

  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_models_params)

    if @product_model.save()
      flash[:notice] = "Modelo de Produto Cadastrado com Sucesso"
      # redirect_to product_model_path
      redirect_to @product_model # procura a rota show
    else
      @suppliers = Supplier.all
      flash.now[:notice] = "Modelo de Produto não cadastrado." # utilizada apenas na requisição que ela é criada
      render 'new'
    end
  end

  private
  def set_product_models
    @product_model = ProductModel.find(params[:id])
  end

  def product_models_params
    params.require(:product_model).permit(:name, :width, :weight, :height, :depth, :sku, :supplier_id)
  end
end