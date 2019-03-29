require 'open3'

module Mixlr::Fullstack::FilterAudioVolume
  class CommandNotFoundError < StandardError; end

  def filter(object)
    mean_and_max_volume = {}

    object['streams'].each do |stream, url|
      cmd = "ffmpeg -t 5 -i #{url} -af 'volumedetect' -f null /dev/null"
      mean_and_max_volume[stream] ||= {}

      Open3.popen3(cmd) do |stdin, stdout, stderr|
        while line = stderr.gets
          if line.match /mean_volume/
            mean_and_max_volume[stream].merge!({ "mean_volume" => line.split[-2] })
          elsif line.match /max_volume/
            mean_and_max_volume[stream].merge!({ "max_volume" => line.split[-2] })
          end
        end
      end
    end
    mean_and_max_volume

    rescue StandardError => error
      raise CommandNotFoundError.new("#{error}")
  end
end
