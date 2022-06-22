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
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
        description: 'Galpão destinados para cargas internacionais.')

      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      jason_responde = JSON.parse(response.body)
      expect(jason_responde["name"]).to eq('Aeroporto SP')
      expect(jason_responde["code"]).to eq('GRU')
      expect(jason_responde.keys).not_to include('created_at')
      expect(jason_responde.keys).not_to include('updated_at')    
    end
  end
end
