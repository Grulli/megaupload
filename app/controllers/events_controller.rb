class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
	if session[:user_id]
		@events = Event.find_all_by_user_id(session[:user_id])

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @events }
		end
	else
		redirect_to home_path
	end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

	if @event.user_id == session[:user_id]
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @event }
		end
	else
		redirect_to home_path
	end
  end

  # GET /events/new
  # GET /events/new.json
  def new
	if session[:user_id]
		@event = Event.new
		@event.user_id = session[:user_id]
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @event }
		end
	else
		redirect_to home_path
	end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
	if session[:user_id]
		@event = Event.new(params[:event])
		@event.user_id = session[:user_id]

		respond_to do |format|
			if @event.save
				@event.guest_list.split(';').each do |g|
					@up_file = UpFile.new()
					@up_file.mail = g.delete(' ')
					@up_file.event_id = @event.id
					if @up_file.save
						begin
							InvitationMailer.invitation_mail(@up_file, @event).deliver
						rescue Exception => e
						end
					end
				end
				#redirect_to home_path
				format.html { redirect_to @event, notice: 'Evento fue creado exitosamente.' }
				format.json { render json: @event, status: :created, location: @event }
			else
				format.html { render action: "new" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	else
		redirect_to home_path
	end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

	if session[:user_id] == @event.user_id
		respond_to do |format|
			if @event.update_attributes(params[:event])
				format.html { redirect_to @event, notice: 'Evento fue actualizado con &eacute;xito.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	else
		redirect_to home_path
	end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
	if @event.user_id == session[:user_id]
		@event.destroy
	end
	
	redirect_to home_path
	
    #respond_to do |format|
    #  format.html { redirect_to events_url }
    #  format.json { head :no_content }
    #end
  end
end
