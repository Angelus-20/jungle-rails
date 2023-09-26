require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # Example 1: User must be created with password and password_confirmation fields
    it 'requires matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password123' # Mismatched confirmation
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # Example 2: Password and password_confirmation fields are required
    it 'requires password and password_confirmation to be present' do
      user = User.new(
        email: 'test@example.com',
        password: nil,
        password_confirmation: nil
      )
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    # Example 3: Emails must be unique (case-insensitive)
    it 'requires a unique email address' do
      user = User.create!(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      user2 = User.new(
        email: 'TEST@example.com', # Case-insensitive duplicate
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    # Example 4: Email, first name, and last name should be required
    it 'requires email, first name, and last name to be present' do
      user = User.new(
        email: nil,
        first_name: nil,
        last_name: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
      expect(user.errors.full_messages).to include("First name can't be blank")
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'requires a minimum password length' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'short', # Password is too short (below minimum length)
        password_confirmation: 'short'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    describe '.authenticate_with_credentials' do
      it 'authenticates a user with valid credentials' do
        user = User.create!(
          email: 'test@example.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password'
        )
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    
      it 'does not authenticate a user with invalid credentials' do
        user1 = User.create!(
          email: 'test@example.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password'
        )
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
        expect(authenticated_user).to be_nil
      end
      it 'requires a minimum password length' do
        user = User.new(
          email: 'test@example.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'short', # Password is too short (below minimum length)
          password_confirmation: 'short'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end
  
    describe '.authenticate_with_credentials' do
      it 'authenticates with leading and trailing spaces in email' do
        user = User.create!(
          email: 'example@domain.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password'
        )
        authenticated_user = User.authenticate_with_credentials(' example@domain.com ', 'password')
        expect(authenticated_user).to eq(user)
      end
  
      it 'authenticates with different case in email' do
        user = User.create!(
          email: 'example@domain.com',
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password'
        )
        authenticated_user = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', 'password')
        expect(authenticated_user).to eq(user)
      end
    end
  end
end