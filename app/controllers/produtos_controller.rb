class ProdutosController < ApplicationController
    def create
      @produto = Produto.new(produto_params)
      if @produto.save
        render json: { message: "Produto cadastrado com sucesso!", produto: @produto }
      else
        render json: { errors: @produto.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def produto_params
      params.require(:produto).permit(:nome, :preco)
    end
  end  