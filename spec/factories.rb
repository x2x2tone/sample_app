FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person_#{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :micropost do
		content "Example Post"
		user
	end
end
