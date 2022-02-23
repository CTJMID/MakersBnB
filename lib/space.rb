require 'pg'
require 'conn'

class Space
  attr_reader :id, :title, :available, :description

  def initialize(id:, title:, available:, description:)
    @id = id
    @title = title
      if available == 't'
        @available = true
      else
        @available = false
      end
    @description = description
  end

  def self.all
    result = Conn.query('SELECT * FROM spaces')
    result.map do |space|
      Space.new(id: space['id'], title: space['title'], available: space['available'], description: space['description'])
    end
  end

  def self.create(title, description)
    result = Conn.query("INSERT INTO spaces (title, description) VALUES ('#{title}', '#{description}') RETURNING id, title, available, description;")
    Space.new(id: result[0]['id'], title: result[0]['title'], available: result[0]['available'], description: result[0]['description'])
  end

  def self.book(id)
    Conn.query("UPDATE spaces SET available = FALSE WHERE id=' #{id} ';")
  end

end