class UpFilesController < ApplicationController
  # GET /up_files
  # GET /up_files.json
  def index
    @up_files = UpFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @up_files }
    end
  end

  # GET /up_files/1
  # GET /up_files/1.json
  def show
    @up_file = UpFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @up_file }
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
        format.html { redirect_to @up_file, notice: 'Up file was successfully created.' }
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

    respond_to do |format|
      if @up_file.update_attributes(params[:up_file])
        format.html { redirect_to @up_file, notice: 'Up file was successfully updated.' }
        format.json { head :no_content }
      else
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
end
