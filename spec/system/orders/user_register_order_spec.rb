require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    click_on 'Registrar Pedido'

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')

    Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, 
      address: 'Avenida tiradentes, 20', cep: '46000-000', 
      description: 'Galpão para cargas mineiras.')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinados para cargas internacionais.')
    

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista', with: '20/12/2022'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABCD1234'
    expect(page).to have_content 'Galpão de destino: Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletrônicos SA'
    expect(page).to have_content 'Usuário responsável: Maciel | macieljunior@gmail.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Spark'
  end
end