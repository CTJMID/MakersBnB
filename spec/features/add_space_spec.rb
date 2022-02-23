feature "add a space" do
  scenario "User submits a form to submit a listing" do
    visit('/spaces/new')

    fill_in('title', with: 'Nice bedroom')
    click_button('Submit')

    expect(page.status_code).to be(200)
    expect(page).to have_content 'Nice bedroom'
  end
end
