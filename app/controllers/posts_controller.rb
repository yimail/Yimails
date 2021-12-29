class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all
    @posts = Post.includes([:rich_text_body])
  end

  def show
  end
  
  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end