feature "Ability to book a space" do
  scenario "Once a space has been booked from the form button, it becomes unavailable" do
    visit('/spaces/new')
    fill_in('title', with: 'Nice bedroom')
    fill_in('price', with: 50.00)
    click_button('Submit')
    click_button('Book')

    expect(page).to have_content 'Unavailable'

  end
end