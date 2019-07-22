-- Copyright 2019 Simonas Tamošaitis <tamosaitis.simonas@gmail.com>
-- Licensed to the public under the Apache License 2.0.

local ds = require("luci.dispatcher")
local s, m, o

m = Map("ipsec", translate("strongSwan"), translate("strongSwan is an OpenSource IPsec implementation."))

--~ --Crypto proposal, default values selected by NIST------------------ 

s = m:section(TypedSection, "proposal", translate("Proposal settings"))
s.addremove=true
s.template = "cbi/tblsection"

o = s:option(ListValue, "encryption_algorithm", translate("Encryption algorythm"))
o.default = "aes128"
o:value("3des", translate("3DES"))
o:value("aes128", translate("AES128"))
o:value("aes192", translate("AES192"))
o:value("aes192", translate("AES192"))
o:value("aes256", translate("AES256"))

o = s:option(ListValue, "hash_algorithm", translate("Hash algorythm"))
o.default = "sha256"
o:value("md5", translate("MD5"))
o:value("sha1", translate("SHA1"))
o:value("sha256", translate("SHA256"))
o:value("sha384", translate("SHA384"))
o:value("sha512", translate("SHA512"))

o = s:option(ListValue, "dh_group", translate("DH group"))
o:value("", translate("None"))
o:value("modp768", translate("MODP768"))
o:value("modp1024", translate("MODP1024"))
o:value("modp1536", translate("MODP1536"))
o:value("modp2048", translate("MODP2048"))
o:value("modp3072", translate("MODP3072"))
o:value("modp4096", translate("MODP4096"))
o:value("modp6144", translate("MODP6144"))
o:value("modp8192", translate("MODP8192"))

--~ Connection settings-------------------------------------------------

s = m:section(TypedSection, "connection", translate("Connection settings"))
s.addremove=true
s.template = "cbi/tblsection"
s.extedit = ds.build_url("admin", "services", "strongswan", "ipsec", "connection", "%s")

o = s:option(DummyValue, "mode", translate("Mode"))
o = s:option(DummyValue, "local_subnet", translate("Left subnet"))
o = s:option(DummyValue, "remote_subnet", translate("Right subnet"))
o = s:option(DummyValue ,"crypto_proposal", translate("Crypto proposal"))
o = s:option(DummyValue, "dpdaction", translate("DPD action"))
o = s:option(DummyValue, "keyexchange", translate("Keyexchange"))

--~ --Remote settings---------------------------------------------------

s = m:section(TypedSection, "remote", translate("Remote settings"))
s.addremove=true
s.template = "cbi/tblsection"
s.extedit = ds.build_url("admin", "services", "strongswan", "ipsec", "remote", "%s")

o = s:option(Flag, "enabled", translate("Enable"))
o = s:option(DummyValue, "gateway", translate("Remote peer"))
o = s:option(DummyValue, "authentication_method", translate("Auth method"))
o = s:option(DummyValue, "crypto_proposal", translate("Crypto proposal"))
o = s:option(DummyValue, "tunnel", translate("Tunnel"))
o = s:option(DummyValue, "transport", translate("Transport"))

return m
