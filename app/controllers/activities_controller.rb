class ActivitiesController < ApplicationController
  before_filter :exclude_production
  
  def index
    @activities = Activity.all
  end

  def show
    redirect_to activities_path
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])

    if @activity.save
      flash[:notice] = 'Activity was successfully created.'
      redirect_to activities_path
    else
      render :action => "new"
    end
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity was successfully updated.'
      redirect_to activities_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to activities_path
  end
  
  private
  def exclude_production
    if RAILS_ENV == "production"
      redirect_to activities_path
    end
  end
end
