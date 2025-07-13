class AssessmentsController < ApplicationController
  before_action :set_job
  before_action :set_assessment, only: %i[ show edit update destroy ]

  # GET /assessments or /assessments.json
  def index
    @assessments = Assessment.all
  end

  # GET /assessments/1 or /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = @job.build_assessment
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments or /assessments.json
  def create
    @assessment = @job.build_assessment(assessment_params)

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to assessment_url(@assessment), notice: "Assessment was successfully created." }
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessments/1 or /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to assessment_url(@assessment), notice: "Assessment was successfully updated." }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1 or /assessments/1.json
  def destroy
    @job = @assessment.job
    @assessment.destroy!

    respond_to do |format|
      format.html { redirect_to job_path(@job), notice: "Assessment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assessment_params
      params.require(:assessment).permit(:title, :starting_time, :ending_time, :candidate_selection, :job_id)
    end

    def set_job
      @job = Job.find_by(id: params[:job_id])
    end
end
