class MergeRequestController < ApplicationController
  menu_item :settings
  before_filter :find_project, :authorize

  # Create or update a project's merge request settings
  def edit
    if User.current.allowed_to? :manage_gitlab_merge_request, @project
      @gitlab_merge_request = GitlabMergeRequest.find_or_initialize_by(:project_id => @project.id)
      @gitlab_merge_request.update(merge_request_params) if request.post?
      flash[:notice] = "Settings saved"
      #@merge_request.save
    end
  end
private
  def merge_request_params
    params.require(:merge_request).permit(:gitlab_url, :project_name, :assignee_id, :milestone_id, :source, :target, :use_parent_settings)
  end
end