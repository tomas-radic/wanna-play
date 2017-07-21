class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create 	:notify_create, 	if: Proc.new { Rails.env.eql?(:production) }
  after_destroy	:notify_destroy,	if: Proc.new { Rails.env.eql?(:production) }

	# Validations
	validates :name, :email, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	# Relations
	has_many :availabilities, dependent: :destroy


	private

	def notify_create
		UserMailer.user_created(self).deliver_now
	end

	def notify_destroy
		UserMailer.user_destroyed(self).deliver_now
	end
end
