class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :authorize_creation!, only: [:new, :create]

  # GET /posts
  def index
   
      @posts = Post.where(published: true).order(created_at: :desc)
  

    if params[:query].present?
      query = "%#{params[:query]}%"
      @posts = @posts.where("title LIKE ? OR body LIKE ?", query, query)
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /my_posts
  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :published)
    end

    # Edycja i usuwanie: autor albo admin
    def authorize_user!
      unless current_user.admin? || (current_user.writer? && @post.user == current_user)
        redirect_to posts_path, alert: "You are not authorized to edit or delete this post."
      end
    end

    # Tworzenie: tylko writer albo admin
    def authorize_creation!
      unless current_user.admin? || current_user.writer?
        redirect_to posts_path, alert: "You are not authorized to create posts."
      end
    end
end
