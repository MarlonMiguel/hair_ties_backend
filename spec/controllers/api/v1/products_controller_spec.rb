require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product) { Product.create(name: "Produto", description: "Teste", price: 10.0) }

  describe "GET index" do
    it "retorna lista de produtos" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "cria um novo produto" do
      post :create, params: { product: { name: "Novo Produto", description: "Teste", price: 15.0 } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT update" do
    it "atualiza um produto existente" do
      put :update, params: { id: product.id, product: { name: "Produto Atualizado" } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "exclui um produto" do
      expect { delete :destroy, params: { id: product.id } }.to change(Product, :count).by(-1)
    end
  end
end
