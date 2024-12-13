class Upload < ApplicationRecord
    mount_uploader :file, FileUploader
  
    # Processa o arquivo CSV e cria produtos
    def process_csv
      return unless file.present?
  
      # Abre o arquivo CSV e lê linha por linha
      CSV.foreach(file.path, headers: true) do |row|
        Produto.create!(
          nome: row['nome'],
          preco: row['preco'].to_f
        )
      end
    end
end
