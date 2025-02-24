class ProfilesController < ApplicationController
  def show
    @profile = Profile.find_or_create_by(name: "David")
  end
end
