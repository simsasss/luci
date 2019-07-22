-- Copyright 2019 Simonas Tamošaitis <tamosaitis.simonas@gmail.com>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.strongswan", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ipsec") then
		return
	end
	
	entry({"admin", "services", "strongswan"}, alias("admin", "services", "strongswan", "ipsec"), _("strongSwan"), 600)
	
	entry({"admin", "services", "strongswan", "general"}, cbi("strongswan/general"), _("General settings"),10)
	entry({"admin", "services", "strongswan", "ipsec"}, cbi("strongswan/strongswan"), _("Connection configuration"),20)
	entry({"admin", "services", "strongswan", "ipsec", "connection"}, cbi("strongswan/connection_edit")).leaf=true
	entry({"admin", "services", "strongswan", "ipsec", "remote"}, cbi("strongswan/remote_edit")).leaf=true
end
