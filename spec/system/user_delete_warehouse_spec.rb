require 'rails_helper'

describe "Usuário remove um galpão" do
  it 'com sucesso' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, 
                                  address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
                                  description: 'Galpão no centro do páis.' )

    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10_000, 
                                  address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
                                  description: 'Galpão no centro do páis.' )
    warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, 
                                  address: 'Avenida tiradentes, 20', cep: '46000-000', 
                                  description: 'Galpão para cargas mineiras.' )

    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'
  end

  
end