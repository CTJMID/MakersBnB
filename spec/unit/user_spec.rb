require './lib/user'

describe User do
  describe '#initialize' do
    it 'should return email' do
      user = User.new(email: 'test@test.com')
      expect(user.email).to eq('test@test.com')
    end
  end

  describe '.create' do
    it 'should register a new user' do
      user = User.create(email: 'test@test.com', password: 'Password1234')
      conn = PG.connect(dbname: 'makersbnb_test')
      users = conn.exec('SELECT * FROM users')
      expect(users[0]['email']).to eq('test@test.com')
    end
  end

  describe '.unique?' do
    it 'should check if an email is unique' do
      user = User.create(email: 'test@test.com', password: 'Password1234')
      expect(User.unique?(email: user.email)).to eq false
    end
  end
end
