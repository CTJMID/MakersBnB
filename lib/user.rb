require 'pg'
require_relative './conn'

class User
  attr_reader :email

  def initialize(email:)
    @email = email
  end

  def self.unique?(email:)
    result = Conn.query("SELECT * FROM users WHERE email = '#{email}'")

    result.ntuples.zero? ? true : false

  end

  def self.create(email:, password:)
    result = Conn.query("INSERT INTO users (email, password) VALUES ($1, $2) RETURNING email;",
                              [email, password])     
    User.new(email: result[0]['email'])
  end
end
