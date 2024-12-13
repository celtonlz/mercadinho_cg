class CreateVendaProdutos < ActiveRecord::Migration[8.0]
  def change
    create_table :venda_produtos do |t|
      t.references :venda, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade

      t.timestamps
    end
  end
end
