
require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('Callboard') }
    it { should have_title("Callboard") }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title("Callboard | Help") }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title("Callboard | About Us") }
  end

  describe "browse ads" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:post, user: user, content: "Foo") }
    let!(:p2) { FactoryGirl.create(:post, user: user, content: "Bar") }

    before { visit root_path }

    it { should have_content(p1.content) }
    it { should have_content(p2.content) }
  end
end
