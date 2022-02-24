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
      expect(spaces[0].price).to eq 30.00
      expect(spaces[1].price).to eq 50.00
    end
  end

  describe '#create' do
    it 'creates a new listing for a space' do
      Space.create('Test listing', 'Test description', 50)
      spaces = Space.all
     
      expect(spaces.first.title).to eq 'Test listing'
      expect(spaces.first.description).to eq 'Test description'
      expect(spaces.first.price).to eq 50.00
    end
  end

  describe '#initialize' do
    it 'should return instance of a class' do
      space = Space.new(id: 1, title: 'Space A', description: 'Test description', price: 50)
      expect(space.title).to eq 'Space A'
      expect(space.description).to eq 'Test description'
      expect(space.price).to eq 50
    end
  end

  describe '.book' do
    it 'should make a booking' do
      space_a = Space.create('Space A', 'Test description', 50)
      booking = Space.book('2022-02-23', '2022-02-25', space_a.id)
      result = Conn.query("SELECT * FROM bookings WHERE id = #{booking.id}")

      expect(result.first['spaces_id']).to eq space_a.id
      expect(result.first['id']).to eq booking.id
    end
  end

  describe '.selection' do
    it 'Only returns availble spaces based on specific dates' do
      space_a = Space.create('Space A', 'Test description', 50)
      space_b = Space.create('Space B', 'Test description', 50)
      Booking.create('2022-02-23', '2022-02-25', space_a.id)
      Booking.create('2022-02-27', '2022-02-28', space_b.id)

      selection = Space.selection('2022-02-23', '2022-02-25')

      expect(selection.first.title).to eq space_b.title
    end
  end
end


