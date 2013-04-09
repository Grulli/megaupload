require "base64"

class HomeController < ApplicationController

	def index
		if params[:commit] == "Login"
			if User.exists?(:mail => params[:mail])
				@user = User.find_by_mail(params[:mail])
				if @user.password == Base64.encode64(params[:password])
					session[:user_id] = @user.id
				else
					flash.now[:error] = "Nombre de usuario o contrase&ntilde;a equivocado"
				end
			else
				flash.now[:error] = "Nombre de usuario o contrase&ntilde;a equivocado"
			end
		else 
			if params[:commit] == "Sign Up"
				redirect_to "/users/new"
			else
				render "index.html.erb"
			end
		end
	end
	
	def logout
		reset_session
		render "index.html.erb"
	end

end
