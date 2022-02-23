require 'conn'

class Space
  attr_reader :id, :title, :available

  def initialize(id:, title:, available:)
    @id = id
    @title = title
      if available == 't'
        @available = true
      else
        @available = false
      end
  end

  def self.all
    result = Conn.query('SELECT * FROM spaces')
    result.map do |space|
      Space.new(id: space['id'], title: space['title'], available: space['available'] )
    end
  end

  def self.create(title)
    result = Conn.query("INSERT INTO spaces (title) VALUES ('#{title}') RETURNING id, title, available;")
    Space.new(id: result[0]['id'], title: result[0]['title'], available: result[0]['available'])
  end

  def self.book(id)
    Conn.query("UPDATE spaces SET available = FALSE WHERE id=' #{id} ';")
  end

end