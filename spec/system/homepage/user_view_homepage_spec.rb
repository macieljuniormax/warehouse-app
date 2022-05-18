require 'rails_helper'

describe 'Usuário visita tela inical' do
  it 'e vê o nome do app' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    #cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000, address: 'Avenida Atlântida, 50', cep: '20000-000', description: 'Perto do Aeroporto')

    # Act
    visit('/')

    # Assert
    #garantir que eu vejo na tela os galpões Rio e Maceio
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('50000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
  
end