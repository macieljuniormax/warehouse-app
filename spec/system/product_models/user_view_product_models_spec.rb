require 'rails_helper'

describe 'Usuários vê modelos de produtos' do
  it 'se estiver autenticado' do
    # Arrange 

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange 
    user = User.create!(email: 'macieljunior@gmail.com', password: 'password')
    # Act
    visit root_path
    login(user)
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    # Arrange 
    user = User.create!(email: 'macieljunior@gmail.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSUNG-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, 
                         sku: 'SOU71_SAMSUNG_NOIZ77', supplier: supplier)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSUNG-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71_SAMSUNG_NOIZ77'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    # Arrange 
    user = User.create!(email: 'macieljunior@gmail.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
  
  it 'com sucesso' do
    # Arrange 
    user = User.create!(email: 'macieljunior@gmail.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                registration_number: '12.123.123/0001-00', 
                                full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSUNG-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, 
                         sku: 'SOU71_SAMSUNG_NOIZ77', supplier: supplier)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSUNG-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71_SAMSUNG_NOIZ77'
    expect(page).to have_content 'Samsung'
  end
end