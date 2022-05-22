require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
      it 'name is mandatory' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                    registration_number: '12.123.123/0001-00', 
                                    full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                    state: 'SP', email: 'sac@samsung.com.br')
      
        product_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, 
                                             sku: 'TV32-SAMSUNG-XPTO90', supplier: supplier)                    
  
        # Act
        result = product_model.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'sku is mandatory' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                                    registration_number: '12.123.123/0001-00', 
                                    full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                                    state: 'SP', email: 'sac@samsung.com.br')
      
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                                             sku: '', supplier: supplier)                    
  
        # Act
        result = product_model.valid?
  
        # Assert
        expect(result).to eq false
      end
  end
end
