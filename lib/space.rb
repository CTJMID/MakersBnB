require 'PG'

class Space

  def self.create(title)

    conn = PG.connect(dbname: 'makersbnb_test')

    conn.exec("INSERT INTO spaces (title) VALUES ('#{title}')")

  end

end



