class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.includes([:rich_text_body])
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end