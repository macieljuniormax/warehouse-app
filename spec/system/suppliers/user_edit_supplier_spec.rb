require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de dealhes' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12.123.123/0001-00', 
      full_address: 'Av das Palmeiras, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act
    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"

    # Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('Razão Social', with: 'ACME LTDA')
    expect(page).to have_field('CNPJ', with: '12.123.123/0001-00')
    expect(page).to have_field('Endereço', with: 'Av das Palmeiras, 100')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'contato@acme.com')
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA SSA', brand_name: 'ACMESSA', registration_number: '12.123.123/0001-00', 
      full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: 'contatoacme@acme.com')

    # Act
    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '12.123.123/0001-01'
    fill_in 'Endereço', with: 'Av das Palmeiras, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on "Enviar"

    # Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Fornecedor: ACME')
    expect(page).to have_content('Razão social: ACME LTDA')
    expect(page).to have_content('Número de registro: 12.123.123/0001-01')
    expect(page).to have_content('Endereço: Av das Palmeiras, 100')
    expect(page).to have_content('Cidade: Bauru')
    expect(page).to have_content('Estado: SP')
    expect(page).to have_content('Contato: contato@acme.com')
  end

  it 'sem sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA SSA', brand_name: 'ACMESSA', registration_number: '12.123.123/0001-00', 
      full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: 'contatoacme@acme.com')

    # Act
    visit root_path
    click_on "Fornecedores"
    click_on "ACME"
    click_on "Editar"
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'Av das Palmeiras, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on "Enviar"

    # Assert
    expect(page).to have_content('Não foi possível atualizar o fornecedor.')
  end
end
