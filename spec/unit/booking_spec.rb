require './lib/booking'

describe Booking do
  describe 'self.create' do
    it 'Creates a new booking if available' do
      space = Space.create('Space A')
      booking = Booking.create('2022-02-23', '2022-02-25', space.id)

      expect(booking.spaces_id).to eq space.id
    end

    it 'Does not create a new booking if unavailable' do
      space = Space.create('Space A')
      booking = Booking.create('2022-02-23', '2022-02-25', space.id)

      expect(Booking.create('2022-02-23', '2022-02-25', space.id)).to eq 'Unavailable'
    end
  end


  describe 'self.booking' do
    it 'Checks if a booking can be made on an empty table' do
      space = Space.create('Space A')
      expect(Booking.available?('2022-02-23', '2022-02-25', space.id)).to be true
    end

    it 'Checks if a booking can be made on particular dates' do
      space = Space.create('Space A')
      Booking.create('2022-02-23', '2022-02-25', space.id)

      expect(Booking.available?('2022-02-20', '2022-02-21', space.id)).to be true
      expect(Booking.available?('2022-02-20', '2022-02-23', space.id)).to be true
      expect(Booking.available?('2022-02-20', '2022-02-24', space.id)).to be false
      expect(Booking.available?('2022-02-23', '2022-02-24', space.id)).to be false
      expect(Booking.available?('2022-02-23', '2022-02-25', space.id)).to be false
      expect(Booking.available?('2022-02-24', '2022-02-25', space.id)).to be false
      expect(Booking.available?('2022-02-24', '2022-02-26', space.id)).to be false
      expect(Booking.available?('2022-02-25', '2022-02-26', space.id)).to be true
      expect(Booking.available?('2022-02-26', '2022-02-27', space.id)).to be true
      expect(Booking.available?('2022-02-20', '2022-02-27', space.id)).to be false
    end
  end

  describe 'self.all_available' do
    it 'should return all current available spaces' do
      space_a = Space.create('Space A')
      Booking.create('2022-02-23', '2022-02-25', space_a.id)
      space_b = Space.create('Space B')
      Booking.create('2022-02-26', '2022-02-28', space_b.id)

      expect(Booking.not_available('2022-02-21', '2022-02-28')).to include space_a.id && space_b.id
    end

  end
end