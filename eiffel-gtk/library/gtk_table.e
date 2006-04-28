indexing
	description: "GtkTable -- Pack widgets in regular patterns."
	copyright: "(C) 2006 Paolo Redaelli <paolo.redaelli@poste.it>"
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision: "$Revision:$"

	
			-- Description
	
			-- The GtkTable functions allow the programmer to arrange widgets in
			-- rows and columns, making it easy to align many widgets next to each
			-- other, horizontally and vertically.
	
			-- Tables are created with a call to gtk_table_new(), the size of which
			-- can later be changed with gtk_table_resize().

			-- Widgets can be added to a table using gtk_table_attach() or the more
			-- convenient (but slightly less flexible) gtk_table_attach_defaults().

			-- To alter the space next to a specific row, use
			-- gtk_table_set_row_spacing(), and for a column,
			-- gtk_table_set_col_spacing().

			-- The gaps between all rows or columns can be changed by calling
			-- gtk_table_set_row_spacings() or gtk_table_set_col_spacings()
			-- respectively.

			-- gtk_table_set_homogeneous(), can be used to set whether all cells in
			-- the table will resize themselves to the size of the largest widget
			-- in the table.
	
			-- The GtkTable structure holds the data for the actual table itself.
			-- children is a GList of all the widgets the table contains. rows and
			-- columns are pointers to GtkTableRowCol structures, which contain the
			-- default spacing and expansion details for the GtkTable's rows and
			-- columns, respectively.

			-- nrows and ncols are 16bit integers storing the number of rows and
			-- columns the table has.

	
class GTK_TABLE
inherit GTK_CONTAINER
	-- GtkTable implements AtkImplementorIface interface asasdasd
insert GTK_ATTACH_OPTIONS
creation make

