module Api
  module V1
    class PlayersController < ApplicationController
      # GET /api/v1/players
      def index
        players = Player.all
        render json: players, status: :ok
      end
      # POST /api/v1/players/:id/follow
      def follow
        followed = Player.find(params[:id])
        follower = Player.find(params[:follower_id])  # dari request body

        follow = Follow.new(follower_id: follower.id, followed_id: followed.id)

        if follow.save
          render json: { message: "Successfully followed #{followed.name}" }, status: :created
        else
          render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/players/:id/unfollow
      def unfollow
        followed = Player.find(params[:id])
        follower = Player.find(params[:follower_id])

        follow = Follow.find_by(follower_id: follower.id, followed_id: followed.id)

        if follow
          follow.destroy
          render json: { message: "Successfully unfollowed #{followed.name}" }, status: :ok
        else
          render json: { errors: ["You are not following this player"] }, status: :not_found
        end
      end

      # GET /api/v1/players/:id/followers
      def followers
        player = Player.find(params[:id])
        followers = player.followers.select(:id, :name)
        render json: followers
      end

      # GET /api/v1/players/:id/following
      def following
        player = Player.find(params[:id])
        following = player.following.select(:id, :name)
        render json: following
      end

      # GET /api/v1/players/:id/following/leaderboard
      def following_leaderboard
        player = Player.find(params[:id])
        following_ids = player.following.pluck(:id)
        top_scores = Score.where(player_id: following_ids)
                          .order(score: :desc)
                          .limit(10)
                          .includes(:player)
                          .map { |s| { player_name: s.player.name, score: s.score } }

        render json: top_scores
      end
    end
  end
end
