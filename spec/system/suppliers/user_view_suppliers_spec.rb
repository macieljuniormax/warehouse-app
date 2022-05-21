require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    # Arrage

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    

    # Assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    # Arrage
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12.123.123/0001-01', 
                     full_address: 'Av das Palmeiras, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Sparke industries Brazil LTDA', brand_name: 'Spark', registration_number: '12.123.123/0001-02', 
                     full_address: 'Torre da Indústria, 250', city: 'Teresina', state: 'PI', email: 'vendas@spark.com')

    # Act 
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')
    expect(page).to have_content('Spark')
    expect(page).to have_content('Teresina - PI')
    expect(page).not_to have_content('Não existem fornecedores cadastrados')

  end

  it 'com sucesso' do
    # Arrage
    

    # Act 
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
end