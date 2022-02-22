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
      space = Space.new(id: 1, title: 'Space A', available: true)
      expect(space.title).to eq 'Space A'
    end
  end

  describe '.book' do
    it 'should default to be available by returning true' do
      space = Space.create('Space A')
      
      expect(space.available).to be true
    end
    
    it 'should update availiblity to false' do
      space = Space.create('Space A')
      id = space.id
      Space.book(id)

      conn = PG.connect(dbname: 'makersbnb_test')
      result = conn.exec('SELECT * FROM spaces')
      spaces = result.map { |space| space['available'] }

      expect(spaces).to include 'f'
    end
  end
end


