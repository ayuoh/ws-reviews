class OrganizersController < ApplicationController
  def search
    @organizers = Organizer.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end
end
