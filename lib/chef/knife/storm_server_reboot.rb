#
# Author: Josh Blancett
#

class Chef
	class Knife
		class StormServerReboot < Knife

			include Knife::StormBase

			banner "knife storm server reboot STORM_ID|STORM_FQDN (options)"

			def run

				validate!
				ui.warn("Nothing to do because no server id or fqdn is specified") if @name_args.empty?

				@name_args.each do |storm_id|

					begin
						server = connection.servers.detect do |s|
							s.uniq_id == storm_id || s.domain == storm_id
						end

						msg_pair("Storm ID", server.uniq_id)
						msg_pair("FQDN", server.domain)
						msg_pair("IP", server.ip)
						msg_pair("Status", server.status['status'])

						puts "\n"
						confirm("Do you really want to reboot this server")

						server.reboot
						ui.warn("Rebooted server #{storm_id}")
					rescue Fog::Compute::StormOnDemand::NotFound
						ui.error("Could note locate server #{storm_id}")
					end

				end
 
			end
		end
	end
end
