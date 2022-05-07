class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :code, uniqueness: true

  # validates(atributos, tipo_da_validação: true)
end
