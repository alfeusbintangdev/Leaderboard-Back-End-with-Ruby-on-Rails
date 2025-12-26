class FollowsController < ApplicationController
  # POST /follows
  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      render json: { message: "Successfully followed player." }, status: :created
    else
      render json: { errors: @follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /follows/:id
  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    render json: { message: "Successfully unfollowed player." }, status: :ok
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end
end
