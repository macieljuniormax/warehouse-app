class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # Parameters: {"authenticity_token"=>"[FILTERED]", "warehouse"=>
    # {"name"=>"Galpão RIo", "description"=>"Galpão no Rio de Janeiro", "code"=>"RIO", 
    # "address"=>"Avenida do Museu do Amanhã", "city"=>"Rio de Janeiro", "cep"=>"72445-030", "area"=>"32000"}, 
    # "commit"=>"Enviar"}

    # 1 - Receber os dados enviados

    # 2 - Criar um novo galpão no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save()
      flash[:notice] = "Galpão cadastrado com sucesso."
      redirect_to root_path
    else
      flash.now[:notice] = "Galpão não cadastrado." # utilizada apenas na requisição que ela é criada
      render 'new'
    end
    
    # redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)

     if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
     else
      flash.now[:notice] = "Não foi possível atualizar o galpão." # utilizada apenas na requisição que ela é criada
      render 'edit'
     end 
    
  end
end