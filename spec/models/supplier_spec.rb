require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when Razão Social is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACMESSA', registration_number: '12.123.123/0001-00', 
          full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: 'contatoacme@acme.com')
  
        # Act
        result = supplier.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'false when Nome Fantasia is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.new(corporate_name: 'ACMA', brand_name: '', registration_number: '12.123.123/0001-00', 
          full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: 'contatoacme@acme.com')
  
        # Act
        result = supplier.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'false when CNPJ is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.new(corporate_name: 'ACMA', brand_name: 'ACMA SA', registration_number: '', 
          full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: 'contatoacme@acme.com')
  
        # Act
        result = supplier.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'false when CNPJ is empty' do
        # Arrange  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
        supplier = Supplier.new(corporate_name: 'ACMA', brand_name: 'ACMA SA', registration_number: '12.123.123/0001-00', 
          full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', state: 'MG', email: '')
  
        # Act
        result = supplier.valid?
  
        # Assert
        expect(result).to eq false
      end
    end

    it 'false when CNPJ is already in use' do
      # Arrange
      first_supplier = Supplier.create(corporate_name: 'ACMA', brand_name: 'ACME SA', 
                                    registration_number: '12.123.123/0001-00', 
                                    full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', 
                                    state: 'MG', email: 'contatoacme@acme.com')
      second_supplier = Supplier.new(corporate_name: 'ECMA', brand_name: 'ECMA SA', 
                                     registration_number: '12.123.123/0001-00', 
                                     full_address: 'Av dos Retireiros, 200', city: 'Araras', 
                                     state: 'SP', email: 'ecma@ecmacontato.com')

      # Act
      result = second_supplier.valid?

      # Assert
      expect(result).to eq false
    end
    
    it 'false when CNPJ  is invalid' do
      # Arrange
      supplier = Supplier.new(corporate_name: 'ACMA', brand_name: 'ACME SA', 
        registration_number: '12.123.123/0001-000', 
        full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', 
        state: 'MG', email: 'contatoacme@acme.com')

      # Act
      result = supplier.valid?

      # Assert
      expect(result).to eq false
    end
    
    it 'false when CNPJ is invalid' do
      # Arrange
      supplier = Supplier.new(corporate_name: 'ACMA', brand_name: 'ACME SA', 
        registration_number: '12.123.123/00000', 
        full_address: 'Av das Angolas, 500', city: 'Poços de Caldas', 
        state: 'MG', email: 'contatoacme@acme.com')

      # Act
      result = supplier.valid?

      # Assert
      expect(result).to eq false
    end
  end
end