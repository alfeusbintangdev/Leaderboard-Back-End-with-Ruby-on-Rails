Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post   'scores', to: 'scores#create'
      get    'leaderboard', to: 'scores#leaderboard'

      post   'players/:id/follow',   to: 'players#follow'
      delete 'players/:id/unfollow', to: 'players#unfollow'

      # 🔥 TAMBAHKAN INI
      get 'players/:id/following/leaderboard', to: 'players#following_leaderboard'
    end
  end
end
