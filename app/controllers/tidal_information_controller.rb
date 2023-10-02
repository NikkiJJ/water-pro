class TidalInformationController < ApplicationController
  def show
    tidal_info = TidalInformation.find_by(station_name: params[:station_name])
    if tidal_info
      tidal_info.geocode
      @latitude = tidal_info.latitude
      @longitude = tidal_info.longitude
      authorize @tidal_information
    else
      authorize @tidal_information
    end
  end
end
