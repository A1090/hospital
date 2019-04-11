Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root 'devise/sessions#new'
  end

  get 'welcome2/index'
  get 'welcome/index'
  
  get 'patients/list'
  get 'patients/new'
  post 'patients/create'
  patch 'patients/update'
  get 'patients/list'
  get 'patients/show'
  get 'patients/edit'
  get 'patients/delete'
  get 'patients/update'
  
  resources :patients do
    member do
      get :add_doctor
      post :create_doctor
      get :show_doctors
      get :delete_doctors
    end
  end

  get 'doctors/list'
  get 'doctors/new'
  post 'doctors/create'
  patch 'doctors/update'
  get 'doctors/list'
  get 'doctors/show'
  get 'doctors/edit'
  get 'doctors/delete'
  get 'doctors/update'

  resources :doctors do
    member do
      get :add_patient
      post :create_patient
      get :show_patients
      get :delete_patients
    end
  end

  get 'medicines/list'
  get 'medicines/new'
  post 'medicines/create'
  patch 'medicines/update'
  get 'medicines/list'
  get 'medicines/show'
  get 'medicines/edit'
  get 'medicines/delete'
  get 'medicines/update'

  get 'appointments/list'
  get 'appointments/new'
  post 'appointments/create'
  patch 'appointments/update'
  get 'appointments/list'
  get 'appointments/show'
  get 'appointments/edit'
  get 'appointments/delete'
  get 'appointments/update'
  get 'appointments/show_patients'
  get 'appointments/show_medicines'
end
