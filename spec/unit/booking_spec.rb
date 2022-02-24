require './lib/booking'

describe Booking do
  describe 'self.create' do
    it 'Creates a new booking if available' do
      space = Space.create('Space A', 'Test Description', 50)
      booking = Booking.create('2022-02-23', '2022-02-25', space.id)
      
      expect(booking.spaces_id).to eq space.id
    end

    it 'Does not create a new booking if unavailable' do
      space = Space.create('Space A', 'Test Description', 50)
      booking = Booking.create('2022-02-23', '2022-02-25', space.id)
      
      expect(Booking.create('2022-02-23', '2022-02-25', space.id)).to eq 'Unavailable'
    end
  end


  describe 'self.booking' do
    it 'Checks if a booking can be made on an empty table' do
      space = Space.create('Space A', 'Test Description', 50)
      
      expect(Booking.available?('2022-02-23', '2022-02-25', space.id)).to be true
    end

    it 'Checks if a booking can be made on particular dates' do
      space = Space.create('Space A', 'Test Description', 50)
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
      space_a = Space.create('Space A', 'Test Description', 50)
      Booking.create('2022-02-23', '2022-02-25', space_a.id)
      space_b = Space.create('Space B', 'Test Description', 50)
      Booking.create('2022-02-26', '2022-02-28', space_b.id)
      
      expect(Booking.all_not_available('2022-02-21', '2022-02-28')).to include space_a.id && space_b.id
    end
  end

  describe 'self.space_dates_not_available' do
    it 'returns an array of dates not available for a specific space' do
      booked_dates = ["10-02-2022", "11-02-2022", "12-02-2022", "20-03-2022", "21-03-2022", "22-03-2022"]
      space_a = Space.create('Space A', 'Test Description', 50)
      Booking.create('2022-02-10', '2022-02-12', space_a.id)
      Booking.create('2022-03-20', '2022-03-22', space_a.id)

      expect(Booking.space_dates_not_available(space_a.id)).to eq booked_dates
    end
  end
end