#
# Author: Josh Blancett
#

class Chef
	class Knife
		class StormServerList < Knife

			include Knife::StormBase

			banner "knife storm server list (options)"

			def run

				$stdout.sync = true

				validate!

				server_list = [
					ui.color('Storm ID', :bold),
					ui.color('FQDN', :bold),
					ui.color('IP', :bold),
					ui.color('Region', :bold),
					ui.color('Zone', :bold),
					ui.color('Flavor', :bold)
				]
				column_count = server_list.count

				connection.servers.each do |server|
					server_list << server.uniq_id
					server_list << server.domain
					server_list << server.ip
					server_list << server.zone["region"]["name"]
					server_list << server.zone["name"]
					server_list << server.config_description
				end

				puts ui.list(server_list, :uneven_columns_across, column_count)
 
			end
		end
	end
end
