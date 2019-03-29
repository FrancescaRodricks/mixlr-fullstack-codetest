require 'open-uri'
require 'json'

module Mixlr::Fullstack::Importer
  class FileReadError < StandardError; end
  class ObjectParseError < StandardError; end

  FILE_PATH = 'https://mixlr-codetest.herokuapp.com/streams/netil-radio'

  def read_file
    open(FILE_PATH).read
  rescue StandardError => error
    raise FileReadError.new("\n Error while reading remote file, #{ error.message }")
  end

  def parse(object)
    JSON.parse(object)
  rescue StandardError => error
    raise ObjectParseError.new("\n JSON parse error, #{error.message}")
  end
end
