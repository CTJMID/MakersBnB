feature "Ability to book a space" do
  scenario "Once a space has been booked from the form button, it becomes unavailable" do
    visit('/spaces/new')
    fill_in('title', with: 'Space A')
    fill_in('description', with: 'A nice space')
    fill_in('price', with: 50.00)
    click_button('Submit')
    expect(page).to have_content 'Space A'

    fill_in('available_from', with: '2022-02-23')
    fill_in('available_to', with: '2022-02-25')
    click_button('List Spaces')
    expect(page).to have_content 'Space A'

    click_button('Book')

    fill_in('available_from', with: '2022-02-23')
    fill_in('available_to', with: '2022-02-25')
    click_button('List Spaces')
    expect(page).not_to have_content 'Space A'
  end
end