class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index
      # ページングと降順指定
      @posts = Post.page(params[:page]).per(10).order(created_at: "DESC")
  end

  # POST /posts.js
  def create
    @post = Post.new(post_params)

    # Ajax呼び出しのみ有効
    respond_to do |format|
      if @post.save
        format.js { render :create_success }
      else
        format.js { render :create_error }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
end
