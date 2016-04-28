# encoding: utf-8
require 'spec_helper'
require "logstash/filters/shingles_hash"

describe LogStash::Filters::ShinglesHash do
  describe "Some text" do
    let(:config) do <<-CONFIG
      filter {
        shingles_hash {
          input_field => "msg"
          output_field => "msg_hash"
          k => 3
        }
      }
    CONFIG
    end

    sample("msg" => "Hola como estas") do
      expect(subject).to include("msg_hash")
      print subject["msg_hash"]
      puts "\n"
    end

    sample("msg" => "") do
      expect(subject).to include("msg_hash")
      print subject["msg_hash"]
      puts "\n"
    end

    sample("msg" => nil) do
      expect(subject).to include("msg_hash")
      print subject["msg_hash"]
      puts "\n"
    end
  end
end