feature {NONE} -- Creation
	make (rows, columns: INTEGER; homogeneus: BOOLEAN) is
			-- Used to create a new table widget. An initial size must be given by
			-- specifying how many rows and columns the table should have, although
			-- this can be changed later with `resize'. rows and columns must both
			-- be in the range 0 .. 65535.
		
			-- rows : The number of rows the new table should have.
		
			-- columns :     The number of columns the new table should have.
		
			-- homogeneous : If set to TRUE, all table cells are resized to the
			-- size of the cell containing the largest widget.

			-- Note: rows and columns shall be a NATURAL_16
		require
			rows_fits_natural_16: rows.in_range (0,65535)
			columns_fits_natural_16: columns.in_range (0,65535)				  
		do
			handle :=gtk_table_new (rows, columns, homogeneous)
		end
	
feature
	resize (rows, columns: INTEGER) is
			-- If you need to change a table's size after it has been created, this
			-- function allows you to do so.

			-- rows : The new number of rows.
			-- columns : The new number of columns.
		require
			rows_fits_natural_16: rows.in_range (0,65535)
			columns_fits_natural_16: columns.in_range (0,65535)				  
		do
			handle:=gtk_table_resize (handle, rows, columns)
		end

	attach (a_child: GTK_WIDGET; left_attach, right_attach, top_attach, bottom_attach: INTEGER;
			  xoptions, yoptions: INTEGER; xpadding, ypadding: INTEGER) is
			-- Adds a widget to a table. The number of 'cells' that a widget will
			-- occupy is specified by left_attach, right_attach, top_attach and
			-- bottom_attach. These each represent the leftmost, rightmost,
			-- uppermost and lowest column and row numbers of the table. (Columns
			-- and rows are indexed from zero).

			-- `a_child': The widget to add.
		
			-- `left_attach': the column number to attach the left side of a child
			-- widget to.

			-- `right_attach': the column number to attach the right side of a
			-- child widget to.

			-- `top_attach': the row number to attach the top of a child widget to.
			-- `bottom_attach': the row number to attach the bottom of a child
			-- widget to.

			-- `xoptions' : Used to specify the properties of the child widget when
			-- the table is resized.

			-- `yoptions': The same as xoptions, except this field determines
			-- behaviour of vertical resizing.

			-- `xpadding': An integer value specifying the padding on the left and
			-- right of the widget being added to the table.

			-- `ypadding': The amount of padding above and below the child widget.
		require
			valid_child: a_child /= Void
			valid_x_options: are_valid_gtk_attack_options(xoptions)
			valid_y_options: are_valid_gtk_attack_options(yoptions)
			left_attach_fits_natural_16: left_attach.in_range (0,65535)
			right_attach_fits_natural_16: right_attach.in_range (0,65535)
			top_attach_fits_natural_16: top_attach.in_range (0,65535)
			bottom_attach_fits_natural_16: bottom_attach.in_range (0,65535)
		do
			gtk_table_attach (handle, a_child.handle,
									left_attach, right_attach, top_attach, bottom_attach,
									xoptions, yoptions,
									xpadding, ypadding)
		end

	attach_defaults (a_child: GTK_WIDGET; left_attach, right_attach, top_attach, bottom_attach: INTEGER) is
			-- As there are many options associated with `attach'), this
			-- convenience function provides the programmer with a means to add
			-- children to a table with identical padding and expansion
			-- options. The values used for the GtkAttachOptions are gtk_expand and
			-- gtk_fill, and the padding is set to 0.
		
			-- `a_child': The child widget to add.

			-- `left_attach': The column number to attach the left side of the
			-- child widget to.

			-- `right_attach': The column number to attach the right side of the
			-- child widget to.

			-- `top_attach': The row number to attach the top of the child widget
			-- to.

			-- `bottom_attach' : The row number to attach the bottom of the child
			-- widget to.
		require
			valid_child: a_child /= Void
			left_attach_fits_natural_16: left_attach.in_range (0,65535)
			right_attach_fits_natural_16: right_attach.in_range (0,65535)
			top_attach_fits_natural_16: top_attach.in_range (0,65535)
			bottom_attach_fits_natural_16: bottom_attach.in_range (0,65535)
		do
			gtk_table_attach_defaults  (handle, a_child.handle,
			left_attach, right_attach, top_attach, bottom_attach)
		end

	set_row_spacing (a_row, a_spacing: INTEGER) is
			-- Changes the space between a given table row and its surrounding
			-- rows. `a_row': row number whose spacing will be
			-- changed. `a_spacing': number of pixels that the spacing should take
			-- up.
		require
			row_fits_natural_16: row_attach.in_range (0,65535)
			spacing_fits_natural_16: spacing.in_range (0,65535)
		do
			gtk_table_set_row_spacing (handle, a_row, a_spacing)
		end

	set_col_spacing (a_column, a_spacing: INTEGER) is
			-- Alters the amount of space between a given table column and the
			-- adjacent columns.

			-- `a_column' : the column whose spacing should be changed.
			-- `a_spacing' : number of pixels that the spacing should take up.
		require
			column_fits_natural_16: column_attach.in_range (0,65535)
			spacing_fits_natural_16: spacing.in_range (0,65535)
		do
			gtk_table_set_col_spacing (handle, a_row, a_spacing)
		end

	set_row_spacings (a_spacing: INTEGER) is
			-- Sets the space between every row in table equal to spacing.
		
			-- `a_spacing': the number of pixels of space to place between every
			-- row in the table.
		do
			gtk_table_set_row_spacings(handle, a_spacing)
		end

	set_col_spacings (a_spacing: INTEGER) is
			-- Sets the space between every column in table equal to spacing.
		
			-- `a_spacing': the number of pixels of space to place between every
			-- column in the table.
		do
			gtk_table_set_col_spacings(handle, a_spacing)
		end
	
	set_homogeneous is
			-- Ensure all table cells are the same size.
		do
			gtk_table_set_homogeneous (handle,1)
		ensure homogeneus: is_homogeneous
		end

	unset_homogeneous is
			-- Allow table cells to have different sizes.
		do
			gtk_table_set_homogeneous (handle,0)
		ensure unhomogeneus: not is_homogeneous
		end

   default_row_spacing: INTEGER is
			-- the default row spacing for the table. This is the spacing that will
			-- be used for newly added rows. (See `set_row_spacings').

			-- Note: should be NATURAL, perhaps even NATURAL_16, since it's a 
			-- guint constrained to be in 0..65535 interval
		do
			Result:=gtk_table_get_default_row_spacing (handle)
		ensure fits_natural_16: Result.in_range(0,65535)
		end

	is_homogeneous: BOOLEAN is
			-- Are the table cells all constrained to the same width and height?
			-- (See `set_homogenous')
		do
			Result:=gtk_table_get_homogeneous(handle).to_boolean
		end

	
--   gtk_table_get_row_spacing ()

--  guint       gtk_table_get_row_spacing       (GtkTable *table,
--                                               guint row);

--    Gets the amount of space between row row, and row row + 1. See
--    gtk_table_set_row_spacing().

--    table :   a GtkTable
--    row :     a row in the table, 0 indicates the first row
--    Returns : the row spacing

--    --------------------------------------------------------------------------

--   gtk_table_get_col_spacing ()

--  guint       gtk_table_get_col_spacing       (GtkTable *table,
--                                               guint column);

--    Gets the amount of space between column col, and column col + 1. See
--    gtk_table_set_col_spacing().

--    table :   a GtkTable
--    column :  a column in the table, 0 indicates the first column
--    Returns : the column spacing

--    --------------------------------------------------------------------------

--   gtk_table_get_default_col_spacing ()

--  guint       gtk_table_get_default_col_spacing
--                                              (GtkTable *table);

--    Gets the default column spacing for the table. This is the spacing that
--    will be used for newly added columns. (See gtk_table_set_col_spacings())

--    table :   a GtkTable
--    Returns : value: the default column spacing
-- Properties


--    "column-spacing"       guint                 : Read / Write
--    "homogeneous"          gboolean              : Read / Write
--    "n-columns"            guint                 : Read / Write
--    "n-rows"               guint                 : Read / Write
--    "row-spacing"          guint                 : Read / Write

-- Child Properties


--    "bottom-attach"        guint                 : Read / Write
--    "left-attach"          guint                 : Read / Write
--    "right-attach"         guint                 : Read / Write
--    "top-attach"           guint                 : Read / Write
--    "x-options"            GtkAttachOptions      : Read / Write
--    "x-padding"            guint                 : Read / Write
--    "y-options"            GtkAttachOptions      : Read / Write
--    "y-padding"            guint                 : Read / Write

-- Property Details

--   The "column-spacing" property

--    "column-spacing"       guint                 : Read / Write

--    The amount of space between two consecutive columns.

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "homogeneous" property

--    "homogeneous"          gboolean              : Read / Write

--    If TRUE this means the table cells are all the same width/height.

--    Default value: FALSE

--    --------------------------------------------------------------------------

--   The "n-columns" property

--    "n-columns"            guint                 : Read / Write

--    The number of columns in the table.

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "n-rows" property

--    "n-rows"               guint                 : Read / Write

--    The number of rows in the table.

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "row-spacing" property

--    "row-spacing"          guint                 : Read / Write

--    The amount of space between two consecutive rows.

--    Default value: 0

-- Child Property Details

--   The "bottom-attach" child property

--    "bottom-attach"        guint                 : Read / Write

--    The row number to attach the bottom of the child to.

--    Allowed values: [1,65535]

--    Default value: 1

--    --------------------------------------------------------------------------

--   The "left-attach" child property

--    "left-attach"          guint                 : Read / Write

--    The column number to attach the left side of the child to.

--    Allowed values: <= 65535

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "right-attach" child property

--    "right-attach"         guint                 : Read / Write

--    The column number to attach the right side of a child widget to.

--    Allowed values: [1,65535]

--    Default value: 1

--    --------------------------------------------------------------------------

--   The "top-attach" child property

--    "top-attach"           guint                 : Read / Write

--    The row number to attach the top of a child widget to.

--    Allowed values: <= 65535

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "x-options" child property

--    "x-options"            GtkAttachOptions      : Read / Write

--    Options specifying the horizontal behaviour of the child.

--    Default value: GTK_EXPAND|GTK_FILL

--    --------------------------------------------------------------------------

--   The "x-padding" child property

--    "x-padding"            guint                 : Read / Write

--    Extra space to put between the child and its left and right neighbors, in
--    pixels.

--    Allowed values: <= 65535

--    Default value: 0

--    --------------------------------------------------------------------------

--   The "y-options" child property

--    "y-options"            GtkAttachOptions      : Read / Write

--    Options specifying the vertical behaviour of the child.

--    Default value: GTK_EXPAND|GTK_FILL

--    --------------------------------------------------------------------------

--   The "y-padding" child property

--    "y-padding"            guint                 : Read / Write

--    Extra space to put between the child and its upper and lower neighbors, in
--    pixels.

--    Allowed values: <= 65535

--    Default value: 0

-- See Also

--    GtkVBox For packing widgets vertically only.
--    GtkHBox For packing widgets horizontally only.
-- feature {NONE} -- size
-- 	size: INTEGER is
-- 		external "C inline use <gtk/gtk.h>"
-- 		alias "sizeof(GtkTable)"
-- 		end

-- feature {NONE} -- External calls

--  #include <gtk/gtk.h>


--              GtkTable;
--              GtkTableChild;
--              GtkTableRowCol;
--  GtkWidget*  gtk_table_new                   (guint rows,
--                                               guint columns,
--                                               gboolean homogeneous);
--  void        gtk_table_resize                (GtkTable *table,
--                                               guint rows,
--                                               guint columns);
--  void        gtk_table_attach                (GtkTable *table,
--                                               GtkWidget *child,
--                                               guint left_attach,
--                                               guint right_attach,
--                                               guint top_attach,
--                                               guint bottom_attach,
--                                               GtkAttachOptions xoptions,
--                                               GtkAttachOptions yoptions,
--                                               guint xpadding,
--                                               guint ypadding);
--  void        gtk_table_attach_defaults       (GtkTable *table,
--                                               GtkWidget *widget,
--                                               guint left_attach,
--                                               guint right_attach,
--                                               guint top_attach,
--                                               guint bottom_attach);
--  void        gtk_table_set_row_spacing       (GtkTable *table,
--                                               guint row,
--                                               guint spacing);
--  void        gtk_table_set_col_spacing       (GtkTable *table,
--                                               guint column,
--                                               guint spacing);
--  void        gtk_table_set_row_spacings      (GtkTable *table,
--                                               guint spacing);
--  void        gtk_table_set_col_spacings      (GtkTable *table,
--                                               guint spacing);
--  void        gtk_table_set_homogeneous       (GtkTable *table,
--                                               gboolean homogeneous);
--  guint       gtk_table_get_default_row_spacing
--                                              (GtkTable *table);
--  gboolean    gtk_table_get_homogeneous       (GtkTable *table);
--  guint       gtk_table_get_row_spacing       (GtkTable *table,
--                                               guint row);
--  guint       gtk_table_get_col_spacing       (GtkTable *table,
--                                               guint column);
--  guint       gtk_table_get_default_col_spacing
--                                              (GtkTable *table);
end
