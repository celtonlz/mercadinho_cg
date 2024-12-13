class Produto < ApplicationRecord
    has_many :venda_produtos
    has_many :vendas, through: :venda_produtos
  
    validates :nome, presence: true
    validates :preco, presence: true, numericality: { greater_than: 0 }
  end  