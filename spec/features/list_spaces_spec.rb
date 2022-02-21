require 'pg'

feature 'Listing all spaces' do
  scenario 'list spaces' do
    conn = PG.connect( dbname: 'makersbnb_test')
    conn.exec("INSERT INTO spaces (title) VALUES ('Space A');")
    conn.exec("INSERT INTO spaces (title) VALUES ('Space B');")

    visit '/spaces'
    expect(page).to have_selector('h1', :text => "Maker's B'n'B")
    expect(page).to have_content("Space A")
    expect(page).to have_content("Space B")
  end
end
