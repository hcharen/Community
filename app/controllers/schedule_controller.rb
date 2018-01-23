class ScheduleController < ApplicationController

  def google_map(center)
  "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
end

  def index
    
  end

  def show
  end

  private

  def store_params
     params.require(:store).permit(:name, :latitude, :longitude)
   end

end
