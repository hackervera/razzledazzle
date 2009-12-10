class OpenidUsersController < ApplicationController
  def index
    @openid_users = OpenidUser.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @openid_users }
    end
  end

  def show
    @openid_user = OpenidUser.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @openid_user }
    end
  end

  def new
    @openid_user = OpenidUser.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @openid_user }
    end
  end

  def edit
    @openid_user = OpenidUser.find(params[:id])
  end

  def create
    @openid_user = OpenidUser.new(params[:openid_user])

    respond_to do |format|
      if @openid_user.save
        flash[:notice] = 'OpenidUser was successfully created.'
        format.html { redirect_to(@openid_user) }
        format.xml  { render :xml => @openid_user, :status => :created, :location => @openid_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @openid_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @openid_user = OpenidUser.find(params[:id])

    respond_to do |format|
      if @openid_user.update_attributes(params[:openid_user])
        flash[:notice] = 'OpenidUser was successfully updated.'
        format.html { redirect_to(@openid_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @openid_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @openid_user = OpenidUser.find(params[:id])
    @openid_user.destroy

    respond_to do |format|
      format.html { redirect_to(openid_users_url) }
      format.xml  { head :ok }
    end
  end

  def login
    openid_url = params[:openid_url]
    @user = OpenidUser.find_by_openid_url(openid_url)
    cookies[:openid] = @user.id unless @user.nil?
    if cookies[:openid].nil?
      redirect_to "http://www.clickpass.com/process_new_openid?site_key=7koO02B3Gc&process_openid_registration_url=http%3A%2F%2Flocalhost%3A3001%2Fsignup&requested_fields=nickname&required_fields=nickname&nickname_label=Nickname" if @user.nil?
    else
      redirect_to "/"
    end
  end

  def signup
    @user = OpenidUser.new
    @user.nickname = params[:nickname]
    @user.openid_url = params[:clickpass_openid]
    @user.save
    cookies[:openid] = @user.id
    redirect_to "/login?openid_url=#{@user.openid_url}"
  end
  
  def logout
    cookies.delete(:openid) if cookies[:openid]
    redirect_to "/"
  end

end
