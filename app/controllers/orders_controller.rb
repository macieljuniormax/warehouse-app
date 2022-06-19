class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end
  
  
  def new 
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def show
    @order = Order.find(params[:id])

    redirect_to root_path, alert: 'Você não possui acesso a esse pedido.' unless @order.user == current_user
    
  end

  def search
    @code = params["query"]
  #  @order = Order.find_by(code: params["query"])
    @orders = Order.where("code LIKE ?", "%#{@code}%")
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
end