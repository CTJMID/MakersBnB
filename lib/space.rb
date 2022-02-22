require 'pg'

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
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else 
      conn = PG.connect(dbname: 'makersbnb')
    end

    result = conn.exec('SELECT * FROM spaces')
    result.map do |space|
      Space.new(id: space['id'], title: space['title'], available: space['available'] )
    end
  end

  def self.create(title)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    result = conn.exec("INSERT INTO spaces (title) VALUES ('#{title}') RETURNING id, title, available;")
    Space.new(id: result[0]['id'], title: result[0]['title'], available: result[0]['available'])
  end

  def self.book(id)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else 
      conn = PG.connect(dbname: 'makersbnb')
    end
    conn.exec("UPDATE spaces SET available = FALSE WHERE id=' #{id} ';")
  end

  def self.connection
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else 
      conn = PG.connect(dbname: 'makersbnb')
    end
  end

end

















# conn = PG.connect(dbname: 'makersbnb_test')
#       conn.exec("INSERT INTO spaces (title) VALUES ('Space A');")
#       conn.exec("UPDATE spaces SET available = FALSE WHERE title='Space A';")
#       result = conn.exec('SELECT * FROM spaces')
#       spaces = result.map { |space| space['available'] }