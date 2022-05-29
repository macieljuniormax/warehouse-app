require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "deve ter um código" do
      # Arrange
      user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, 
                        address: 'Avenida tiradentes, 20', cep: '46000-000', 
                        description: 'Galpão para cargas mineiras.')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                       registration_number: '12.123.123/0001-00', 
                       full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                       state: 'SP', email: 'sac@samsung.com.br')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      # Act
      result = order.valid?
      # Assert
      expect(result).to be true 
    end

    it "data de entrega deve ser válida" do
      # Arrange
      order = Order.new(estimated_delivery_date: '')
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
    end

    it "data de entrega não deve ser passada" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it "data de entrega não deve ser igual a hoje" do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it "data de entrega deve ser maior ou igual que amanhã" do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to be false
    end
    
  end
  
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, 
                        address: 'Avenida tiradentes, 20', cep: '46000-000', 
                        description: 'Galpão para cargas mineiras.')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                       registration_number: '12.123.123/0001-00', 
                       full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                       state: 'SP', email: 'sac@samsung.com.br')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      # Act
      
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty  
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      # Arrange
      user = User.create!(name: 'Maciel', email: 'macieljunior@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, 
                        address: 'Avenida tiradentes, 20', cep: '46000-000', 
                        description: 'Galpão para cargas mineiras.')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos SA', brand_name: 'Samsung', 
                       registration_number: '12.123.123/0001-00', 
                       full_address: 'Av das Nações Unidas, 1000', city: 'São Paulo', 
                       state: 'SP', email: 'sac@samsung.com.br')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')
      # Act
      # Act
      second_order.save!
      # Assert
      expect(second_order.code).not_to eq first_order.code  
    end
  end
end
