class VotesController < ApplicationController

  def upvote
    @vote = Vote.new(vote_params)
    @vote.value = 1
    @vote.save
    redirect_to :back
  end

  def downvote
    @vote = Vote.new(vote_params)
    @vote.value = -1
    @vote.save
    redirect_to :back
  end

  private

  def vote_params
    params.require(:vote).permit!
  end
end