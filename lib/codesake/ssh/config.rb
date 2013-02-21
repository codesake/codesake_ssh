require 'yaml'
require 'singleton'

module Codesake
  module SSH
    class Config
      include Singleton
      attr_reader :config

      def self.read_conf(filename)
        self.instance.read_conf(filename)
      end

      def self.ports
        self.instance.config["config"]["ports_to_scan"]
      end

      def self.passwords
        self.instance.config["config"]["password_list"]
      end


      def read_conf(filename)
        @config = {"config"=>{"ports_to_scan"=>[22], "password_list"=>"root,password"}}
        @filename = nil
        @filename = filename if ! filename.nil? and File.exists?(filename)

        @config = YAML.load_file(conf_file) unless @filename.nil?

        @config["config"]["password_list"] = @config["config"]["password_list"].split(',')
        @config
      end



    end
  end
end

