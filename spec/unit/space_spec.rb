require 'space'

describe Space do
  describe '.all' do
    it 'returns all spaces' do
      Space.create('Space A', 'Test description A', 30)
      Space.create('Space B', 'Test description B', 50)
      spaces = Space.all
      expect(spaces[0].title).to eq 'Space A'
      expect(spaces[1].title).to eq 'Space B'
      expect(spaces[0].description).to eq 'Test description A'
      expect(spaces[1].description).to eq 'Test description B'
      expect(spaces[0].price).to eq '30.00'
      expect(spaces[1].price).to eq '50.00'
    end
  end

  describe '#create' do
    it 'creates a new listing for a space' do
      Space.create('Test listing', 'Test description', 50)
      spaces = Space.all
     
      expect(spaces.first.title).to include 'Test listing'
      expect(spaces.first.description).to include 'Test description'
      expect(spaces.first.price).to include '50.00'
    end
  end

  describe '#initialize' do
    it 'should return instance of a class' do
      space = Space.new(id: 1, title: 'Space A', available: true, description: 'Test description', price: 50)
      expect(space.title).to eq 'Space A'
      expect(space.description).to eq 'Test description'
      expect(space.price).to eq 50
    end
  end

  describe '.book' do
    it 'should default to be available by returning true' do
      space = Space.create('Space A', 'Test description', 50)
      
      expect(space.available).to be true
    end
    
    it 'should update availiblity to false' do
      space = Space.create('Space A', 'Test description', 50)
      id = space.id
      Space.book(id)
      spaces = Space.all

      expect(spaces.first.available).to be false
    end
  end
end


