module QuestionsHelper
  def options(question)
    question.answers.to_a
  end
end
