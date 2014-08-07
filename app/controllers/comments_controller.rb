class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    if params[:post_id]
      @parent = Post.find(params[:post_id])
    elsif params[:comment_id]
      @parent = Comment.find(params[:comment_id])
    end
    render :new
  end

  def create
    if params[:comment_id]
      @parent_comment = Comment.find(params[:comment_id])
      @comment = @parent_comment.child_comments.new(comment_params)
      @comment.post_id = @parent_comment.post_id
    elsif params[:post_id]
      @post = Post.find(params[:post_id])
      @comment = @post.top_level_comments.new(comment_params)
    end

    @comment.author_id = current_user.id

    @post = Post.find(@comment.post_id)

    if @comment.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :child, :commentable_type)
  end

end