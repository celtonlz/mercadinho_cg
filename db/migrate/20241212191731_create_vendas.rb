class CreateVendas < ActiveRecord::Migration[8.0]
  def change
    create_table :vendas do |t|
      t.string :cliente_nome
      t.string :cliente_cpf
      t.decimal :total

      t.timestamps
    end
  end
end
