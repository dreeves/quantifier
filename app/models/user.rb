# == Schema Information
#
# Table name: users
#
#  beeminder_token   :string           not null
#  beeminder_user_id :string           not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  has_many :providers, dependent: :destroy, foreign_key: :beeminder_user_id

  self.primary_key = :beeminder_user_id

  def self.find_by_provider_attrs attrs
    User.joins(:providers).where(identities: attrs).first
  end

  def self.upsert id, token
    user = find_or_initialize_by(beeminder_user_id: id)
    user.beeminder_token = token
    user.tap(&:save!)
  end

  def client
    Beeminder::User.new beeminder_token, :auth_type => :oauth
  end
end
