indexing
	description: "Styles -- Functions for drawing widget parts"
	copyright: "[
					Copyright (C) 2006 eiffel-libraries team, GTK+ team
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
			]"

class GTK_STYLE

	-- The C structure associated to this wrapper
	-- represents a widget's style.  As such
	-- it shouldn't be freed by our code, but
	-- shall be freed by C when the widget is freed.

inherit
	GTK_STYLE_EXTERNALS
	SHARED_C_STRUCT
		redefine from_external_pointer end

insert
	GTK_STATE_TYPE

creation
	from_external_pointer, make

feature -- size

	struct_size: INTEGER is
		external "C inline use <gtk/gtk.h>"
		alias "sizeof(GtkStyle)"
		end

feature -- Operations

	from_external_pointer (a_ptr: POINTER) is
		do
			Precursor (a_ptr)
			is_shared := True
		end

	set_background_pixmap (a_pixmap: GDK_PIXMAP; a_state: INTEGER) is
		require
			is_valid_gtk_state_type (a_state)
		do
			gtk_style_set_background(handle, a_pixmap.handle, a_state)
		end

end -- class GTK_STYLE
