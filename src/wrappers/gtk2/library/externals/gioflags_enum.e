-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class GIOFLAGS_ENUM

-- TODO emit_description(class_descriptions.reference_at(an_enum_name))

insert ENUM

creation default_create
feature -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = append_low_level)  or else
				(a_value = nonblock_low_level)  or else
				(a_value = is_readable_low_level)  or else
				(a_value = is_writable_low_level)  or else
				(a_value = is_seekable_low_level)  or else
				(a_value = mask_low_level)  or else
				(a_value = get_mask_low_level)  or else
				(a_value = set_mask_low_level) )
		end

feature -- Setters
	default_create,
	set_append is
		do
			value := append_low_level
		end

	set_nonblock is
		do
			value := nonblock_low_level
		end

	set_is_readable is
		do
			value := is_readable_low_level
		end

	set_is_writable is
		do
			value := is_writable_low_level
		end

	set_is_seekable is
		do
			value := is_seekable_low_level
		end

	set_mask is
		do
			value := mask_low_level
		end

	set_get_mask is
		do
			value := get_mask_low_level
		end

	set_set_mask is
		do
			value := set_mask_low_level
		end

feature -- Queries
	append: BOOLEAN is
		do
			Result := (value=append_low_level)
		end

	nonblock: BOOLEAN is
		do
			Result := (value=nonblock_low_level)
		end

	is_readable: BOOLEAN is
		do
			Result := (value=is_readable_low_level)
		end

	is_writable: BOOLEAN is
		do
			Result := (value=is_writable_low_level)
		end

	is_seekable: BOOLEAN is
		do
			Result := (value=is_seekable_low_level)
		end

	mask: BOOLEAN is
		do
			Result := (value=mask_low_level)
		end

	get_mask: BOOLEAN is
		do
			Result := (value=get_mask_low_level)
		end

	set_mask: BOOLEAN is
		do
			Result := (value=set_mask_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	append_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_APPEND"
 			}"
 		end

	nonblock_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_NONBLOCK"
 			}"
 		end

	is_readable_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_IS_READABLE"
 			}"
 		end

	is_writable_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_IS_WRITABLE"
 			}"
 		end

	is_seekable_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_IS_SEEKABLE"
 			}"
 		end

	mask_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_MASK"
 			}"
 		end

	get_mask_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_GET_MASK"
 			}"
 		end

	set_mask_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "G_IO_FLAG_SET_MASK"
 			}"
 		end


end -- class GIOFLAGS_ENUM
