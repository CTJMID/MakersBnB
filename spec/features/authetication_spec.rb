feature 'authetication' do
    scenario 'a user can log-in ' do
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'test@test.com' )   
        fill_in('password', with: '12345')
        click_button('Log-in')

        expect(page).to have_content('Welcome test@test.com')
    end

    scenario 'a user sees an error if the email is not in DB' do 
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'wrongemail@notindb.com')
        fill_in('password', with: '12345')
        click_button('Log-in')

        expect(page).not_to have_content('Welcome test@test.com')
        expect(page).to have_content('Please check your email or password')
    end 

    scenario 'a user sees an error if they enter wrong password' do
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'test@test.com' )   
        fill_in('password', with: 'wrongpassword')
        click_button('Log-in')

        expect(page).not_to have_content('Welcome test@test.com')
        expect(page).to have_content('Please check your email or password')
    end
    

    scenario 'a user can sign-out, once logged in' do
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'test@test.com' )   
        fill_in('password', with: '12345')
        click_button('Log-in')
        click_button('Log-out')

        expect(page).not_to have_content('Welcome test@test.com')
        expect(page).to  have_content('You have logged out')
    end
end