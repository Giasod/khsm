require 'rails_helper'

RSpec.feature 'USER checks another user profile', type: :feature do
  let(:first_user) { FactoryBot.create :user }
  let(:second_user) { FactoryBot.create :user }
  let(:first_game) { FactoryBot.create :game, prize: 1000, user: second_user }
  let(:second_game) { FactoryBot.create :game, user: second_user }
  
  let!(:games) { [first_game, second_game] }
  
  scenario 'success' do
    visit '/'
    
    expect(page).to have_text(second_user.name)
    
    click_link second_user.name

    expect(page).to have_current_path "/users/#{second_user.id}"
    
    # Проверка, что первый пользователь видит только то, что положено
    expect(page).to have_text second_user.name
    expect(page).not_to have_text('Сменить имя и пароль')
    
    # Проверка дат, выигрышей и тд
    expect(page).to have_content('Выигрыш')
    expect(page).to have_content(0)
    expect(page).to have_content('1 000 ₽')
    expect(page).to have_content('Подсказки')
    expect(page).to have_content(I18n.l(first_game.created_at, format: :short))
    expect(page).to have_content(I18n.l(second_game.created_at, format: :short))
  end
end
