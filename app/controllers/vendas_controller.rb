class VendasController < ApplicationController
    require 'csv'
    before_action :set_venda, only: [:show, :edit, :update, :destroy]
  
    def index
    end
  
    def show_all
        @vendas = Venda.page(params[:page]).per(3)
    end
  
    def show
        @venda = Venda.find(params[:id])
    end

    def new
      @venda = Venda.new
      @produtos = Produto.all
    end
  
    def create
        @venda = Venda.new(venda_params)
      
        if @venda.save
          # Criando as relações VendaProduto para cada produto selecionado
          params[:produtos].each do |produto_id, _|
            quantidade = params[:quantidades][produto_id].to_i
            VendaProduto.create!(venda: @venda, produto_id: produto_id, quantidade: quantidade)
          end
      
          # Atualizando o total da venda
          @venda.update(total: calcular_total(@venda))
      
          redirect_to @venda
        else
          render :new
        end
    end   
  
    def edit
      @produtos = Produto.all
    end
  
    def update
      @venda.venda_produtos.destroy_all
      params[:produtos].each do |produto_id, _|
        quantidade = params[:quantidades][produto_id].to_i
        VendaProduto.create!(venda: @venda, produto_id: produto_id, quantidade: quantidade)
      end
      @venda.update(venda_params.merge(total: calcular_total(@venda)))
      redirect_to @venda
    end
    
    def destroy
      @venda.destroy
        respond_to do |format|
        format.html { redirect_to show_vendas_path, message: "Venda excluída com sucesso." }
        format.js   # Responde ao JavaScript se `remote: true` foi usado.
      end
    end       
  
    def export_pdf
      @vendas = Venda.all
    
      pdf = Prawn::Document.new
      pdf.text "Listagem de Vendas", size: 18, style: :bold
      pdf.move_down 20
    
      table_data = [["ID", "Cliente", "CPF", "Total"]] + 
                   @vendas.map do |venda|
                     [venda.id, venda.cliente_nome, venda.cliente_cpf, "R$ #{venda.total}"]
                   end
    
      pdf.table(table_data, header: true, width: 500) do
        row(0).font_style = :bold
        self.header = true
      end
    
      send_data pdf.render,
                filename: "vendas_listagem.pdf",
                type: "application/pdf",
                disposition: "inline"
    end

    def export_csv
      @vendas = Venda.all
      csv_data = CSV.generate(headers: true) do |csv|
        csv << ["ID", "Cliente", "CPF"] # Cabeçalho do CSV
        @vendas.each do |venda|
          csv << [venda.id, venda.cliente_nome, venda.cliente_cpf] # Dados de cada venda
        end
      end
  
      send_data csv_data,
                filename: "vendas_listagem.csv",
                type: "text/csv",
                disposition: "inline"
    end

    private
  
    def set_venda
      @venda = Venda.find(params[:id])
    end
  
    def venda_params
      params.require(:venda).permit(:cliente_nome, :cliente_cpf)
    end
  
    def calcular_total(venda)
      venda.venda_produtos.joins(:produto).sum("produtos.preco * venda_produtos.quantidade")
    end
    
  end  