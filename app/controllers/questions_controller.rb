class QuestionsController < ApplicationController
  before_action :set_assessment
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = @assessment.questions.all
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    1.times do
      @question = @assessment.questions.build
      4.times { @question.answers.build }
    end
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    respond_to do |format|
      if @assessment.update(question_create_params)
        format.html { redirect_to assessment_questions_path(@assessment), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to assessment_questions_path(@question.assessment), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @assessment = @question.assessment
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to assessment_questions_path(@assessment), notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:statement, :assessment_id, answers_attributes: [:id, :option, :correct, :question_id])
    end

    def question_create_params
      params.require(:assessment).permit(questions_attributes: [:statement, :assessment_id,
                                                              answers_attributes: [:id, :option, :correct, :question_id]])
    end

    def set_assessment
      @assessment = Assessment.find_by(id: params[:assessment_id])
    end
end
