require './lib/booking'

describe Booking do
  describe 'self.create' do
    it 'Creates a new booking if available' do
      space = Space.create('Space A')
      booking = Booking.create('2022-02-23', '2022-02-25', space.id)

      expect(booking.spaces_id).to eq space.id
      
    end
  end


  # describe 'self.booking' do
  #   it 'Checks if a booking can be made on particular dates' do
  #     space = Space.create('Space A')

  #     Booking.create('2022-02-23', '2022-02-25', space.id)

  #     expect(Booking.available?('2022-02-23', '2022-02-25')).to be true
  #   end
  # end
end