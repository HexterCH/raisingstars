class ProposalsController < ApplicationController

  before_action :set_proposal, only: [:show]
  before_action :authenticate_user!, except: [:index, :show,:favorite]

  def index
    @proposals = Proposal.all
  end

  def create
    @proposal = Proposal.new(proposal_params)
  end

  def show

    @comments = @proposal.comments
    @newcomment = @proposal.comments.build()
    if current_user
      @user_favor = current_user.userproposalships.find_by_proposal_id(@proposal.id)
    end

  end

  def edit

  end

  def update
    if @proposal.update(proposal_params)
      flash[:notice] = "Update success"
    else
      flash[:notice] = "Update fail"
    end
  end

  def destory
    @proposal.destory
    flash[:alert] = "Delete Success"
  end

  def pay
    @proposal = Proposal.find(params[:id])
    @products = @proposal.products
  end

  def favorite
    if current_user
      @proposal = Proposal.find(params[:id])
      UserMailer.welcome_email(current_user).deliver_later!
      @like = current_user.toggle_like_proposal(@proposal)

      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render :js => "window.location.pathname='#{new_user_session_path}'" }
      end
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
    @user = User.find_by_id(@proposal.user_id)
  end

  def proposal_params
    params.require(:proposal).permit(:name, :email, :phone, :self_intro, :title, :content, :category_id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
