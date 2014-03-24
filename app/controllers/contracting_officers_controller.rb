class ContractingOfficersController < ApplicationController
  before_action :set_contracting_officer, only: [:show, :edit, :update, :destroy]

  # GET /contracting_officers
  # GET /contracting_officers.json
  def index
    @contracting_officers = ContractingOfficer.order('contracting_officers.last_name ASC').all
  end

  # GET /contracting_officers/1
  # GET /contracting_officers/1.json
  def show
    @projects = @contracting_officer.projects.load
  end

  # GET /contracting_officers/new
  def new
    @contracting_officer = ContractingOfficer.new
  end

  # GET /contracting_officers/1/edit
  def edit
  end

  # POST /contracting_officers
  # POST /contracting_officers.json
  def create
    @contracting_officer = ContractingOfficer.new(contracting_officer_params)

    respond_to do |format|
      if @contracting_officer.save
        @mixpanel.track('1', 'create-contracting-officer')
        format.html { redirect_to contracting_officers_url, notice: 'Contracting officer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contracting_officer }
      else
        format.html { render action: 'new' }
        format.json { render json: @contracting_officer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracting_officers/1
  # PATCH/PUT /contracting_officers/1.json
  def update
    respond_to do |format|
      if @contracting_officer.update(contracting_officer_params)
        @mixpanel.track('1', 'update-contracting-officer')
        format.html { redirect_to @contracting_officer, notice: 'Contracting officer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contracting_officer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracting_officers/1
  # DELETE /contracting_officers/1.json
  def destroy
    @contracting_officer.destroy
    respond_to do |format|
      format.html { redirect_to contracting_officers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contracting_officer
      @contracting_officer = ContractingOfficer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contracting_officer_params
      params.require(:contracting_officer).permit(:first_name, :last_name, :email_address)
    end
end
