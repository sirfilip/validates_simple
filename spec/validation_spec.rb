require 'validates_simple'

describe Validation do
  let(:validator) { Validation::Validator.new }

  describe "#validates" do
    it "should support inline rule injection" do
      validator.validates('fieldname', lambda {|data| data.has_key?('fieldname')}, ':field cant be blank!')
      validator.validate({'other' => 42}).should_not be_true
      validator.errors['fieldname'].message.should == 'fieldname cant be blank!'
    end
  end

  describe '#validates_presence_of_field' do 
    it 'checks if the field is present regardless of the value' do
      validator.validates_presence_of_field('a field')
      validator.validate({'a field' => false}).should be_true
      validator.validate({'a field' => nil}).should be_true
      validator.validate({'a field' => ''}).should be_true
      validator.validate({'another field' => false}).should be_false
    end
  end

  describe "#validates presence of" do
    it "fails if field is not inside of the hash" do
     validator.validates_presence_of('fieldname', ":field is required")
     validator.validate({'some_other_field' => 'some value'}).should be_false
     validator.should_not be_valid
    end

    it "succeeds if field is inside the hash and it is a non blank string or nil" do
      validator.validates_presence_of('fieldname', ':field is required')
      validator.validate({'fieldname' => 'someval'}).should be_true
      validator.validate({'fieldname' => 123}).should be_true
      validator.validate({'fieldname' => nil}).should be_false
      validator.validate({'fieldname' => ''}).should be_false
      validator.validate({'fieldname' => ' '}).should be_false
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
      validator.validate({'somefield' => 'other'}).should be_false
      validator.validate({'password' => '123', 'password_confirmation' => '1234'}).should be_false
      validator.validate({'password' => '123'}).should be_false
    end
  end

  describe '#validates_format_of' do
    it "ensures that the field is in the right format" do
      validator.validates_format_of('email', /.+@.+\.(com|org|net)/, ':field is not in the right format')
      validator.validate({'email' => 'someemail@example.com'}).should be_true
      validator.validate({'email' => 'someemail'}).should be_false
    end
  end

  describe '#validates_numericality_of' do 
    it 'ensures that the field is a number' do 
      validator.validates_numericality_of('age', 'Age must be a number')
      validator.validate({'age' => '2323'}).should be_true
      validator.validate({'age' => '1223asdasd'}).should be_false
      validator.validate({'something' => 'otherthing'}).should be_false
    end
  end

  describe '#validates_greather_then' do 
    it "checks if the field is greather then some number" do
      validator.validates_greather_then('age', 18, 'Age must be greather then 18')
      validator.validate({'age' => 19}).should be_true
      validator.validate({'age' => 18}).should be_false
      validator.validate({'age' => 17}).should be_false
    end
  end

  describe '#validates_greather_or_equal_then' do 
    it "checks if the field is greather or equal then some number" do
      validator.validates_greather_or_equal_then('age', 18, 'Age must be greather or equal then 18')
      validator.validate({'age' => 19}).should be_true
      validator.validate({'age' => 18}).should be_true
      validator.validate({'age' => 17}).should be_false
    end
  end

  describe '#validates_less_then' do 
    it "checks if the field is less then some number" do
      validator.validates_less_then('age', 18, 'Age must be under 18')
      validator.validate({'age' => 17}).should be_true
      validator.validate({'age' => 18}).should be_false
      validator.validate({'age' => 19}).should be_false
    end
  end

  describe '#validates_less_or_equal_then' do 
    it "checks if the field is less or equal then some number" do
      validator.validates_less_or_equal_then('age', 18, 'Age must be under 18')
      validator.validate({'age' => 17}).should be_true
      validator.validate({'age' => 18}).should be_true
      validator.validate({'age' => 19}).should be_false
    end
  end

  describe '#validates_lenght_of_within' do
    it 'checks if the length is within some bounderies' do
      validator.validates_length_of_within('username', 3, 10, 'Length should be between 3 and 10 chars')
      validator.validate({'username' => 'u' * 3}).should be_true
      validator.validate({'username' => 'u' * 5}).should be_true
      validator.validate({'username' => 'u' * 10}).should be_true
      validator.validate({'username' => 'u'}).should be_false
      validator.validate({'username' => 'u' * 11}).should be_false
      validator.validate({'nousername' => true}).should be_false
    end
  end

  describe '#validates_option_in' do
    it 'checks if the option is one of the predefined' do
      validator.validates_option_in('subscription', ['basic', 'premium'], 'Subscription must be basic or premium')
      validator.validate({'subscription' => 'basic'}).should be_true
      validator.validate({'subscription' => 'other'}).should be_false
      validator.validate({'other-field' => 42}).should be_false
    end
  end

  describe '#validates_url_format_of' do
    it 'checks if the url is in a correct format' do
      validator.validates_url_format_of('url', 'Url format is not allowed')
      validator.validate({'url' => 'http://google.com'}).should be_true
      validator.validate({'url' => 'f:||asdsdfsadf'}).should be_false
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
