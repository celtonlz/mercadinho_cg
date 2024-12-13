class Venda < ApplicationRecord
    has_many :venda_produtos, dependent: :destroy
    has_many :produtos, through: :venda_produtos
  
    validates :cliente_nome, presence: true
    validates :cliente_cpf, presence: true, format: { with: /\A\d{11}\z/, message: "deve ter 11 dígitos" }
  end  