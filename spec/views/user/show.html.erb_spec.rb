require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Test') } # нам нужен залогиненный юзер
  
  before(:each) do
    assign(:user, user) # назначаем юзера
    sign_in user # log in
    assign(:games, [ build_stubbed(:game)]) # назначаем игру

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
