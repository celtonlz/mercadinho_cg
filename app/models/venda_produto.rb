class VendaProduto < ApplicationRecord
  belongs_to :venda
  belongs_to :produto

  validates :quantidade, presence: true, numericality: { greater_than: 0 }
end