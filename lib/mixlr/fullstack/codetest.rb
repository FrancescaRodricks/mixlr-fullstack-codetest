require "mixlr/fullstack/codetest/version"
require 'thor'
require "mixlr/fullstack/volume_level_detection"

module Mixlr::Fullstack::Codetest
  class Error < StandardError; end
  class CLI < Thor
    desc "volume-level-detection", "Retrieves stream information"
    long_desc <<-LONGDESC
    `volume-level-detection`

    Retrieves the stream informations from the endpoint https://mixlr-codetest.herokuapp.com/streams/netil-radio

    Gathers the mean_volume and max_volume informations of each stream using ffmpeg

    Prints the values for each Stream of the Station

    > $ volume-level-detection

    LONGDESC

    def volume_level_detection
      volume_level_detection = ::Mixlr::Fullstack::VolumeLevelDetection.new
      volume_level_detection.print_station_output_for(volume_level_detection.streams)
    end
  end
end
