class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_micropost, only: %i[ show edit update destroy ]
  before_action :correct_user, only: :destroy

  # GET /microposts or /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/1 or /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts or /microposts.json
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: "Micropost was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit, status: :unprocessable_content }  # dùng unprocessable_content thay vì deprecated
        format.json { render json: @micropost.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /microposts/1 or /microposts/1.json
  def destroy
    @micropost.destroy!
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    # Confirms the correct user.
    def correct_user
      # Safe check: current_user đã login nhờ before_action :logged_in_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
