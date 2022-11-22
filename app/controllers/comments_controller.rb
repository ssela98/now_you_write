# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment
  before_action :forbidden_unless_creator, only: %i[edit update destroy]

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = I18n.t('comments.notices.successfully_updated')

        format.turbo_stream { render turbo_stream: turbo_stream.prepend('flash', partial: 'shared/flash') }
        format.html { redirect_to @comment }
      else
        flash.now[:alert] = I18n.t('comments.errors.failed_to_update')

        format.turbo_stream { render turbo_stream: turbo_stream.prepend('flash', partial: 'shared/flash') }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = I18n.t('comments.notices.successfully_destroyed')
      format.turbo_stream { render turbo_stream: turbo_stream.prepend('flash', partial: 'shared/flash') }
      format.html { redirect_to @comment.commentable }
    end
  end

  private

  # Do not allow edit, update or destroy changes if the logged in user
  # is not the creator of the story
  def forbidden_unless_creator
    return if current_user == @comment.user

    flash.now[:alert] = I18n.t('stories.alerts.not_the_creator')
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.prepend('flash', partial: 'shared/flash') }
      format.html { redirect_to @comment.commentable }
    end
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
