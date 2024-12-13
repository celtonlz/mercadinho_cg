class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      @upload.process_csv
      redirect_to root_path, notice: "Produtos importados com sucesso!"
    else
      render :new
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end