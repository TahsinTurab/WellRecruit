class CalculateScoreJob < ApplicationJob
  queue_as :default

  def perform(participation_id)
    participation = Participation.find(participation_id)
    submissions = participation.submissions.includes(:responses)
    answers = Answer.where(id: submissions.flat_map { |s| s.responses.pluck(:answer_id) }).index_by(&:id)
    score = 0

    submissions.each do |submission|
      correct = submission.responses.all? do |response|
        answers[response.answer_id]&.correct == response.correct
      end
      score += 1 if correct
    end

    participation.update(score: score)
  end
end
