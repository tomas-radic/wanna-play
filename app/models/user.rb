class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # after_create 	:notify_create, 	if: Proc.new { Rails.env.eql?('development') }
  # after_destroy	:notify_destroy,	if: Proc.new { Rails.env.eql?('development') }

	# Validations
	validates :name, :email, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	# Relations
	has_many :availabilities, dependent: :destroy

	# Callbacks
	before_validation :strip_whitespaces


	private

	def strip_whitespaces
		self.email.strip!
		self.name.strip!
		self.phone_number.strip!
	end

	def notify_create
		MailHelper.user_created(self)
		# UserMailer.user_created(self).deliver_now
	end

	def notify_destroy
		MailHelper.user_destroyed(self)
		# UserMailer.user_destroyed(self).deliver_now
	end
end
