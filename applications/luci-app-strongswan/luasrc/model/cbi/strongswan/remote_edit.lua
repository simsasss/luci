-- Copyright 2019 Simonas Tamošaitis <tamosaitis.simonas@gmail.com>
-- Licensed to the public under the Apache License 2.0.

local m, s, o

m = Map("ipsec", translate("strongSwan remote settings"))
m.redirect = luci.dispatcher.build_url("admin/services/strongswan")

s = m:section(NamedSection, arg[1], "remote", translatef("\"%s\" - remote setup", arg[1]))

o = s:option(Flag, "enabled", translate("Enabled"))

o = s:option(Value, "gateway", translate("Remote endpoint"), translate("The IP address of the participant's public-network interface."))
o.placeholder = "any"
o.datatype = "host"

o = s:option(ListValue, "authentication_method", translate("Authentication method"), translate("Authentication method to use."))
o:value("psk", "Pre-shared key")
o.rmempty = false

o = s:option(Value, "pre_shared_key", translate("Pre shared key"))
o.password = true

o = s:option(Value, "local_identifier", translate("Local identifier"),translate("How the left participant should be identified for authentication."))
--~ o.datatype = "range(0,4)"

o = s:option(Value, "remote_identifier", translate("Remote identifier"), translate("How the right participant should be identified for authentication."))
--~ o.datatype = "range(0,4)"

o = s:option(DynamicList, "crypto_proposal", translate("IKE crypto proposal"))

m.uci:foreach("ipsec", "proposal",
	function(s)
		o:value(s['.name'], s['.name'])
	end
)

o = s:option(Flag, "force_crypto_proposal", translate("Force crypto proposal"))

o = s:option(DynamicList, "tunnel", translate("Remote tunnel"), translate("Use tunnel type connections."))
m.uci:foreach("ipsec", "connection",
	function(s)
		o:value(s['.name'], s['.name'])
	end
)

o = s:option(DynamicList, "transport", translate("Remote transport"), translate("Use transport type connections."))
m.uci:foreach("ipsec", "connection",
	function(s)
		o:value(s['.name'], s['.name'])
	end
)

return m
