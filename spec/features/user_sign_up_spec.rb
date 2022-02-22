feature 'sign up' do
    scenario 'user can sign up' do 
        visit '/signup'
        fill_in('email', with: 'test@test.com')
        fill_in 'password', with: 'pwd1234'
        click_button 'Sign up'
        expect(page).to have_content('test@test.com has been registered.')
    end
end    