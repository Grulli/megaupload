class InvitationMailer < ActionMailer::Base
	default from: "mega-up@desaweb1.ing.puc.cl"
	
	def invitation_mail(up_file, event)
		@up_file = up_file
		@event = event
		@url = upload_path #+ "?mail=#up_file.mail&event=#event.id&token=up_file.gen_token()"
		mail(:to => up_file.mail, :subject => "You have been invited to ")# + event.name)
	end
end
