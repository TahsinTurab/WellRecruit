class JobApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show edit update destroy change_status ]

  def index
    @applications = Application.where(job_id: params[:job_id])
  end

  def show
  end

  def new
    @job = Job.find_by_id(params[:job_id])
    @application = current_user.applications.build
  end

  def edit
  end

  def create
    @application = current_user.applications.build(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to application_url(@application), notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to application_url(@application), notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job = @application.job
    @application.destroy!

    respond_to do |format|
      format.html { redirect_to job_path(@job), notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def change_status
    if @application.update(:status => params[:status])
      if params[:status] == "selected"
        flash[:notice] = "#{@application.user.name} has been invited to participate into the MCQ assessment."
        ApplicantsMailer.invitation(@application).deliver_now
      elsif params[:status] == "rejected"
        flash[:alert] = "#{@application.user.name} has been rejected to participate into the MCQ assessment."
        ApplicantsMailer.rejection(@application).deliver_now
      end
    else
      flash[:notice] = "There arise some issues while changing the status"
    end
    redirect_to job_applications_path(@application.job)
  end

  private

    def set_application
      @application = Application.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:status, :job_id, :user_id, :resume)
    end
end
