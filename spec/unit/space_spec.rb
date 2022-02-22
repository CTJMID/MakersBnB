require 'space'

describe Space do
  describe '.all' do
    it 'returns all spaces' do
      conn = PG.connect( dbname: 'makersbnb_test')
      conn.exec("INSERT INTO spaces (title) VALUES ('Space A');")
      conn.exec("INSERT INTO spaces (title) VALUES ('Space B');")
      spaces = Space.all
      expect(spaces[0].title).to eq 'Space A'
      expect(spaces[1].title).to eq 'Space B'
    end
  end

  describe '#initialize' do
    it 'should return instance of a class' do
      space = Space.new(title: 'Space A')
      expect(space.title).to eq 'Space A'
    end
  end
end
