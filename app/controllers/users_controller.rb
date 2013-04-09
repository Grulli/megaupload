require "base64"

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
	redirect_to home_path
    #@users = User.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @users }
    #end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
	if !session[:user_id]
		@user = User.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @user }
		end
	else
		redirect_to home_path
	end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
	if !session[:user_id]
		@rand = params[:captcha_random].to_s
		@rand = @rand.from(11).to_i
		@answer = params[:captcha].to_s.from(64)[0..-3]
		@captcha_value = open("http://captchator.com/captcha/check_answer/#{@rand}/#{@answer}").read.to_i
		
		
		@user = User.new(params[:user])
		@user.password = Base64.encode64(@user.password)
		@user.password_confirmation = Base64.encode64(@user.password_confirmation)
			
		if @captcha_value == 1
			respond_to do |format|
				if @user.save
					flash[:error] = "Welcome to megaupload"
					session[:user_id] = @user.id
		
					format.html { redirect_to home_path }
					format.json { render json: @user, status: :created, location: @user }
				else
					format.html { render action: "new" }
					format.json { render json: @user.errors, status: :unprocessable_entity }
				end
			end
		else
			@user.errors.add(:captcha, "invalido")
			respond_to do |format|
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	else
		redirect_to home_path
	end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
	if params[:id] == session[:user_id]
		@user = User.find(params[:id])
		@user.destroy
		reset_session
	end
	redirect_to home_path
    #respond_to do |format|
    #  format.html { redirect_to users_url }
    #  format.json { head :no_content }
    #end
  end
end
