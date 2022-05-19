require 'rails_helper'

describe 'Usuário vê detalhes do fornecedores' do
  it 'a partir da tela inicial' do
    # Arrage
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '434472146', 
      full_address: 'Av das Palmeiras, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    
    # Assert
    expect(page).to have_content('Fornecedor: ACME')
    expect(page).to have_content('Razão social: ACME LTDA')
    expect(page).to have_content('Número de registro: 434472146')
    expect(page).to have_content('Endereço: Av das Palmeiras, 100')
    expect(page).to have_content('Cidade: Bauru')
    expect(page).to have_content('Estado: SP')
    expect(page).to have_content('Contato: contato@acme.com')

  end

  it 'e volta para a tela inicial' do
    # Arrage
    Supplier.create!(corporate_name: 'Spark industries Brazil LTDA', brand_name: 'Spark', registration_number: '434472147', 
      full_address: 'Torre da Indústria, 250', city: 'Teresina', state: 'PI', email: 'vendas@spark.com')

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Spark'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq root_path
  end
end