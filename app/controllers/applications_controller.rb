class ApplicationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_application, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:new, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:notice] = "Application not found!"
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to root_path
  end

  # GET /applications or /applications.json
  def index
    # @users = User.accessible_by(current_ability)
    @applications = Application.all
  end

  # GET /applications/1 or /applications/1.json
  def show
    # authorize! :show, @user
    if current_user.admin?
      @application.seen = true
      @application.save
    end



  end

  # GET /applications/new
  def new
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications or /applications.json
  def create
    @application = Application.new(application_params)
    @application.user_id = current_user.id
    @application.job_id = params[:application][:job_id]

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def correct_user

  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:app_id, :user_id, :job_id, :seen)
    end
end
