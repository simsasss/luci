-- Copyright 2019 Simonas Tamošaitis <tamosaitis.simonas@gmail.com>
-- Licensed to the public under the Apache License 2.0.

local m, s, o

m = Map("ipsec", translate("strongSwan connection settings"))
m.redirect = luci.dispatcher.build_url("admin/services/strongswan")

s = m:section(NamedSection, arg[1], "conn", translatef("Connection \"%s\" setup", arg[1]))
	
o = s:option(ListValue, "mode", translate("Mode"), translate("What operation, if any, should be done automatically at IPsec startup."))
o:value("route", "Route")
o:value("start", "Start")
o:value("add", "Add")
o:value("ignore", "Ignore")

o = s:option(Value, "local_subnet", translate("Left subnet"), translate("Private subnet behind the left participant, expressed as network/netmask."))
o.datatype = "ipaddr"

o = s:option(Flag, "local_firewall", translate("Left firewall"))
o.enabled = "yes"
o.disabled = "no"
o.default = "yes"

o = s:option(Value, "remote_subnet", translate("Right subnet"), translate("Private subnet behind the right participant, expressed as network/netmask."))
o.datatype = "ipaddr"

o = s:option(Flag, "remote_firewall", translate("Right firewall"))
o.enabled = "yes"
o.disabled = "no"

o = s:option(ListValue, "keyexchange", translate("Keyexchange"), translate("Method of key exchange, which protocol should be used to initialize the connection."))
o:value("ikev1", "IKEv1")
o:value("ikev2", "IKEv2")
o.info = "Passthrough and Bridge modes are disabled when multiwan is enabled"

o = s:option(Value, "ikelifetime", translate("IKE lifetime"), translate("How long the keying channel of a connection (ISAKMP or IKE SA) should last before being renegotiated."))
o.placeholder = "3h"

o = s:option(Value, "lifetime", translate("Lifetime"), translate("How long a particular instance of a connection (a set of encryption/authentication keys for user packets)\
should last, from successful negotiation to expiry."))
o.placeholder = "1h"

o = s:option(Value, "inactivity", translate("Inactivity"), translate("Defines the timeout interval, after which a CHILD_SA is closed if it did not send or receive any traffic."))
o.placeholder = "none"

o = s:option(Flag, "_dpd", translate("Dead peer detection"))

o = s:option(ListValue, "dpdaction", translate("DPD action"), translate("controls the use of the Dead Peer Detection protocol where notification messages\
 are periodically sent in order to check the liveliness of the IPsec peer."))
o:depends("_dpd",1)
o:value("none", "None")
o:value("clear", "Clear")
o:value("hold", "Hold")
o:value("restart", "Restart")

o = s:option(Value, "dpddelay", translate("DPD delay"), translate("defines the period time interval with which R_U_THERE messages/INFORMATIONAL exchanges are sent to the peer."))
o.placeholder = "30s"
o:depends("_dpd",1)

o = s:option(DynamicList, "crypto_proposal", translate("ESP crypto proposal"))

m.uci:foreach("ipsec", "proposal",
	function(s)
		o:value(s['.name'], s['.name'])
	end
)

o = s:option(Flag, "force_crypto_proposal", translate("Force crypto proposal"))

return m
