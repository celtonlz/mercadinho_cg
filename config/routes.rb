  Rails.application.routes.draw do
    get "uploads/new"
    get "uploads/create"
    root "vendas#index"
    get 'vendas/show_all', to: 'vendas#show_all', as: 'show_vendas'
    get 'vendas/export_pdf', to: 'vendas#export_pdf', as: 'export_vendas_pdf'
    resources :vendas do 
      collection do
        get :export_csv
        get :export_pdf
      end
    end
    resources :produtos, only: [:create] 
    resources :uploads, only: [:new, :create]
  end