feature 'sign up' do
  scenario 'user can sign up' do
    visit '/signup'
    fill_in('email', with: 'test@test.com')
    fill_in 'password', with: 'pwd1234'
    click_button 'Sign up'
    expect(page).to have_content('test@test.com has been registered.')
  end

  scenario 'user signs up with an existing email address' do
    user = User.create(email: 'test@test.com', password: 'pwd1234')
    visit '/signup'
    fill_in('email', with: 'test@test.com')
    fill_in 'password', with: 'pwd1234'
    click_button 'Sign up'
    expect(page).to have_content('ERROR: This email has already been registered.')
  end
end
