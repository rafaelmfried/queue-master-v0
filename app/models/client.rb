class Client < ApplicationRecord
  has_one :ticket, dependent: :destroy
end
