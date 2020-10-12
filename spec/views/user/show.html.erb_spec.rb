require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Test') } # нам нужен залогиненный юзер
  let(:user) { create(:user, name: 'Second_Test') } # нам нужен залогиненный юзер
  
  context 'user see his own page' do
    before(:each) do
      assign(:user, user) # назначаем юзера
      sign_in user # log in
      assign(:games, [build_stubbed(:game)]) # назначаем игру
    
      render
    end
  
    it 'renders name' do
      expect(rendered).to match('Test')
    end
  
    it 'renders change password' do
      expect(rendered).to match('Сменить имя и пароль')
    end
  
    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end
  end
  
  context 'first user looks at second user page' do
    before(:each) do
      assign(:user, user)
      assign(:games, [build_stubbed(:game)])

      render
    end

    it 'renders second user name' do
      expect(rendered).to match('Second_Test')
    end

    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end

    it 'renders change password' do
      expect(rendered).not_to match('Сменить имя и пароль')
    end
  end
end
