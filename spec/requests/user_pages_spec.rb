require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', 	text: 'Sign up') }
		it { should have_selector('title', 	text: full_title('Sign up')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }

		before { visit user_path(user) }

		it { should have_selector('h1', 	text: user.name) }
		it { should have_selector('title', 	text: user.name) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
		end

		describe "after submission" do
			before { click_button submit }

			it {should have_selector('title', text: 'Sign up') }
			it {should have_content('error')}
			it {should_not have_content('Password digest')}
		end
	end

	describe "with valid information" do

		before do
			fill_in "Name", 		with: "bjorn"
			fill_in "email", 		with: "bjornoo1@hotmail.com"
			fill_in "password",		with: "nrojb4"
			fill_in "confirmation",	with: "nrojb4"
		end

		it "should create a user" do
			expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving a user" do

        	before { click_button submit }

        	let(:user) { User.find_by_email("bjornoo1@hotmail.com") }

        	it { should have_selector('title', text: user.name) }
        	it { should have_selector('div.alert.alert-succes', text: 'Welcome') }
        end
      end
    end
  end

