require './lib/user'

describe User do
  describe '#initialize' do
    it 'should return email' do
      user = User.new(id: '1', email: 'test@test.com', password: 'Password1234')
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

  describe '.authenticate' do
    it 'returns a user who has enetered correct combo of email & password' do
      user = User.create(email: 'test@test.com', password: 'Password1234')
      auth_user = User.authenticate(email:'test@test.com', password: 'Password1234')
      expect(auth_user.id).to eq(user.id)
    end

    it 'returns nil given an email address not in database' do
      user = User.create(email: 'test@test.com', password: 'Password1234')
      expect(User.authenticate(email: 'wrongemail@notindb.com', password: 'Password1234')).to be_nil   
    end
  end
end
