feature 'Navigate to add a new space page' do
    scenario 'click a button on the show all spaces page' do
        visit '/spaces'
        click_button 'Add a space'
        expect(page).to have_current_path(people_url, url: true)
    end

end 