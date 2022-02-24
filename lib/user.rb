require 'pg'
require_relative './conn'
require 'bcrypt'

class User
  attr_reader :email, :id

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  def self.unique?(email:)
    result = Conn.query("SELECT * FROM users WHERE email = '#{email}'")

    result.ntuples.zero? ? true : false

  end

  def self.create(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = Conn.query("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email;",
                              [email, encrypted_password])     
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    result = Conn.query("SELECT * FROM users WHERE email = $1", [email])
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    user = User.new(id: result[0]['id'], email: result[0]['email'])
  end
end

