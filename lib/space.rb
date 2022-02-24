require_relative './conn'

class Space
  attr_reader :id, :title, :description, :price

  def initialize(id:, title:, description:, price:)
    @id = id
    @title = title
    @description = description
    @price = price
  end

  def self.all
    result = Conn.query('SELECT * FROM spaces')
    result.map do |space|
      Space.new(id: space['id'], title: space['title'], description: space['description'], price: (space['price']).to_f.round(2))
    end
  end

  def self.create(title, description, price)
    result = Conn.query("INSERT INTO spaces (title, description, price) VALUES ('#{title}', '#{description}', '#{price}') RETURNING id, title, description, price;")
    Space.new(id: result[0]['id'], title: result[0]['title'], description: result[0]['description'], price: (result[0]['price']).to_f)
  end
  
  def self.selection(start_date, end_date)
    ids_not_available = Booking.not_available(start_date, end_date)

    if ids_not_available.empty?
      Space.all
    else
      result = Conn.query("SELECT * FROM spaces WHERE NOT id IN (#{ids_not_available})")
      result.map do |space|
        Space.new(id: space['id'], title: space['title'], description: space['description'], price: (space['price']).to_f.round(2))
      end
    end
  end

  def self.book(available_from, available_to, id)
    Booking.create(available_from, available_to, id)
  end

end