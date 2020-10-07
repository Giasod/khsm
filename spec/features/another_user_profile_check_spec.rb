require 'rails_helper'

RSpec.feature 'USER checks another user profile', type: :feature do
  let(:first_user) { FactoryGirl.create :user }
  let(:second_user) { FactoryGirl.create :user, id: 2 }
  let(:first_game) { FactoryGirl.create :game, balance: 1000, user: second_user }
  let(:second_game) { FactoryGirl.create :game, balance: 0, status: :fail, user: second_user }
  
  scenario 'success' do
    visit '/'
    
    click_link second_user.name
    
    expect(page).to have_current_path 'users/2'
    
    # Проверка, что первый пользователь видит только то, что положено
    expect(page).to have_text second_user.name
    expect(page).not_to have_text('Сменить имя и пароль')
    
    # Проверка дат, выигрышей и тд
    expect(page).to have_content('Выигрыш')
    expect(page).to have_content(1000)
    expect(page).to have_content('Подсказки')
    expect(page).to have_content(first_game.created_at)
    expect(page).to have_content(second_game.created_at)
    expect(page).to have_content('проигрыш')
  end
end
