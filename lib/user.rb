require 'pg'

class User
  attr_reader :email

  def initialize(email:)
    @email = email
  end

  def self.unique?(email:)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    result = conn.exec("SELECT * FROM users WHERE email = '#{email}'")

    if result.ntuples.zero?
      true
    else
      false
    end

  end

  def self.create(email:, password:)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'makersbnb_test')
    else
      conn = PG.connect(dbname: 'makersbnb')
    end

    
    result = conn.exec_params("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING email;",
                              [email, password])     
    User.new(email: result[0]['email'])
  end
end
