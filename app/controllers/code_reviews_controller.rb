class CodeReviewsController < InheritedResources::Base
  def create
    review = CodeReview.create(:user_id => params[:user_id], :answer_id => params[:answer_id], :lgtm => params[:lgtm], :comment => params[:comment])
    redirect_to answer_path(params[:answer_id]), notice: notice
  end
  private

    def code_review_params
      params.require(:code_review).permit(:user_id, :answer_id, :lgtm)
    end

end
