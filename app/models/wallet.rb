# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  balance    :decimal(, )      not null
#  currency   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Wallet < ApplicationRecord
  validates :balance, presence: true
  validates :currency, presence: true
end
