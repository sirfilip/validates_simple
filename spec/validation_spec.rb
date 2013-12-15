require 'validation'

describe Validation do
  let(:validator) { Validation::Validator.new }

  describe "#validates" do
    it "should support inline rule injection" do
      validator.validates('fieldname', lambda {|data| data.has_key?('fieldname')}, ':field cant be blank!')
      validator.validate({'other' => 42}).should_not be_true
      validator.errors['fieldname'].message.should == 'fieldname cant be blank!'
    end
  end

  describe "#validates presence of" do
    it "fails if field is not inside of the hash" do
     validator.validates_presence_of('fieldname', ":field is required")
     validator.validate({'some_other_field' => 'some value'}).should be_false
     validator.should_not be_valid
    end

    it "succeeds if field is inside the hash" do
      validator.validates_presence_of('fieldname', ':field is required')
      validator.validate({'fieldname' => ''}).should be_true
      validator.should be_valid
    end

    it "returns the correct error message" do
      validator.validates_presence_of('fieldname', ":field is required")
      validator.validate({'some_other_field' => 'some value'})
      validator.errors['fieldname'].message.should == 'fieldname is required'
    end
  end

  describe '#validates_confirmation_of' do
    it 'validates true if confirmation is present' do
      validator.validates_confirmation_of('password', 'Password confirmation failed')
      validator.validate({'password' => '123', 'password_confirmation' => '123'}).should be_true
    end 

    it 'validates false if confirmation is different or absent' do
      validator.validates_confirmation_of('password', 'Password confirmation failed')
      validator.validate({'password' => '123', 'password_confirmation' => '1234'}).should be_false
      validator.validate({'password' => '123'}).should be_false
    end
  end

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
