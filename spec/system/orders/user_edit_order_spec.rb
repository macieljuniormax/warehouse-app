require 'rails_helper'

describe "Usuário edita um pedido" do
  it "e deve estar autenticado" do
    # Arrange
    maciel = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    order = Order.create!(user: maciel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
   
    # Act
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it "com sucesso" do
    # Arrange
    maciel = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    supplier_1 = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')
    supplier_2 = Supplier.create!(corporate_name: 'Spark Industria SA', brand_name: 'SPARK', 
                                  registration_number: '12.123.123/0001-01', 
                                  full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                  state: 'SP', email: 'sac@spark.com.br')

    order = Order.create!(user: maciel, warehouse: warehouse, supplier: supplier_1, estimated_delivery_date: 1.day.from_now)
   
    # Act
    login_as(maciel)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega',	with: '12/12/2022' 
    select 'Spark Industria SA', from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: Spark Industria SA'
    expect(page).to have_content "Data Prevista de Entrega: 12/12/2022"
  end

  it "caso seja o responsável" do
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
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq root_path
  end
end