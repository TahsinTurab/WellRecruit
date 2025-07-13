class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ show edit update destroy ]
  before_action :set_application, only: %i[ new create ]
  before_action :check_assessment_time, only: %i[ new ]
  before_action :set_questions, only: %i[ new create ]

  def index
    @participations = Participation.all
  end

  def show
  end

  def new
    @participation = @application.build_participation
    @questions.each do |question|
      submission = @participation.submissions.build(question_id: question.id)
      question.answers.each do |answer|
        submission.responses.build(answer_id: answer.id)
      end
    end
  end

  def edit
  end

  def create
    @participation = @application.build_participation(participation_params)

    respond_to do |format|
      if @participation.save
        CalculateScoreJob.perform_now(@participation.id)
        format.html { redirect_to application_url(@participation.application), notice: "Your submission has been recorded successfully." }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to participation_url(@participation), notice: "Participation was successfully updated." }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participation.destroy!

    respond_to do |format|
      format.html { redirect_to participations_url, notice: "Participation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end

  def set_application
    @application = Application.find(params[:application_id])
  end

  def set_questions
    @questions = @assessment.questions.includes(:answers)
  end

  def participation_params
    params.require(:participation).permit(
      :application_id, :assessment_id,
      submissions_attributes: [
        :id, :question_id, :_destroy,
        responses_attributes: [:id, :answer_id, :correct, :_destroy]
      ]
    )
  end

  def check_assessment_time
    check_starting_time
    check_ending_time
  end

  def check_starting_time
    if Time.current < @assessment.starting_time
      flash[:alert] = "The assessment hasn't started yet."
      redirect_to application_path(@application)
    end
  end

  def check_ending_time
    if Time.current > @assessment.ending_time
      flash[:alert] = "The assessment has ended."
      redirect_to application_path(@application)
    end
  end
end
