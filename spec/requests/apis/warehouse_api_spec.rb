require 'rails_helper'

describe "Warehouse API" do
  context 'GET /api/v1/warehouses/1' do
    it "sucess" do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinados para cargas internacionais.')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      jason_responde = JSON.parse(response.body)
      expect(jason_responde["name"]).to eq('Aeroporto SP')
      expect(jason_responde["code"]).to eq('GRU')
      expect(jason_responde.keys).not_to include('created_at')
      expect(jason_responde.keys).not_to include('updated_at')    
    end

    it "fail if warehouse not found" do
      get "/api/v1/warehouses/9999999"

      expect(response.status).to eq 404
    end
  end

  context "GET /api?v1?watrhouses" do
    it "sucess" do
      warehouse_1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinados para cargas internacionais.')
      warehouse_2 = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000, 
        address: 'Avenida do Aeroporto, 2000', cep: '45000-000', 
        description: 'Galpão destinados para cargas internacionais.')

      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      jason_responde = JSON.parse(response.body)
      expect(jason_responde.length).to eq 2
      expect(jason_responde[0]["name"]).to eq 'Aeroporto SP'
      expect(jason_responde[1]["name"]).to eq 'Rio'
    end

    it "return empty if there is no warehouse" do

      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      jason_responde = JSON.parse(response.body)
      expect(jason_responde).to eq []
    end
  end





end
