require 'validation' 

describe Validation do

  let(:validator) { Validation::Validator.new }

  describe "validates presence of" do
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

end
