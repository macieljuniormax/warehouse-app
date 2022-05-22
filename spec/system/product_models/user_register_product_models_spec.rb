require 'rails_helper'

describe 'Usuários cadastra um modelo de produtos' do 
  it 'com sucesso' do
    # Arrange 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
      registration_number: '12.123.123/0001-00', 
      full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
      state: 'SP', email: 'sac@samsung.com.br')

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40 Polegadas' 
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10 
    fill_in 'SKU', with: 'TV-40-SAMSUNG-XPTO'
    select 'Samsung', from: 'Fornecedor' 
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Modelo de Produto Cadastrado com Sucesso'
    expect(page).to have_content 'TV 40 Polegadas'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV-40-SAMSUNG-XPTO'
    expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
  end
end