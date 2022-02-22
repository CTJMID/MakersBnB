require 'space'

describe Space do
  describe '.all' do
    it 'returns all spaces' do
      conn = PG.connect(dbname: 'makersbnb_test')
      conn.exec("INSERT INTO spaces (title) VALUES ('Space A');")
      conn.exec("INSERT INTO spaces (title) VALUES ('Space B');")
      spaces = Space.all
      expect(spaces[0].title).to eq 'Space A'
      expect(spaces[1].title).to eq 'Space B'
    end
  end

  describe '#create' do
    it 'creates a new listing for a space' do
      if ENV['RACK_ENV'] == 'test'
        conn = PG.connect(dbname: 'makersbnb_test')
      else
        conn = PG.connect(dbname: 'makersbnb')
      end
      conn.exec("INSERT INTO spaces (title) VALUES ('Test listing')")
      result = conn.exec('SELECT * FROM spaces')
      spaces = result.map { |space| space['title'] }
      expect(spaces).to include 'Test listing'
    end
  end

  describe '#initialize' do
    it 'should return instance of a class' do
      space = Space.new(title: 'Space A')
      expect(space.title).to eq 'Space A'
    end
  end
end
