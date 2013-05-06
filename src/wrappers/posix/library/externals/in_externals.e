-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class IN_EXTERNALS


insert ANY undefine is_equal, copy end

		-- TODO: insert typedefs class
feature {} -- External calls

	bindresvport (a_sockfd: INTEGER; a_sock_in: POINTER): INTEGER is
 		-- bindresvport
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "bindresvport"
		}"
		end

	bindresvport6 (a_sockfd: INTEGER; a_sock_in: POINTER): INTEGER is
 		-- bindresvport6
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "bindresvport6"
		}"
		end

	-- function getipv4sourcefilter (at line 592 in file /usr/include/netinet/in.h is not wrappable
	getsourcefilter (a_s: INTEGER; an_interface_add: like uint32_t; a_group: POINTER; a_grouplen: NATURAL; a_fmode: POINTER; a_numsrc: POINTER; a_slist: POINTER): INTEGER is
 		-- getsourcefilter
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "getsourcefilter"
		}"
		end

	htonl (a_hostlong: like uint32_t): like uint32_t is
 		-- htonl
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "htonl"
		}"
		end

	htons (a_hostshort: like uint16_t): like uint16_t is
 		-- htons
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "htons"
		}"
		end

	-- Variable in6addr_any (at line 215 in file /usr/include/netinet/in.h does not have a wrapper type
	address_of_in6addr_any: POINTER is
 		-- Address of in6addr_any
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&in6addr_any"
		}"
		end

	-- Variable in6addr_loopback (at line 216 in file /usr/include/netinet/in.h does not have a wrapper type
	address_of_in6addr_loopback: POINTER is
 		-- Address of in6addr_loopback
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&in6addr_loopback"
		}"
		end

	inet6_opt_append (an_extbu: POINTER; an_extle: NATURAL; an_offse: INTEGER; a_type: like uint8_t; a_len: NATURAL; an_alig: like uint8_t; a_databufp: POINTER): INTEGER is
 		-- inet6_opt_append
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_append"
		}"
		end

	inet6_opt_find (an_extbu: POINTER; an_extle: NATURAL; an_offse: INTEGER; a_type: like uint8_t; a_lenp: POINTER; a_databufp: POINTER): INTEGER is
 		-- inet6_opt_find
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_find"
		}"
		end

	inet6_opt_finish (an_extbu: POINTER; an_extle: NATURAL; an_offse: INTEGER): INTEGER is
 		-- inet6_opt_finish
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_finish"
		}"
		end

	inet6_opt_get_val (a_databuf: POINTER; an_offse: INTEGER; a_val: POINTER; a_vallen: NATURAL): INTEGER is
 		-- inet6_opt_get_val
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_get_val"
		}"
		end

	inet6_opt_init (an_extbu: POINTER; an_extle: NATURAL): INTEGER is
 		-- inet6_opt_init
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_init"
		}"
		end

	inet6_opt_next (an_extbu: POINTER; an_extle: NATURAL; an_offse: INTEGER; a_typep: POINTER; a_lenp: POINTER; a_databufp: POINTER): INTEGER is
 		-- inet6_opt_next
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_next"
		}"
		end

	inet6_opt_set_val (a_databuf: POINTER; an_offse: INTEGER; a_val: POINTER; a_vallen: NATURAL): INTEGER is
 		-- inet6_opt_set_val
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_opt_set_val"
		}"
		end

	inet6_option_alloc (a_cmsg: POINTER; a_datalen: INTEGER; a_multx: INTEGER; a_plusy: INTEGER): POINTER is
 		-- inet6_option_alloc
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_alloc"
		}"
		end

	inet6_option_append (a_cmsg: POINTER; a_typep: POINTER; a_multx: INTEGER; a_plusy: INTEGER): INTEGER is
 		-- inet6_option_append
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_append"
		}"
		end

	inet6_option_find (a_cmsg: POINTER; a_tptrp: POINTER; a_type: INTEGER): INTEGER is
 		-- inet6_option_find
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_find"
		}"
		end

	inet6_option_init (a_bp: POINTER; a_cmsgp: POINTER; a_type: INTEGER): INTEGER is
 		-- inet6_option_init
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_init"
		}"
		end

	inet6_option_next (a_cmsg: POINTER; a_tptrp: POINTER): INTEGER is
 		-- inet6_option_next
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_next"
		}"
		end

	inet6_option_space (a_nbytes: INTEGER): INTEGER is
 		-- inet6_option_space
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_option_space"
		}"
		end

	inet6_rth_add (a_bp: POINTER; an_add: POINTER): INTEGER is
 		-- inet6_rth_add
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_add"
		}"
		end

	inet6_rth_getaddr (a_bp: POINTER; an_inde: INTEGER): POINTER is
 		-- inet6_rth_getaddr
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_getaddr"
		}"
		end

	inet6_rth_init (a_bp: POINTER; a_bp_len: NATURAL; a_type: INTEGER; a_segments: INTEGER): POINTER is
 		-- inet6_rth_init
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_init"
		}"
		end

	inet6_rth_reverse (an_i: POINTER; an_out_external: POINTER): INTEGER is
 		-- inet6_rth_reverse
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_reverse"
		}"
		end

	inet6_rth_segments (a_bp: POINTER): INTEGER is
 		-- inet6_rth_segments
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_segments"
		}"
		end

	inet6_rth_space (a_type: INTEGER; a_segments: INTEGER): NATURAL is
 		-- inet6_rth_space
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "inet6_rth_space"
		}"
		end

	ntohl (a_netlong: like uint32_t): like uint32_t is
 		-- ntohl
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "ntohl"
		}"
		end

	ntohs (a_netshort: like uint16_t): like uint16_t is
 		-- ntohs
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "ntohs"
		}"
		end

	-- function setipv4sourcefilter (at line 599 in file /usr/include/netinet/in.h is not wrappable
	setsourcefilter (a_s: INTEGER; an_interface_add: like uint32_t; a_group: POINTER; a_grouplen: NATURAL; a_fmode: like uint32_t; a_numsrc: like uint32_t; a_slist: POINTER): INTEGER is
 		-- setsourcefilter
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "setsourcefilter"
		}"
		end


end -- class IN_EXTERNALS
