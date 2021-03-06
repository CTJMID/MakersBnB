require 'pg'

feature 'Display all spaces' do
  scenario 'Return a list of all spaces' do
    Space.create('Space A', 'Test description A', 50)
    Space.create('Space B', 'Test description B', 50)

    visit '/spaces'
    expect(page).to have_selector('h1', :text => "Find the space of your dreams.")
    expect(page).to have_content("Space A")
    expect(page).to have_content("Space B")
  end
end
