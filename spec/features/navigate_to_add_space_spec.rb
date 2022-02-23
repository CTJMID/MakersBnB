feature 'Navigate to add a new space page' do
    scenario 'click a button on the show all spaces page' do
        visit '/spaces'
        click_on 'Add a space'
        expect(page).to have_current_path('http://www.example.com/spaces/new', url: true)
    end

end 