class InvitationMailer < ActionMailer::Base
	default from: "mega-up@desaweb1.ing.puc.cl"
	
	def invitation_mail(up_file, event)
		@up_file = up_file
		@event = event
		@url = "desaweb1.ing.puc.cl" 
		mail(:to => @up_file.mail, :subject => "You have been invited to ")
	end
end
