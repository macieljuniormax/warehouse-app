class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, :email, uniqueness: true
  validates :registration_number, format: {with:  /\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z/}
end
