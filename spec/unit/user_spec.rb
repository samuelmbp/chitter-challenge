require './app/models/user'
require 'database_helper'

describe User do

  context '#create' do
    it 'creates a new users' do
      user = User.create(
        name: 'Samuel',
        username: 'samuelmbp',
        email: 'sam@example.com',
        password: 'test1234'
      )

      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.name).to eq 'Samuel'
      expect(user.username).to eq 'samuelmbp'
      expect(user.email).to eq 'sam@example.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('test1234')

      User.create(
        name: 'samuel', 
        username: 'samuelmbp', 
        email: 'sam@example.com', 
        password: 'test1234'
      )
    end
  end

  context '#find' do
    it 'finds a user by id' do 
      user = User.create(
        name: 'Samuel',
        username: 'samuelmbp',
        email: 'sam@example.com',
        password: 'test1234'
      )
      result = User.find(id: user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end

    it 'returns nil when id is not given' do
      expect(User.find(nil)).to eq nil
    end
  end

  context '#authenticate' do
    it 'returns a user when email and password are correct' do
      user = User.create(
        name: 'Samuel',
        username: 'samuelmbp',
        email: 'sam@example.com',
        password: 'test1234'
      )

      authenticated_user = User.authenticate(email: 'sam@example.com', password: 'test1234')

      expect(authenticated_user.id).to eq user.id
    end
  end
end