class Micropost < ActiveRecord::Base
  attr_accessible :content
	belongs_to :user

	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	default_scope order: "microposts.created_at DESC"

	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships
		                     WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
		       user_id: user.id )

		#2 followed_user_ids = user.followed_user_ids
		#2  where("user_id IN (:followed_user_ids) OR user_id = :user_id", 
		#2        followed_user_ids: followed_user_ids, user_id: user)
		
		#1 where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
	end
end
