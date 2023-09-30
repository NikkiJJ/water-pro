class TidalInformationsController < ApplicationController
  def show
    # Find a TidalInformation record by some criteria (e.g., station_name)
    tidal_info = TidalInformation.find_by(station_name: params[:station_name])

    # Check if the record exists
    if tidal_info
      # Call geocode to populate latitude and longitude
      tidal_info.geocode

      # Now, you can access the coordinates
      @latitude = tidal_info.latitude
      @longitude = tidal_info.longitude
    else
      # Handle the case where the record doesn't exist
      # You might want to render an error message or perform some other action
    end
  end
end
