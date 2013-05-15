class AuthenticationsController < ApplicationController

	def create
	  auth = request.env["omniauth.auth"]
	  # Try to find authentication first
	  authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
 
  	if authentication
	    # Authentication found, sign the user in.
	    flash[:notice] = "Signed in successfully."
	    sign_in_and_redirect(:mahasiswa, authentication.mahasiswa)
  	else
    	# Authentication not found, thus a new user.
    	mahasiswa = Mahasiswa.new
    	mahasiswa.apply_omniauth(auth)
    	if mahasiswa.save(:validate => false)
	      flash[:notice] = "Account created and signed in successfully."
	      sign_in_and_redirect(:mahasiswa, mahasiswa)
    	else
	      flash[:error] = "Error while creating a mahasiswa account. Please try again."
	      redirect_to root_url
    	end
  	end
	end 

end
