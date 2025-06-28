class ProductsController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  def authorize_admin
    unless @current_user&.admin?
      render json: { error: "Acesso restrito ao administrador" }, status: :forbidden
    end
  end

  def index
    products = Product.all
    render json: products
  end

  def show
    render json: @product
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    render json: { error: "Produto não encontrado" }, status: :not_found unless @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
