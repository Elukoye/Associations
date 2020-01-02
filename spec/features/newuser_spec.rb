require 'rails_helper'

RSpec.describe ' invalid signup' do 
  scenario 'fails to create user account' do
    visit '/signup'
    fill_in 'Name', with: ' '
    click_on 'Sign up'
    expect(page).to have_content('Email is invalid' )
  end
end