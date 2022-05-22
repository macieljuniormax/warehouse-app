require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange 
    User.create!(email: 'macieljunior@gmail.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'macieljunior@gmail.com'
    end
  end

  it 'e faz logout' do
    # Arrange 
    User.create!(email: 'macieljunior@gmail.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'macieljunior@gmail.com'
    expect(page).not_to have_button 'Sair'

  end
end