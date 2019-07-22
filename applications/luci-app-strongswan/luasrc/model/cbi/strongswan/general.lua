-- Copyright 2019 Simonas Tamošaitis <tamosaitis.simonas@gmail.com>
-- Licensed to the public under the Apache License 2.0.

local s, m, o

m = Map("ipsec", translate("strongSwan"), translate("strongSwan is an OpenSource IPsec implementation."))

s = m:section(TypedSection, "ipsec", translate("General settings"))
s.anonymous = true

o = s:option(Flag, "rtinstall_enabled", translate("Install routes"))
o.default = "1"
o.rmempty = false

o = s:option(Value, "ignore_routing_tables", translate("Routing table"))
o.placeholder = "220"

o = s:option( Value, "interface", translate("Interfaces"), translate("List of network interfaces that should be used by charon. All other interfaces are ignored."))
o.template = "cbi/network_netlist"
o.widget = "checkbox"
o.cast = "string"

return m
