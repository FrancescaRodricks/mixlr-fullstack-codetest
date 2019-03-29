require_relative  "#{__dir__}/importer"
require_relative  "#{__dir__}/filter_audio_volume"
require_relative  "#{__dir__}/stream"

class Mixlr::Fullstack::VolumeLevelDetection
  include Mixlr::Fullstack::Importer
  include Mixlr::Fullstack::FilterAudioVolume

  def initialize
    stream = parse read_file
    @result = filter(stream)
    @streams ||= []
  end

  def add_streams(stream)
    @streams.push(stream)
  end

  def streams
    @result.each do |stream, volume|
      add_streams Mixlr::Fullstack::Stream.new(stream, volume['mean_volume'], volume['max_volume'])
    end
    @streams
  end

  def print_station_output_for(streams)

    puts "\n\n -------------------- STATION INFORMATION-------------------- \n\n"

    streams.each do |stream|
      puts "\n STREAM- #{stream.name} | MEAN VOLUME #{stream.mean_volume} | MAX VOLUME #{stream.max_volume} \n\n"
    end

    puts "\n\n -------------------- END STATION INFORMATION---------------- \n\n"
  end
end