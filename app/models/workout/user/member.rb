# Workout domain
#
module Workout
  # The user module is responsible for representing the concept of users in the
  # system.
  #
  module User
    # Member model
    #
    # Represents a user who has a member record in our data
    #
    class Member < ActiveRecord::Base
      has_secure_password

      validates_presence_of :password, on: :create
      validates :email,
                format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                presence: true,
                uniqueness: { case_sensitive: false }

      # Query: Looks for a user by email
      #
      # @params [string] the email to search on
      # @return [Member] Will return self.unknown_user if not found
      #
      def self.find_by_email(email)
        Member.where(email: email).first || Member.unknown_user
      end

      # Query: Looks for a user by id
      #
      # @params [int] the id to search on
      # @return [Member] Will return self.unknown_user if not found
      #
      def self.find_by_id(id)
        Member.where(id: id).first || Member.unknown_user
      end

      # Query: Returns a null object for an unknown user
      #
      # @return [User::Unknown]
      #
      def self.unknown_user
        Unknown.new
      end
    end
  end
end
