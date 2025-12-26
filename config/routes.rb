Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post   'scores', to: 'scores#create'
      get    'leaderboard', to: 'scores#leaderboard'
      get 'players', to: 'players#index'

      # Players social actions
      post    'players/:id/follow',                 to: 'players#follow'
      delete  'players/:id/unfollow',               to: 'players#unfollow'
      get     'players/:id/followers',              to: 'players#followers'
      get     'players/:id/following',              to: 'players#following'
      get     'players/:id/following/leaderboard',  to: 'players#following_leaderboard'
    end
  end
end
