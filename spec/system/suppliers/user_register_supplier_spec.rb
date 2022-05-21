require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do menu' do
    # Arrage

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    
    # Assert
    expect(page).to have_content('Nome Fantasia')
    expect(page).to have_content('Razão Social')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('Estado')
    expect(page).to have_content('E-mail')
  end

  it 'com sucesso' do
    # Arrage

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'CNPJ', with: '12.123.123/0001-01'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content('Fornecedor Cadastrado com Sucesso')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru')
    expect(page).to have_content('SP')
  end

  it 'com dados incompletos' do
    # Arrage

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: '12.123.123/0001-01'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content('Fornecedor não cadastrado')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
  end
end