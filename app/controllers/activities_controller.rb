class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    if cookies[:openid]
      @user=OpenidUser.find(cookies[:openid])
    end
  end

  def show
    redirect_to activities_url
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
      redirect_to activities_url
    else
      render :action => "new"
    end
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity was successfully updated.'
      redirect_to activities_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to activities_url
  end
end
