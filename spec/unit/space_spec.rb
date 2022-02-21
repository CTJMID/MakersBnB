require 'space'
require 'pg'

describe Space do
  describe '.all' do
    it 'returns all spaces' do
      conn = PG.connect( dbname: 'makersbnb_test')
      conn.exec("INSERT INTO spaces (title) VALUES ('Space A');")
      conn.exec("INSERT INTO spaces (title) VALUES ('Space B');")
      spaces = Space.all
      expect(spaces).to include 'Space A'
      expect(spaces).to include 'Space B'
    end
  end
end
