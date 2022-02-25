require_relative './conn'

class Booking

  attr_reader :id, :start_date, :end_date, :spaces_id

  def initialize(id:, start_date:, end_date:, spaces_id:)
    @id = id 
    @start_date = start_date
    @end_date = end_date
    @spaces_id = spaces_id
  end

  def self.available?(start_date, end_date, spaces_id)
    result = Conn.query(
      "SELECT * FROM bookings
      WHERE spaces_id = #{spaces_id}
      AND (DATE('#{start_date}') >= start_date AND DATE('#{start_date}') < end_date)
      OR (DATE('#{end_date}') > start_date AND DATE('#{end_date}') <= end_date)
      OR (DATE('#{start_date}') <= start_date AND DATE('#{end_date}') >= end_date);"
    )

    if result.ntuples.zero?
      true
    else
      false
    end
  end

  def self.all_not_available(start_date, end_date)
    result = Conn.query(
      "SELECT * FROM bookings
      WHERE (DATE('#{start_date}') >= start_date AND DATE('#{start_date}') < end_date)
      OR (DATE('#{end_date}') > start_date AND DATE('#{end_date}') <= end_date)
      OR (DATE('#{start_date}') <= start_date AND DATE('#{end_date}') >= end_date) ;"
    )

    ids = result.map do |spaces| 
      spaces['spaces_id']
    end

    ids.join(", ")
  end

  def self.space_dates_not_available(spaces_id)
    booked_dates = []

    result = Conn.query("SELECT * FROM bookings WHERE spaces_id='#{spaces_id}';")

    bookings = result.map do |booking|
      Booking.new(id: booking['id'], start_date: booking['start_date'], end_date: booking['end_date'], spaces_id: booking['spaces_id'])
    end

    bookings.each do |booking|
      (booking.start_date..booking.end_date).each do |date|
        formatted_date = DateTime.parse(date).strftime('%d-%m-%Y')
        booked_dates << formatted_date
      end
    end

    return booked_dates
  end

  def self.create(start_date, end_date, spaces_id)
    if Booking.available?(start_date, end_date, spaces_id)
      result = Conn.query("INSERT INTO bookings (start_date, end_date, spaces_id) VALUES ('#{start_date}', '#{end_date}', '#{spaces_id}') RETURNING id, start_date, end_date, spaces_id;")

      Booking.new(id: result[0]['id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], spaces_id: result[0]['spaces_id'])
    else
      return 'Unavailable'
    end
  end
end