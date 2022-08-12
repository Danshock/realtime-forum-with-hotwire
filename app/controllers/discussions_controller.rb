# frozen_string_literal: true

class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[show edit update destroy]

  def index
    @discussions = Discussion.all.order(updated_at: :desc)
  end

  def show; end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        @discussion.broadcast_replace(partials: 'discussions/header', locals: { discission: @discussion })
        format.html { redirect_to @discussion, notice: 'Discussion updated successfully' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: 'Discussion removed successfully'
  end

  private

  def discussion_params
    params.require(:discussion).permit(:name, :closed, :pinned)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end
