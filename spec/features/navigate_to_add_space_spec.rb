feature 'Navigate to add a new space page' do
    scenario 'click a button on the show all spaces page' do
        User.create(email: 'test@test.com', password: '12345') 
        visit '/sessions/new'
        fill_in('email', with: 'test@test.com' )   
        fill_in('password', with: '12345')
        click_button('Log-in')
        click_on 'Add a space'
        expect(page).to have_current_path('http://www.example.com/spaces/new', url: true)
    end

end 