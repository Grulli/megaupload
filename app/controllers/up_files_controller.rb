class UpFilesController < ApplicationController
  # GET /up_files
  # GET /up_files.json
  def index
	if session[:user_id]
		@up_files = UpFile.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @up_files }
		end
	else
		redirect_to home_path
	end
  end

  # GET /up_files/1
  # GET /up_files/1.json
  def show
    @up_file = UpFile.find(params[:id])
	if @up_file.event.user.id == session[:user_id]
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @up_file }
		end
	else
		redirect_to home_path
	end
  end

  # GET /up_files/new
  # GET /up_files/new.json
  def new
    @up_file = UpFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @up_file }
    end
  end

  # GET /up_files/1/edit
  def edit
    @up_file = UpFile.find(params[:id])
  end

  # POST /up_files
  # POST /up_files.json
  def create
    @up_file = UpFile.new(params[:up_file])

    respond_to do |format|
      if @up_file.save
        format.html { redirect_to @up_file, notice: 'Archivo de subida creado con &eacute;xito.' }
        format.json { render json: @up_file, status: :created, location: @up_file }
      else
        format.html { render action: "new" }
        format.json { render json: @up_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /up_files/1
  # PUT /up_files/1.json
  def update
    @up_file = UpFile.find(params[:id])

      if @up_file.update_attributes(params[:up_file])
        redirect_to home_path
      else
	respond_to do |format|
        	format.html { render action: "edit" }
        	format.json { render json: @up_file.errors, status: :unprocessable_entity }
      	end
     end
  end

  # DELETE /up_files/1
  # DELETE /up_files/1.json
  def destroy
    @up_file = UpFile.find(params[:id])
    @up_file.destroy

    respond_to do |format|
      format.html { redirect_to up_files_url }
      format.json { head :no_content }
    end
  end
  
	def upload
		if !params[:mail] or !params[:event] or !params[:token]
			flash[:error] = "Link equivocado."
			redirect_to home_path
		else
			if !UpFile.exists?(:mail=> params[:mail], :event_id => params[:event])
				flash[:error] = "Link equivocado."
				redirect_to home_path
			else
				@up_file = UpFile.find_by_mail_and_event_id(params[:mail],params[:event])
				if @up_file.gen_token == params[:token]
					render 'upload.html'
				else
					flash[:error] = "Link equivocado."
					redirect_to home_path
				end
			end
		end
	end
  

  
end
