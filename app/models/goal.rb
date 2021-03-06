# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  provider_id :integer          not null
#  slug        :string           not null
#  last_value  :float
#  params      :json             default({}), not null
#

class Goal < ActiveRecord::Base
  belongs_to :provider
end
