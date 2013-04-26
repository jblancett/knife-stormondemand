#
# Author:: Josh Blancett
#

require 'chef/knife'

class Chef
	class Knife
		module StormBase

			def self.included(includer)
				includer.class_eval do

					deps do
						require 'fog'
						require 'readline'
						require 'chef/json_compat'
					end

					option :storm_on_demand_username,
						:short => "-U USERNAME",
						:long => "--storm-user",
						:description => "StormOnDemand api username",
						:proc => Proc.new { |key| Chef::Config[:knife][:storm_on_demand_username] = key }

					option :storm_on_demand_password,
						:short => "-P PASSWORD",
						:long => "--storm-pass",
						:description => "StormOnDemand api password",
						:proc => Proc.new { |key| Chef::Config[:knife][:storm_on_demand_password] = key }

				end
			end

			def connection
				@connection ||= begin
					connection = Fog::Compute.new({
						:provider => 'stormondemand',
						:storm_on_demand_username => locate_config_value(:storm_on_demand_username),
						:storm_on_demand_password => locate_config_value(:storm_on_demand_password)
					})
				end
			end

			def locate_config_value(key)
        key = key.to_sym
        config[key] || Chef::Config[:knife][key]
      end

      def msg_pair(label, value, color=:cyan)
        if value && !value.to_s.empty?
          puts "#{ui.color(label, color)}: #{value}"
        end
      end

      def validate!(keys=[:storm_on_demand_username, :storm_on_demand_password])
    		errors = []

    		keys.each do |k|
    			pretty_key = k.to_s.gsub(/_/, ' ').gsub(/\w+/){ |w| w.capitalize }
          if Chef::Config[:knife][k].nil?
            errors << "You did not provide a valid '#{pretty_key}' value."
          end
        end

        exit 1 if errors.each{ |e| ui.error(e) }.any?
      end

		end
	end
end
