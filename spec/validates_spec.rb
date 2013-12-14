require 'validation'


describe Validation::Validator do
  let(:validator) { Validation::Validator.new }

  describe "#validates" do
    it "should support inline rule injection" do
      validator.validates('fieldname', lambda {|data| data.has_key?('fieldname')}, ':field cant be blank!')
      validator.validate({'other' => 42}).should_not be_true
      validator.errors['fieldname'].message.should == 'fieldname cant be blank!'
    end
  end
end
