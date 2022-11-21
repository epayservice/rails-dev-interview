# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  currency   :string           not null
#  fields     :json             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Country < ApplicationRecord
  validates :name, presence: true
  validates :currency, presence: true, uniqueness: { scope: :name }
  validates :fields, presence: true
end
