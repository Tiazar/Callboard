require 'spec_helper'

describe User do

  before { @user = User.new(login: "User1" ,
  							full_name:"Example User",
  							email: "user@example.com",
  							birthday: "30.05.2000",
  							address: "Example street, 20",
  							city:"Example city",
  							state:"Example State",
  							country:"Example Country",
  							zip:"123456",
  							password: "foobar",
  							password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:login) }
  it { should respond_to(:email) }
  it { should respond_to(:full_name) }
  it { should respond_to(:birthday) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:country) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  

  it { should be_valid }

  describe "when login is not present" do
    before { @user.login = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when login is too long" do
    before { @user.login = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before do
      @user = User.new(login: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "when full_name is not present" do
    before { @user.full_name = " " }
    it { should_not be_valid }
  end

  describe "when full_name is too long" do
    before { @user.full_name = "a" * 201 }
    it { should_not be_valid }
  end

  describe "when birthday is not present" do
    before { @user.birthday = " " }
    it { should_not be_valid }
  end

  describe "when birthday date is wrong" do
    before { @user.birthday = "32.05.200" }
    it { should_not be_valid }
  end

  describe "when address is not pesent" do
  	before { @user.address = " "}
  	it { should_not be_valid}
  end	

  describe "when city is not pesent" do
  	before { @user.city = " "}
  	it { should_not be_valid}
  end

  describe "when city name is too long" do
    before { @user.city = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when state is not pesent" do
  	before { @user.state = " "}
  	it { should_not be_valid}
  end

  describe "when country is not pesent" do
  	before { @user.country = " "}
  	it { should_not be_valid}
  end

  describe "when zip is not pesent" do
  	before { @user.zip = " "}
  	it { should_not be_valid}
  end

  describe "when zip name is too long" do
    before { @user.zip = "1" * 7 }
    it { should_not be_valid }
  end
end