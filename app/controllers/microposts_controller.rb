class MicropostsController < ApplicationController
  before_action :set_user
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  # GET /user/:id/microposts or /microposts.json
  def index
    @microposts = @user.microposts
  end

  # GET /user/:id/microposts/1 or /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = @user.microposts.build
  end

  # GET /users/:id/microposts/1/edit
  def edit
  end

  # POST /microposts or /microposts.json
  def create
    @micropost = @user.microposts.build(micropost_params)

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to user_microposts_path(@user), notice: "Micropost was successfully created." }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to user_microposts_path(@user), notice: "Micropost was successfully updated." }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render edit_user_path(@user), status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id/microposts/1 or /microposts/1.json
  def destroy
    @micropost.destroy!

    respond_to do |format|
      format.html { redirect_to user_microposts_path(@user), status: :see_other, notice: "Micropost was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end
end
