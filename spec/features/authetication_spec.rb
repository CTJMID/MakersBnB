feature 'authetication' do
    scenario 'a user can log-in ' do
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'test@test.com' )   
        fill_in('password', with: '12345')
        click_button('Log-in')

        expect(page).to have_content('Welcome test@test.com')
    end
end