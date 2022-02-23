require 'space'

describe Space do
  describe '.all' do
    it 'returns all spaces' do
      Space.create('Space A')
      Space.create('Space B')
      spaces = Space.all
      expect(spaces[0].title).to eq 'Space A'
      expect(spaces[1].title).to eq 'Space B'
    end
  end

  describe '#create' do
    it 'creates a new listing for a space' do
      Space.create('Test listing')
      spaces = Space.all
      #spaces = result.map { |space| space['title'] }
      expect(spaces.first.title).to include 'Test listing'
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
      spaces = Space.all

      expect(spaces.first.available).to be false
    end
  end
end


