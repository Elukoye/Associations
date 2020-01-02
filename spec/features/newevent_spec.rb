require 'rails_helper'

RSpec.describe 'event form' do
  scenario 'renders event form' do
    visit '/events'
    expect(page).to have_content('Events')
  end
end