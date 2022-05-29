require 'rails_helper'

describe "Usuário busca por um pedido" do
  it "e deve estar autenticado" do
    # Arrange

    # Act
    visit root_path

    # Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
     end 
  end
  
  it "a partir da tela inicial" do
     # Arrange
     user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')

     # Act
     login_as(user)
     visit root_path
 
     # Assert
     within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
     end
  end

  it "e encontra um pedido" do
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
    fill_in 'Buscar Pedido',	with: order.code
    click_on 'Buscar'
 
    # Assert
    expect(page).to have_content("Resultados da busca por: #{order.code}")
    expect(page).to have_content('1')
    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content('Galpão de Destino: Aeroporto SP') 
    expect(page).to have_content('Fornecedor: Samsung Eletrônicos SA')
  end

  it "e encontra múltiplos pedidos" do
    # Arrange
    user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '55000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')                     
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    
    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido',	with: 'GRU'
    click_on 'Buscar'
 
    # Assert
    expect(page).to have_content('2')
    expect(page).to have_content('GRU12345') 
    expect(page).to have_content('GRU98765') 
    expect(page).to have_content('Galpão de Destino: Aeroporto SP') 
    expect(page).not_to have_content('SDU00000') 
    expect(page).not_to have_content('Galpão de Destino: Aeroporto Rio') 
  end
end
