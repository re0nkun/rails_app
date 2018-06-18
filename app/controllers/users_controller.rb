class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :liked_post]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_current_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if params[:q] && params[:q].reject { |k, v| v.blank? }.present?
      @q = User.ransack(search_params)
    else
      @q = User.ransack()
    end
    @users = @q.result
    # @s = params[:search]
    # if @s.present?
    #   @users = User.where(['name LIKE ?', "%#{@s}%"])
    # else
    #   @users = User.all
    # end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @s = params[:search]
    # if @s.present?
    #   @posts = @user.posts.where("body LIKE ?", "%#{@s}%")
    # else
    #   @posts = @user.posts
    # end
    if params[:q] && params[:q].reject { |k, v| v.blank? }.present?
      @q = @user.posts.ransack(post_search_params)
    else
      @q = @user.posts.ransack()
    end
    @posts = @q.result

    # @following_posts = @user.feed
    # @sfp = params[:search_f_p]
    # if @sfp.present?
    #   @following_posts = @user.feed.where("body LIKE ?", "%#{@sfp}%")
    # else
    #   @following_posts = @user.feed
    # end
    if params[:q] && params[:q].reject { |k, v| v.blank? }.present?
      @q = @user.feed.ransack(following_post_search_params)
    else
      @q = @user.feed.ransack()
    end
    @following_posts = @q.result
    # @following_posts = Post.eager_load(user: :passive_rels).where(relations: { follower_id: @user.id })  

    # @following_posts = Post.where("user_id IN (?)", @user.followed_ids)

    # @following_posts = Post.where("user_id IN (:following_ids)", following_ids: @user.followed_ids)
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy 
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def following
  end
  def followers
  end
  def liked_post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end

    def set_current_user
      @user = current_user
    end

    def search_params
      params.require(:q).permit(:name_cont)
    end
    def post_search_params
      params.require(:q).permit(:body_cont)
    end
    def following_post_search_params
      params.require(:q).permit(:body_eq)
    end
end
