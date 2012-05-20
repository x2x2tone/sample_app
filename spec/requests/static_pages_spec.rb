require 'spec_helper'

describe "StaticPages" do
#  before do
#		Capybara.app_host = "http://localhost:3000"
#	end

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	describe "Home page" do
    it "should have the content 'Sample App'" do
      visit root_path
			page.should have_selector('h1', :text => 'Sample App')
    end

		it "should have the base title" do
			visit root_path
			page.should have_selector('title', 
			                     :text => "Ruby on Rails Tutorial Sample App")
		end
		
		it "should not have a custom page title" do
			visit root_path
			page.should_not have_selector('title', :text => "| Home")
		end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
			page.should have_selector('h1', :text => 'Help')
    end

		it "should have the right title" do
			visit help_path
			page.should have_selector('title', :text => "#{base_title} | Help")
		end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path
			page.should have_selector('h1', :text => 'About Us')
    end
		it "should have the right title" do
			visit about_path
			page.should have_selector('title', :text => "#{base_title} | About")
		end
  end

  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
			page.should have_selector('h1', :text => 'Contact')
    end
		it "should have the right title" do
			visit contact_path
			page.should have_selector('title', :text => "#{base_title} | Contact")
		end
  end
end
