require 'pg'

feature 'Display all spaces' do
  scenario 'Return a list of all spaces' do
    Space.create('Space A')
    Space.create('Space B')

    visit '/spaces'
    expect(page).to have_selector('h1', :text => "Maker's B'n'B")
    expect(page).to have_content("Space A")
    expect(page).to have_content("Space B")
  end
end
