feature 'Listing all spaces' do
    scenario 'list spaces' do
        visit '/spaces'
        expect(page).to have_content("Space A")
    end
end