-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class GTKHPANED_EXTERNALS


insert ANY undefine is_equal, copy end

		-- TODO: insert typedefs class
feature {} -- External calls

	gtk_hpaned_get_type: NATURAL_64 is
 		-- gtk_hpaned_get_type (node at line 22676)
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtk_hpaned_get_type()"
		}"
		end

	gtk_hpaned_new: POINTER is
 		-- gtk_hpaned_new (node at line 29077)
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtk_hpaned_new()"
		}"
		end


end -- class GTKHPANED_EXTERNALS