require 'rails_helper'

RSpec.describe 'login' do
  scenario 'fails to login exisitng user' do
    visit '/login'
    fill_in 'Email', with: ' '
    click_on 'Log in'
    expect(page).to have_content('Invalid email/password combination')
  end
end