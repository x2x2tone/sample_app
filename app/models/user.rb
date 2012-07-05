# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
	has_secure_password
	has_many :microposts , dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
	                                 class_name: "Relationship",
	                                 dependent: :destroy
	has_many :followers, through: :reverse_relationships
	#--- followersの単数形がfollowになるため、followerと関連付く
	#--- よって、source: :follower　は不要

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

	def feed
		Micropost.where("user_id = ?", id)
	end

	def following?(other_user)
		#followed_users.include?(other_user.id)
		relationships.find_by_followed_id(other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by_followed_id(other_user.id).destroy
	end

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
