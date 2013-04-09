require 'open-uri'
require 'uri'
require 'json'
require 'net/https'

class OauthController < ApplicationController

	def new_facebook
		facebook_settings = YAML::load(File.open("config/oauth.yml"))
		redirect_to "https://graph.facebook.com/oauth/authorize?client_id=#{facebook_settings['application_id']}&redirect_uri=http://desaweb1.ing.puc.cl/facebook_login&scope=email"
	end
	
	def facebook_oauth_callback
		if not params[:code].nil?
			facebook_settings = YAML::load(File.open("config/oauth.yml"))
			callback = "#{APP_URL}/facebook_credentials/facebook_oauth_callback"
			url = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{facebook_settings[RAILS_ENV]['application_id']}&redirect_uri=#{callback}&client_secret=#{facebook_settings[RAILS_ENV]['secret_key']}&code=#{CGI::escape(params[:code])}")
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = (url.scheme == 'https')
			tmp_url = url.path+"?"+url.query
			request = Net::HTTP::Get.new(tmp_url)
			response = http.request(request)     
			data = response.body
			access_token = data.split("=")[1]
			url = URI.parse("https://graph.facebook.com/me?access_token=#{CGI::escape(access_token)}")
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = (url.scheme == 'https')
			tmp_url = url.path+"?"+url.query
			request = Net::HTTP::Get.new(tmp_url)
			response = http.request(request)        
			user_data = response.body
			user_data_obj = JSON.parse(user_data)
			flash[:notice] = 'Facebook successfully connected.'
			@social_credential = SocialCredential.create_or_find_new_facebook_cred(access_token, session['rsecret'])
		end
	end
	
	def facebook_login
	
		if params[:code]
			@contents = open("https://graph.facebook.com/oauth/access_token?client_id=447261195351468&redirect_uri=http://desaweb1.ing.puc.cl/facebook_login&client_secret=0beaff15109c00b110fa3cf6663b9d5c&code=#{params[:code]}").read
			@access_token = @contents[@contents.index('=')+1..@contents.index('&')-1]
		
			@resp = open("https://graph.facebook.com/me?access_token=#{@access_token}").read
			@result = JSON.parse(@resp)
		
			if @result['email']
				if User.exists?(:mail => @result['email'])
					session[:user_id] = User.find_by_mail(@result['email'])
					@user = User.find_by_mail(@result['email'])
				else
					@user = User.new
					@user.mail = @result['email']
					@user.password = @result['id']
					if @user.save
						flash[:error] = "Un usuario has sido creado para el email #{@result['email']} con la contrase&ntilde;a temporal #{@result['id']}"
						session[:user_id] = @user.id
					else
						flash[:error] = "No se pudo ingresar"
					end
				end
			else
				flash[:error] = "No se pudo ingresar"
			end
		end
		redirect_to home_path
	end

end
