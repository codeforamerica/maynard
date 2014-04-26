class PlanHoldersController < ApplicationController
  before_filter :find_project, only: [:create]

  def create
    @planholder = PlanHolder.new(planholders_params)

    respond_to do |wants|
      if @planholder.save
        wants.html do
          if zipfile_name = ZipAssembler.assemble_zip_archive(@project)
            @mixpanel.track('1', 'planholder-download')
            send_file zipfile_name, filename: "#{ @project.name_with_project_number }-#{ Time.now.to_i }.zip"
          else
            wants.html { redirect_to new_plan_holder_url }
            wants.json { head :unprocessable_entity }
          end
        end
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
    @mixpanel.track('1', 'bid-docs-selected')

    respond_to do |wants|
      wants.json { render json: @project, status: :ok }
    end
  end

  private
  def find_project
    @project = Project.find(params[:plan_holder][:project_id])
  end

  def planholders_params
    params.require(:plan_holder).permit(:project_id, company_attributes: [:name], user_attributes: [:email, :first_name, :last_name])
  end
end
