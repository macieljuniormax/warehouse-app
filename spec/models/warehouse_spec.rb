require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                  city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false


        # Other options
        expect(result).to be_falsey

        # expect(warehouse).not_to be_valid # => executa o valid? e espera que seja falso

      end
  
      it 'false when code is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', 
                                  city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when city is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                  city: '', area: 1000, description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when description is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                  city: 'Rio de Janeiro', area: 1000, description: '')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when address is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', 
                                  city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when cep is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', 
                                  city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when area is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                  city: 'Rio de Janeiro', area: '', description: 'Novo galpão no Rio de Janeiro')
  
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
    end

    it 'false when code is already in use' do
      # Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                      city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
      second_warehouse = Warehouse.new(name: 'Niterói', code: 'RIO', address: 'Avenida', cep: '25000-123', 
                                       city: 'Niterói', area: 2000, description: 'Outro galpão no Rio de Janeiro')

      # Act
      result = second_warehouse.valid?

      # Assert
      expect(result).to eq false
    end

    it 'false when name is already in use' do
      # Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', 
                                      city: 'Rio de Janeiro', area: 1000, description: 'Novo galpão no Rio de Janeiro')
      second_warehouse = Warehouse.new(name: 'Rio', code: 'RIN', address: 'Avenida', cep: '25000-123', 
                                       city: 'Niterói', area: 2000, description: 'Outro galpão no Rio de Janeiro')

      # Act
      result = second_warehouse.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
