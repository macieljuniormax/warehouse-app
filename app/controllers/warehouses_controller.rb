class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
  end

  def create
    # Parameters: {"authenticity_token"=>"[FILTERED]", "warehouse"=>
    # {"name"=>"Galpão RIo", "description"=>"Galpão no Rio de Janeiro", "code"=>"RIO", 
    # "address"=>"Avenida do Museu do Amanhã", "city"=>"Rio de Janeiro", "cep"=>"72445-030", "area"=>"32000"}, 
    # "commit"=>"Enviar"}

    # 1 - Receber os dados enviados

    # 2 - Criar um novo galpão no banco de dados
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
    warehouse = Warehouse.new(warehouse_params)
    warehouse.save()

    # 3 - Redirecionar para a tela incial
    flash[:notice] = "Galpão cadastrado com sucesso."
    redirect_to root_path

    # redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
  end
end