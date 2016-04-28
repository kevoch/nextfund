class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]



  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @environments = Project.where(category: "Environment").order(cached_votes_up: :desc).limit(3)
    @communities = Project.where(category: "Community").order(cached_votes_up: :desc).limit(3)
    @medicals = Project.where(category: "Medical").order(cached_votes_up: :desc).limit(3)
    @educations = Project.where(category: "Education").order(cached_votes_up: :desc).limit(3)
    @disasters = Project.where(category: "Disaster").order(cached_votes_up: :desc).limit(3)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @projects = Project.find_by(id: params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
        authorize! :update, @project

  end

  # POST /projects
  # POST /projects.json
  def create

    @user = current_user
    @project = @user.projects.new(project_params)
    respond_to do |format|
      if @project.save
        @project.create_activity :create, owner: current_user

        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project.create_activity :update, owner: current_user
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    @project.create_activity :destroy, owner: current_user
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @project = Project.find(params[:id])
   if !current_user.voted_up_on? @project
    @project.upvote_by current_user
    @project.create_activity :upvote, owner: current_user, recipient: @project.user

   else
    @project.downvote_by current_user
   end
   respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js { render :layout => false }
     end
  end

  def downvote
    @project = Project.find(params[:id])
    @project.downvote_by current_user
     respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js { render :layout => false }

     end
    # redirect_to :back
  end

  def donation_milestone
  end













  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :campaign_title, {images: []}, :category, :address, :deadline, :video, :summary, :amount_needed, :amount_achieved)
    end
end
