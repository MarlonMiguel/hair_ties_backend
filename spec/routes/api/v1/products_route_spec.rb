require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  let!(:product) { Product.create(name: "Produto", description: "Teste", price: 10.0) }

  describe "GET /products" do
    it "retorna lista de produtos" do
      get "/products"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end  

  describe "POST /products" do
    it "cria um novo produto" do
      post "/products", params: { product: { name: "Novo Produto", description: "Teste", price: 15.0 } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /products/:id" do
    it "atualiza um produto existente" do
      put "/products/#{product.id}", params: { product: { name: "Produto Atualizado" } }
      expect(response).to have_http_status(:success)
      expect(product.reload.name).to eq("Produto Atualizado")
    end
  end

  describe "DELETE /products/:id" do
    it "exclui um produto" do
      expect { delete "/products/#{product.id}" }.to change(Product, :count).by(-1)
    end
  end
end
