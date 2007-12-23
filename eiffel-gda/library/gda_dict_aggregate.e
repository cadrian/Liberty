indexing
	description: "An aggregate in the DBMS (like COUNT() or AVG() for example)"
	copyright: "[
					Copyright (C) 2007 Paolo Redaelli, GDA developers
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hopeOA that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
			]"

	wrapped_version: "3.0.1"

class GDA_DICT_AGGREGATE
	-- An aggregate in the DBMS (like COUNT() or AVG() for example)

	-- Because aggregates can be polymorphic, the name is not enough to
	-- identify them, so the DBMS provides a unique id which can be
	-- used to uniquely identify an aggregate.
	
inherit
	GDA_OBJECT
	
	-- TODO: GdaDictAggregate implements GdaXmlStorage.
insert  GDA_DICT_AGGREGATE_EXTERNALS

creation from_dict, from_external_pointer

feature {} -- Creation

	from_dict (a_dict: GDA_DICT) is
			-- Creates a new GdaDictAggregate object which represents an
			-- aggregate in the dictionary
		require dict_not_void: a_dict/=Void
		do
			from_external_pointer(gda_dict_aggregate_new(handle))
		end

feature
	set_dbms_id (an_id: STRING) is
			-- Set the DBMS identifier of the aggregate
		require id_not_void: an_id/=Void
		do
			gda_dict_aggregate_set_dbms_id (handle, an_id.to_external)
		end

	dbms_id: STRING is
		-- the DBMS identifier of the aggregate
		do
			create Result.from_external
			(gda_dict_aggregate_get_dbms_id (handle))
		ensure not_void: Result /= Void
		end

	set_sqlname (a_name: STRING) is
			-- Set the SQL name of the data type.
		require name_not_void: a_name /= Void
		do
			gda_dict_aggregate_set_sqlname (handle, a_name.to_external)
		end
	
	sqlname: CONST_STRING is 
			-- the name of the data type
		do
			create Result.from_external(gda_dict_aggregate_get_sqlname(handle))
		ensure not_void: Result/=Void
		end

	set_arg_type (a_data_type: GDA_DICT_TYPE) is
			-- Set the argument type of a aggregate. Note: GDA C
			-- interface allows Void/NULL argument. It is not clear what
			-- they represent
		do
			gda_dict_aggregate_set_arg_type (handle,null_or(a_data_type))
		end

	arg_type: GDA_DICT_TYPE is
			-- To consult the list of arguments types (and number) of a
			-- aggregate. Returns : a list of GdaDictType objects, the
			-- list MUST NOT be modified.

			-- TODO: There is a mismatch between the function signature
			-- and its description. Bad things could happen.
		local p: POINTER; f: G_OBJECT_EXPANDED_FACTORY[GDA_DICT_TYPE]
		do
			p:=gda_dict_aggregate_get_arg_type(handle)
			Result:=f.existant_wrapper(p) 
			if Result=Void then create Result.from_external_pointer(p) end
		end

	set_return_type (a_type: GDA_DICT_TYPE) is
			-- Set the return type of a aggregate
		do
			gda_dict_aggregate_set_ret_type (handle,null_or(a_type))
		end

	return_type: GDA_DICT_TYPE is
			-- the return type of a aggregate.
		local p: POINTER; f: G_OBJECT_EXPANDED_FACTORY[GDA_DICT_TYPE]
		do
			p:=gda_dict_aggregate_get_ret_type(handle)
			Result:=f.existant_wrapper(p)
			if Result=Void then create Result.from_external_pointer(p) end
		end

feature

	dummy_gobject: POINTER is
		do
			unimplemented
		end
 
end -- class GDA_DICT_AGGREGATE
