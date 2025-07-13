Rails.application.routes.draw do
  resources :admin, only: [:index] do
    member do
      get 'approve_recruiter/:recruiter_id', to: 'admin#approve_recruiter', as: 'approve_recruiter'
      get 'destroy_recruiter/:recruiter_id', to: 'admin#destroy_recruiter', as: 'destroy_recruiter'
    end
  end
  resources :companies
  get 'my_company', to: 'companies#my_company', as: :my_company

  root 'home#index'

  devise_for :users

  resources :jobs, shallow: true do
    resources :assessments, shallow: true do
      resources :questions, shallow: true
    end

    resources :applications, controller: 'job_applications' do
      member do
        get 'change_status/:status', to: 'job_applications#change_status', as: 'change_status'
      end

      resources :participations
    end
  end

  get "my_jobs", to: "jobs#my_jobs", as: "my_jobs"
end
