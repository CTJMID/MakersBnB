require 'PG'

class Space

  def self.create(title)

    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    conn.exec("INSERT INTO spaces (title) VALUES ('#{title}')")

  end

end



