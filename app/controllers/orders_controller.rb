class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update]

  def index
    @orders = current_user.orders
  end
  
  
  def new 
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def show; end

  def search
    @code = params["query"]
  #  @order = Order.find_by(code: params["query"])
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end
  
  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save!()
      flash[:notice] = "Pedido registrado com sucesso."
      redirect_to @order # procura a rota show
    else
      @order = Order.all
      flash.now[:notice] = "Pedido não realizado." # utilizada apenas na requisição que ela é criada
      render 'new'
    end
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
      if @order.update(order_params)
        flash[:notice] = 'Pedido atualizado com sucesso'
        redirect_to @order
      else
        flash[:error] = 'Pedido não atualizado'
        render 'edit'
      end
  end

  private
  def set_order_and_check_user
    @order = Order.find(params[:id])
    redirect_to root_path, alert: 'Você não possui acesso a esse pedido.' unless @order.user == current_user
  end
end