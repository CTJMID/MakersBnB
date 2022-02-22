require 'pg'

class User 

    attr_reader :email

    def initialize(email:)
        @email = email
    end

    def self.create(email:, password:)
        if ENV['RACK_ENV'] == 'test'
            conn = PG.connect(dbname: 'makersbnb_test')
        else
            conn = PG.connect(dbname: 'makersbnb')
        end
    result = conn.exec("INSERT INTO users (email, password) VALUES ('#{email}', '#{password}') RETURNING email;")
    User.new(email: result[0]['email'])
    end
end 