feature "list a space" do
  scenario "User submits a form to submit a listing" do
    visit('/spaces/new')

    fill_in('title', with: 'Nice bedroom')
    click_button('Submit')

    # This will be the test when the 'see all spaces' feature is complete
    # expect(page).to have_content 'Nice bedroom'
    
    expect(page.status_code).to be(200)
  end
end