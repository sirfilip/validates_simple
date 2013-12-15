require 'validation'

describe Validation do
  let(:validator) { Validation::Validator.new }
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
end
