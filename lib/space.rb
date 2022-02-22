require 'pg'

class Space
  attr_reader :title

  def initialize(title:)
    @title = title
  end

  def self.all
    conn = self.connection
    result = conn.exec('SELECT * FROM spaces')
    result.map do |space|
      Space.new(title: space['title'])
    end
  end

  def self.create(title)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    conn.exec("INSERT INTO spaces (title) VALUES ('#{title}')")
  end

  def self.connection
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else conn = PG.connect(dbname: 'makersbnb')
    end
  end
end
