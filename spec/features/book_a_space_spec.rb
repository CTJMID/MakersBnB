feature "Ability to book a space" do
  scenario "Once a space has been booked from the form button, it becomes unavailable" do
    User.create(email: 'test@test.com', password: '12345') 
    visit '/sessions/new'
    fill_in('email', with: 'test@test.com' )   
    fill_in('password', with: '12345')
    click_button('Log-in')
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
    expect(page).to have_content 'Finalise your booking'
    
    fill_in('available_from', with: '23-02-2022')
    fill_in('available_to', with: '25-02-2022')
    click_button('Book now')
    expect(page).to have_content 'Booking confirmed!'
    
    click_link('Return home')
    fill_in('available_from', with: '2022-02-23')
    fill_in('available_to', with: '2022-02-25')
    click_button('List Spaces')
    expect(page).not_to have_content 'Space A'
  end
end