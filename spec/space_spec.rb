require 'space'

describe Space do
  describe '#create' do
    it 'creates a new listing for a space' do
      
      if ENV['RACK_ENV'] == 'test'
        conn = PG.connect(dbname: 'makersbnb_test')
      else
        conn = PG.connect(dbname: 'makersbnb')
      end
      
      conn.exec("INSERT INTO spaces (title) VALUES ('Test listing')")

      result = conn.exec('SELECT * FROM spaces')

      spaces = result.map { |space| space['title'] }

      expect(spaces).to include 'Test listing'
    end
  end
end