require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "post creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'post_content', with: "Lorem ipsum" }
      it "should create a post" do
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
    end
  end

  describe "post destruction" do
    before { FactoryGirl.create(:post, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
  end

  describe "post edit" do
    let(:p1) { FactoryGirl.create(:post, user: user) }
    before { visit edit_post_path(p1) }

    describe "with valid information" do
      let(:updated_content) { "Test content" }
      before do
        fill_in 'Content', with: updated_content
        click_button "Save changes"
      end
      it { should have_selector('div.alert.alert-success') }

      it { should have_content('Test content') }
    end
  end

  describe "post page" do
    let(:p1) { FactoryGirl.create(:post, user: user) }
    let!(:c1) { FactoryGirl.create(:comment, post: p1, user: user, content: "Foo") }
    let!(:c2) { FactoryGirl.create(:comment, post: p1, user: user, content: "Bar") }

    before { visit post_path(p1) }

    it { should have_content(user.name) }

    describe "comments" do
      it { should have_content(c1.content) }
      it { should have_content(c2.content) }
      it { should have_content(p1.comments.count) }
    end
  end


end
