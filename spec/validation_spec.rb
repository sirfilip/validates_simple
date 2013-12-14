require 'validation'

describe Validation do
  let(:validator) { Validation::Validator.new }

  describe 'a simple sample of successfull validation' do
    it "validates successfully" do
      validator.validates_presence_of('username', 'Username is required')
      validator.validates_presence_of('email', 'Email is required')
      validator.validates_presence_of('password', 'Password is required')
      validator.validates_confirmation_of('password', 'Password is not confirmed')
      validator.validate({'username' => 'username', 'email' => 'email', 'password' => 123, 'password_confirmation' => 123}).should be_true
    end
  end
end
