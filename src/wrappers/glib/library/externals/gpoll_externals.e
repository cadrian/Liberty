-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.

deferred class GPOLL_EXTERNALS


inherit ANY undefine is_equal, copy end

feature {} -- External calls

	g_poll (a_fds: POINTER; a_nfds: NATURAL_32; a_timeout: INTEGER_32): INTEGER_32 is
 		-- g_poll
		external "plug_in"
		alias "{
			location: "../../../plugins"
			module_name: "glib"
			feature_name: "g_poll"
		}"
		end

end