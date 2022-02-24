require 'pg'

feature 'Display all spaces' do
  scenario 'Return a list of all spaces' do
    space_a = Space.create('Space A', 'Test Description', 50)
    Booking.create('2022-02-23', '2022-02-25', space_a.id)
    space_b = Space.create('Space B', 'Test Description', 50)
    Booking.create('2022-02-26', '2022-02-28', space_b.id)

    visit '/spaces'
    expect(page).to have_selector('h1', :text => "Makers B'n'B")
    expect(page).to have_content("Space A")
    expect(page).to have_content("Space B")

    fill_in('available_from', with: '2022-02-23')
    fill_in('available_to', with: '2022-02-25')
    click_button('List Spaces')

    expect(page).not_to have_content("Space A")
    expect(page).to have_content("Space B")
  end
end
