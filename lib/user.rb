require 'pg'
require_relative './conn'

class User
  attr_reader :email, :id, :password

  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password = password
  end

  def self.unique?(email:)
    result = Conn.query("SELECT * FROM users WHERE email = '#{email}'")

    result.ntuples.zero? ? true : false

  end

  def self.create(email:, password:)
    result = Conn.query("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email, password;",
                              [email, password])     
    User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.authenticate(email:, password:)
    result = Conn.query("SELECT * FROM users WHERE email = $1", [email])
    user = User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password'])
  end
end
