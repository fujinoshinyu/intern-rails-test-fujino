# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks do
    put :update_status
  end
end
