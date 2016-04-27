# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "helpers/hasher"
require "helpers/text_tools"

# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::ShinglesHash < LogStash::Filters::Base

  # An example configuration
  #
  # filter {
  #   shingles_hash {
  #     input_field => "text_info"
  #     output_field => "text_info_shingles"
  #     k => 3
  #   }
  # }
  #
  config_name "shingles_hash"

  config :input_field, :validate => :string, :default => "shingles_out"
  config :output_field, :validate => :string, :default => "shingles_in"
  config :k, :validate => :number, :default => 3
  
  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    begin
      input_text = event[@input_field]
      text_shingles = TextTools::get_shingles(input_text, @k)
      hash_shingles = []
      for i in 0..(text_shingles.length() - 1)
        val = Hasher::do_hash(text_shingles[i], 'sha256').force_encoding(Encoding::UTF_8)[24..31].to_i(16)
        hash_shingles[i] = val
      end
      event[@output_field] = hash_shingles
    rescue Exception => e
      @logger.error("FUUUUUUU: " + e.message)
      event[@output_field] = nil
    end
    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::ShinglesHash
