-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class PANGO_GLYPH_GEOMETRY_STRUCT

insert STANDARD_C_LIBRARY_TYPES

	PANGO_TYPES
feature {} -- Low-level setters

	pango_glyph_geometry_struct_set_width (a_structure: POINTER; a_value: INTEGER_32) is
			-- Setter for width field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_set_width"
		}"
		end

	pango_glyph_geometry_struct_set_x_offset (a_structure: POINTER; a_value: INTEGER_32) is
			-- Setter for x_offset field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_set_x_offset"
		}"
		end

	pango_glyph_geometry_struct_set_y_offset (a_structure: POINTER; a_value: INTEGER_32) is
			-- Setter for y_offset field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_set_y_offset"
		}"
		end

feature {} -- Low-level queries

	pango_glyph_geometry_struct_get_width (a_structure: POINTER): INTEGER_32 is
			-- Query for width field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_get_width"
		}"
		end

	pango_glyph_geometry_struct_get_x_offset (a_structure: POINTER): INTEGER_32 is
			-- Query for x_offset field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_get_x_offset"
		}"
		end

	pango_glyph_geometry_struct_get_y_offset (a_structure: POINTER): INTEGER_32 is
			-- Query for y_offset field of PANGO_GLYPH_GEOMETRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "pango_glyph_geometry_struct_get_y_offset"
		}"
		end

feature -- Structure size
	struct_size: like size_t is
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "sizeof__PangoGlyphGeometry"
		}"
		end

end -- class PANGO_GLYPH_GEOMETRY_STRUCT
-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

