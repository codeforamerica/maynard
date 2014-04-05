class AnswersController < ApplicationController
  before_filter :find_question

  def index
  end

  def update
  end

  def create
    @answer = Answer.create(answer_params)

    respond_to do |wants|
      if @answer.save
        @mixpanel.track('1', 'response-added')
        wants.html { redirect_to [@question.project, @question], notice: "Your response was added!" }
        wants.json { render action: 'show', status: :created, location: @answer }
      else
        wants.html { render action: 'new' }
        wants.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @answer = @question.answers.build
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private
  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
