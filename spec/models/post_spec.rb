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

  describe "comment associations" do
    let(:p1) { FactoryGirl.create(:post, user: user) }

    let!(:older_comment) do
      FactoryGirl.create(:comment, post: p1, user: user, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, post: p1, user: user, created_at: 1.hour.ago)
    end

    it "should have the right comments in the right order" do
      expect(p1.comments.to_a).to eq [older_comment, newer_comment]
    end

    it "should destroy associated comments" do
      comments = p1.comments.to_a
      p1.destroy
      expect(comments).not_to be_empty
      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end

end
