class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :ldap_authenticatable, :rememberable, :trackable,
  #       :validatable

  validates :email, presence: { message: "must be provided." }
  validates :first_name, presence: { message: "must be provided." }
  validates :last_name, presence: { message: "must be provided." }

  validates_uniqueness_of :email, case_sensitive: false
end
