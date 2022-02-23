require_relative './conn'

class Space
  attr_reader :id, :title, :available, :description, :price

  def initialize(id:, title:, available:, description:, price:)
    @id = id
    @title = title
      if available == 't'
        @available = true
      else
        @available = false
      end
    @description = description
    @price = price
  end

  def self.all
    result = Conn.query('SELECT * FROM spaces')
    result.map do |space|
      Space.new(id: space['id'], title: space['title'], available: space['available'], description: space['description'], price: (space['price']).to_f.round(2))
    end
  end

  def self.create(title, description, price)
    result = Conn.query("INSERT INTO spaces (title, description, price) VALUES ('#{title}', '#{description}', '#{price}') RETURNING id, title, available, description, price;")
    Space.new(id: result[0]['id'], title: result[0]['title'], available: result[0]['available'], description: result[0]['description'], price: (result[0]['price']).to_f)
  end
  
  # def self.selection(start_date, end_date)
  #   all_available = []
  #   ids = Booking.not_available(start_date, end_date)
  #   ids.each { |id|
  #     result = Conn.query(
  #       "SELECT * FROM spaces
  #       WHERE ID NOT #{id};"
  #     )
  #     all_available << result
  #   }
  # end

  def self.book(id)
    Conn.query("UPDATE spaces SET available = FALSE WHERE id=' #{id} ';")
  end

end