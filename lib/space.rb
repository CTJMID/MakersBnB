require 'pg'

class Space
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    elsif conn = PG.connect(dbname: 'makersbnb')
    end
    result = conn.exec('SELECT * FROM spaces')
    result.map do |space|
      space['title']
    end
  end
end
