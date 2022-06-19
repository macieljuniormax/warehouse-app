require 'rails_helper'

describe "Usuário vê seus próprios pedidos" do
  it "e deve estar autenticado" do
    # Arrange

    # Act
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(current_path).to eq new_user_session_path 
  end

  it "e não vê outros pedidos" do
    # Arrange
    user1 = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
    user2 = User.create!(name: 'Rodrigo', email: 'rodrigocalazans@gmail.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    order1 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    order2 = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    order3 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
    
    # Act
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content order1.code
    expect(page).not_to have_content order2.code
    expect(page).to have_content order3.code
  end
  
  it "e visita um pedido" do
    # Arrange
    user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão de Destino: Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletrônicos SA'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end 

  it "e não visita pedidos de outros usuários" do
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
 
     order = Order.create!(user: rodrigo, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
     
     # Act
     login_as(maciel)
     visit order_path(order.id)
 
     # Assert
     expect(current_path).not_to eq order_path(order.id)
     expect(current_path).to eq root_path
     expect(page).to have_content 'Você não possui acesso a esse pedido.'
  end
end
