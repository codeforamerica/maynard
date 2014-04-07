class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :planholders]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.includes(:contracting_officer).paginate(page: params[:page], per_page: 10).order('closing_date ASC')
    #@mixpanel.track('1', 'load-all-projects')
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @questions = @project.questions.load
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.contracting_officer = ContractingOfficer.new
  end

  # GET /projects/1/edit
  def edit
    @project.contracting_officer = ContractingOfficer.new unless @project.contracting_officer
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @mixpanel.track('1', 'project-created')
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(project_params)
        @mixpanel.track('1', 'project-updated')
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def planholders
    @planholders = PlanHolder.where(project_id: params[:project_id]).order('created_at DESC')

    respond_to do |wants|
      wants.html
      wants.json
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      project_id = params[:id].nil? ? params[:project_id] : params[:id]
      @project = Project.find(project_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_number, :name, :closing_date, :question_closing_date, :contracting_officer_id, contracting_officer_attributes: [:id])
    end
end
