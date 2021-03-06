class ApplyItemsController < ApplicationController

  include AccessHelper
  layout_by_action "access", [:index] => "public"
  before_action :confirm_logged_in, :except => [:index, :admin]

  def index
    @apply_items = ApplyItem.first_to_last
  end

  def admin
    @apply_items = ApplyItem.first_to_last
    @new_apply_item = ApplyItem.new(:position => 0)
  end

  def create
    @apply_item = ApplyItem.new(apply_item_params)
    @apply_item.position = 1
    if @apply_item.save
      flash[:type] = 'good'
      flash[:notice] = "Application requirement was created!"
      redirect_to(:action => 'admin')
    else
      flash[:notice] = errors_for(@apply_item)
      flash[:type] = 'bad'
      redirect_to(:action => 'admin')
    end
  end

  def update
    @apply_item = ApplyItem.find(params[:id])
    if @apply_item.update_attributes(apply_item_params)
      flash[:type] = 'good'
      flash[:notice] = "Application requirement was updated!"
      redirect_to(:action => 'admin')
    else
      flash[:type] = 'bad'
      flash[:notice] = errors_for(@apply_item)
      redirect_to(:action => 'admin')
    end
  end

  def delete
    @apply_item = ApplyItem.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'delete', :locals => {:apply_item => @apply_item} }
    end
  end

  def destroy
    @apply_item = ApplyItem.find(params[:id]).destroy
    flash[:type] = 'good'
    flash[:notice] = "Application requirement was deleted!"
    redirect_to(:action => 'admin')
  end

  private

    def apply_item_params
      params.require(:apply_item).permit(:text, :position)
    end

end
