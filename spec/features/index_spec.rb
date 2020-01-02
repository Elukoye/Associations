require 'rails_helper'

RSpec.describe 'Home Page' do
  scenario 'home page' do
    visit '/signup'
    expect(page).to have_content('Sign up | Events Sample App')
  end
end