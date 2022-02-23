feature "add a space" do
  scenario "User submits a form to submit a listing" do
    visit('/spaces/new')

    fill_in('title', with: 'Nice bedroom')
    fill_in('description', with: 'This is a really but really really nice bedroom')
    fill_in('price', with: 50.00)
    click_button('Submit')

    expect(page.status_code).to be(200)
    expect(page).to have_content 'Nice bedroom'
    expect(page).to have_content 'This is a really but really really nice bedroom'
    expect(page).to have_content '£50 per night'
  end
end

  # scenario "User submits description of space" do 
  #   visit('/spaces/new')

  #   fill_in('title', with: 'Nice bedroom')
  #   fill_in('description', with: 'This is a really but really really nice bedroom')
  #   fill_in('price', with: 50.00)
  #   click_button('Submit')

  #   expect(page).to have_content 'This is a really but really really nice bedroom'
  # end 

  # scenario "User submits price of space" do 
  #   visit('/spaces/new')

  #   fill_in('title', with: 'Nice bedroom')
  #   fill_in('description', with: 'This is a really but really really nice bedroom')
  #   fill_in('price', with: 50.00)
  #   click_button('Submit')

  #   expect(page).to have_content '£50 per night'
  # end 



