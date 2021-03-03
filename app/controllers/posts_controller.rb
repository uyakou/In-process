class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  PER = 6

  def index
    @posts = Post.page(params[:page]).per(PER)
  end

  def show
   @post = Post.find(params[:id])
   @like = Like.new
  end

  def new
    @post = Post.new
  end

  def edit
   @post = Post.find(params[:id])
    if @post.user != current_user
    redirect_to posts_path alert: "不正なアクセスです。一覧画面に戻ります。"
    end
  end

  def create
    @post = Post.create params.require(:post).permit(:title, :category, :progress, :comment, :image)
    @post.user_id = current_user.id
    if  @post.save
      redirect_to post_path(@post), notice: "栞を挟みました。"
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if  @post.update(post_params)
      redirect_to post_path(@post), notice: "栞を編集しました。"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "栞を削除しました。"
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :category, :progress, :comment, :image)
  end

end