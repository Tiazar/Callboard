require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(content: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { expect(subject.user).to eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @post.content = "a" * 1801 }
    it { should_not be_valid }
  end
end
