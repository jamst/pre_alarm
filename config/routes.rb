Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'admin/alarm/records#index'
    resources :employees do
      collection do
        get 'forget_password'
        post 'forget_password'
        get 'reset_mail'
        get 'error_mail'
      end
    end

    # 告警监控
    namespace :alarm do
      resources :alarms
      resources :records, only: [:index] do
        collection do
          get :alarm_analysis
          get :ignore
          get :fast_find
        end  
      end
    end
  end

  root to: 'admin/alarm/records#index'
  devise_for :employees, path: "admin", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'cmon_let_me_in' }, controllers: { sessions: "admin/sessions", passwords: "admin/passwords"}

end
