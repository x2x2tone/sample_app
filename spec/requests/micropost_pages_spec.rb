require 'spec_helper'

describe "MicropostPages" do

  subject { page }
  describe "signed-in-user" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "micropost creation" do
      before { visit root_path }

      describe "with valid information" do
        before { fill_in "micropost_content",   with: "I am a Japanese." }
        it "should create a micropost" do
          expect { click_button "Post" }.to change(Micropost, :count).by(1)
        end

        describe "after submission" do
          before { click_button "Post" }
          it { should have_selector('title', text: full_title('')) }
          it { should have_selector('div.alert.alert-success', text: 'posted')}
        end

      end

      describe "with invalid information" do
        it "should create a micropost" do
          expect { click_button "Post"}.not_to change(Micropost, :count).by(1)
        end

        describe "after submission" do
          before { click_button "Post" }
          it { should have_selector('title', text: full_title('')) }
          it { should have_content('error') }
        end
      end
    end

    describe "micropost destruction" do
      before { FactoryGirl.create(:micropost, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a micropost" do
          expect { click_link "delete" }.to change(Micropost, :count).by(-1)
        end
      end
    end

  end
end
