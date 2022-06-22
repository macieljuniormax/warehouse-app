require 'rails_helper'

describe "Usuário edita um pedido" do
  it "e não é dono" do
     # Arrange
     maciel = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
     rodrigo = User.create!(name: 'Rodrigo', email: 'rodrigocalazans@gmail.com', password: 'password')
 
     warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                   description: 'Galpão destinados para cargas internacionais.')
     supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                 registration_number: '12.123.123/0001-00', 
                                 full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                 state: 'SP', email: 'sac@samsung.com.br')
 
     order = Order.create!(user: maciel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
     # Act
     login_as(rodrigo)
     patch(order_path(order.id), params: {order: {supplier_id: 1}})
 
     # Assert
     expect(response).to redirect_to(root_path)
  end

  
end