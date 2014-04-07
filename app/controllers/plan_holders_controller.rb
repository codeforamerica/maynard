class PlanHoldersController < ApplicationController
  def create
    @planholder = PlanHolder.new(planholders_params)

    respond_to do |wants|
      if @planholder.save
        wants.html { redirect_to plan_holders_url, status: :created, notice: "Yay!" }
      else
        wants.html { render action: 'new' }
      end
    end
  end

  def new
    @planholder = PlanHolder.new
    @planholder.user = User.new
    @planholder.company = Company.new
    @projects = Project.order('project_number ASC').pluck(:id, :name, :project_number)
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end

  def destroy
  end

  def update_interface
    @project = Project.find(params[:plan_holder][:project_id])

    respond_to do |wants|
      wants.json { render json: @project, status: :ok }
    end
  end

  private
  def planholders_params
    params.require(:plan_holder).permit(:project_id, company_attributes: [:name], user_attributes: [:email])
  end
end
