-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class REPOSITORY_IMPL[O_ -> STORABLE]
	--
	-- Used to implement update and commit. Takes care of object references and cycles.
	--
	-- Update is usually event-driven; here are only tools to correctly create the objects layout (see
	-- `read_from_stream' and `update_from_stream').
	--
	-- Commit is, on the other hand, a method template with a few deferred methods (see `write_to_stream').
	--
	-- Vocabulary:
	--
	-- * layout: the description of the contents of an object (its layout). This object is referenced
	-- by a reference (see below).
	--
	-- * reference: a reference to an object. Note that the layout of the object MUST have been defined before
	-- any reference links to it. A special 'Void' ref indicates a Void object.
	--
	-- * embedded: a user-defined expanded object (i.e. not one of the basic objects)
	--
	-- * basic: a special expanded object, with a simple value, specially treated by the compiler and by this
	-- class. Basic types are INTEGER and co., READ and co., CHARACTER and BOOLEAN.
	--
	-- * array: a NATIVE_ARRAY of objects. The type is, in that particular case, the type of the items.
	--
	-- See also XML_REPOSITORY_IMPL
	--

inherit
	REPOSITORY[O_]

insert
	INTERNALS_HANDLER

feature {ANY} -- Error handling on repository update
	register_update_error_handler (a_error_handler: PROCEDURE[TUPLE[INTEGER, INTEGER, STRING]]) is
		do
			update_error_handlers.add_last(a_error_handler)
		end

feature {}
	update_error_handlers: FAST_ARRAY[PROCEDURE[TUPLE[INTEGER, INTEGER, STRING]]]

	fire_update_error (line, column: INTEGER; message: STRING) is
		local
			i: INTEGER
		do
			sedb_breakpoint
			from
				i := update_error_handlers.lower
			until
				i > update_error_handlers.upper
			loop
				update_error_handlers.item(i).call([line, column, message])
				i := i + 1
			end
		end

feature {} -- Implementation of update
	solve_again: BOOLEAN

	update_layouts: STACK[REPOSITORY_LAYOUT] is
		once
			create Result.make
		end

	updated_internals: AVL_DICTIONARY[INTERNALS, STRING] is
		once
			create Result.make
		end

	layouts: FAST_ARRAY[REPOSITORY_LAYOUT] is
		once
			create Result.make(0)
		end

	objects: AVL_DICTIONARY[STRING, STRING] is
		once
			create Result.make
		end

	solve (ref: STRING): INTERNALS is
		require
			not ref.is_equal(once "Void")
			not transient.has_object(ref)
		do
			Result := updated_internals.reference_at(ref)
			if Result = Void then
				solve_again := True
			end
		end

	solver: FUNCTION[TUPLE[STRING], INTERNALS] is
		once
			Result := agent solve
		end

	read_from_stream (in_stream: INPUT_STREAM) is
		local
			string: STRING
		do
			repository.clear_count
			check
				update_layouts.is_empty
			end
			from
			until
				updated_internals.is_empty
			loop
				string := updated_internals.key(updated_internals.lower)
				updated_internals.remove(string)
				strings.recycle(string)
			end
			update_from_stream(in_stream)
		end

	update_from_stream (in_stream: INPUT_STREAM) is
		do
			register_transient_objects
			do_update(in_stream)
			unregister_transient_objects
			if not update_layouts.is_empty then
				fire_update_error(last_line, last_column, once "Some layouts are still to be consumed")
			end
		end

	last_line: INTEGER is
		deferred
		end

	last_column: INTEGER is
		deferred
		end

	do_update (in_stream: INPUT_STREAM) is
		deferred
		end

	record_object (ref, name: STRING; line, column: INTEGER) is
			-- Register the object as a high-level one, i.e. put it in the repository.
		local
			typed: TYPED_INTERNALS[O_]; error: STRING
		do
			if not updated_internals.has(ref) then
				error := once ""
				error.copy(once "Unknown reference: ")
				error.append(ref)
				fire_update_error(line, column, error)
			else
				typed ::= solve(ref)
				put(typed.object, name)
			end
		end

	check_non_empty_data (a_data, data_type: STRING; line, column: INTEGER) is
		local
			error: STRING
		do
			if a_data = Void or else a_data.is_empty then
				error := once ""
				error.copy(once "Invalid empty ")
				error.append(data_type)
				error.append(once ": ")
				error.append(a_data)
				fire_update_error(line, column, error)
			end
		end

	open_repository (a_repository: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_repository.kind.is_equal(once "repository")
		do
			objects.clear_count
			layouts.clear_count
		end

	open_layout (a_type, a_ref: STRING; a_layout: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_layout.kind.is_equal(once "layout")
		do
			check_non_empty_data(a_type, once "type", line, column)
			check_non_empty_data(a_ref, once "ref", line, column)
			a_layout.set_type(a_type)
			a_layout.set_ref(a_ref)
		end

	open_reference (a_name, a_ref: STRING; a_reference: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_reference.kind.is_equal(once "reference")
		do
			check_non_empty_data(a_name, once "name", line, column)
			check_non_empty_data(a_ref, once "ref", line, column)
			a_reference.set_name(a_name)
			a_reference.set_ref(a_ref)
		end

	open_embedded (a_name, a_type: STRING; a_embedded: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_embedded.kind.is_equal(once "embedded")
		do
			check_non_empty_data(a_name, once "name", line, column)
			check_non_empty_data(a_type, once "type", line, column)
			a_embedded.set_name(a_name)
			a_embedded.set_type(a_type)
		end

	open_basic (a_name, a_type, a_value: STRING; a_basic: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_basic.kind.is_equal(once "basic")
		do
			check_non_empty_data(a_name, once "name", line, column)
			check_non_empty_data(a_type, once "type", line, column)
			check_non_empty_data(a_value, once "value", line, column)
			a_basic.set_name(a_name)
			a_basic.set_type(a_type)
			a_basic.set_value(a_value)
		end

	open_array (a_name, a_type: STRING; a_capacity: INTEGER; a_array: REPOSITORY_LAYOUT; line, column: INTEGER) is
		require
			a_array.kind.is_equal(once "array")
		local
			error: STRING
		do
			check_non_empty_data(a_name, once "name", line, column)
			check_non_empty_data(a_type, once "type", line, column)
			if a_capacity < 0 then
				error := once ""
				error.copy(once "Invalid negative capacity: ")
				a_capacity.append_in(error)
				fire_update_error(line, column, error)
			end
			a_array.set_name(a_name)
			a_array.set_type(a_type)
			a_array.set_capacity(a_capacity)
		end

	close_repository (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "repository")
		local
			layout: REPOSITORY_LAYOUT; internals: INTERNALS; i, c: INTEGER
		do
			update_layouts.pop
			check
				update_layouts.is_empty
			end
			from
				solve_again := True
				c := layouts.count
			variant
				c
			until
				not solve_again
			loop
				solve_again := False
				from
					i := layouts.lower
				until
					i > layouts.upper
				loop
					layout := layouts.item(i)
					check
						layout.kind.is_equal(once "layout")
					end
					internals := layout.solve(solver)
					if internals = Void then
						-- Cannot do anything, at this stage the object will never be found.
						-- solve_again := True
					elseif updated_internals.has(layout.ref) then
						check
							internals = updated_internals.at(layout.ref)
						end
					else
						updated_internals.add(internals, strings.new_twin(layout.ref))
						c := c - 1
					end
					i := i + 1
				end
			end
			from
				i := objects.lower
			until
				i > objects.upper
			loop
				record_object(objects.item(i), objects.key(i), line, column)
				i := i + 1
			end
		end

	close_layout (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "layout")
		local
			layout: REPOSITORY_LAYOUT
		do
			layout := update_layouts.top
			update_layouts.pop
			layouts.add_last(layout)
		end

	close_reference (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "reference")
		local
			layout: REPOSITORY_LAYOUT
		do
			layout := update_layouts.top
			update_layouts.pop
			if update_layouts.count = 1 then
				-- means only the "repository" node is open
				objects.add(layout.ref, layout.name)
			else
				update_layouts.top.add_layout(layout)
			end
		end

	close_embedded (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "embedded")
		local
			layout: REPOSITORY_LAYOUT
		do
			layout := update_layouts.top
			update_layouts.pop
			update_layouts.top.add_layout(layout)
		end

	close_basic (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "basic")
		local
			layout: REPOSITORY_LAYOUT
		do
			layout := update_layouts.top
			update_layouts.pop
			update_layouts.top.add_layout(layout)
		end

	close_array (line, column: INTEGER) is
		require
			update_layouts.top.kind.is_equal(once "array")
		local
			layout: REPOSITORY_LAYOUT
		do
			layout := update_layouts.top
			update_layouts.pop
			update_layouts.top.add_layout(layout)
		end

feature {} -- Implementation of commit
	commit_map: SET[POINTER] is
			-- Used when committing object not to commit them twice
		once
			create {HASHED_SET[POINTER]} Result.make
		end

	write_to_stream (out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		local
			i: INTEGER
		do
			register_transient_objects
			commit_map.clear_count
			start_write(out_stream)
			from
				i := lower
			until
				i > upper
			loop
				write_object(key(i), item(i), out_stream)
				i := i + 1
			end
			end_write(out_stream)
			unregister_transient_objects
		end

	start_write (out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		deferred
		end

	end_write (out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		deferred
		end

	write_object (name: like key; object: like item; out_stream: OUTPUT_STREAM) is
		local
			int: INTERNALS
		do
			if object = Void then
				write_reference_layout(Void, name, out_stream)
			else
				int := object.to_internals
				if int.type_is_expanded then
					write_expanded(int, name, out_stream)
				else
					if not commit_map.has(int.object_as_pointer) then
						write_layout(int, out_stream)
					end
					write_reference_layout(int, name, out_stream)
				end
			end
		end

	write_reference_layout (reference: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		require
			reference /= Void implies not reference.type_is_expanded
		local
			ref: STRING
		do
			if reference = Void then
				write_reference(once "Void", name, out_stream)
			else
				ref := transient.reference(reference)
				if ref /= Void then
					write_reference(ref, name, out_stream)
				else
					ref := once ""
					ref.clear_count
					reference.object_as_pointer.append_in(ref)
					write_reference(ref, name, out_stream)
				end
			end
		end

	write_reference (reference: STRING; name: STRING; out_stream: OUTPUT_STREAM) is
		require
			not reference.is_empty
		deferred
		end

	write_layout (layout: INTERNALS; out_stream: OUTPUT_STREAM) is
		require
			not commit_map.has(layout.object_as_pointer)
			not layout.type_is_expanded
		local
			i: INTEGER; int: INTERNALS; ref: STRING
		do
			-- Add the pointer to the map of "known objects" (those already written). It must be done first
			-- because of possible recursion
			commit_map.add(layout.object_as_pointer)
			if transient.reference(layout) = Void then
				-- Write the nested objects not already defined
				from
					i := 1
				until
					i > layout.type_attribute_count
				loop
					int := layout.object_attribute(i)
					if int /= Void then
						if int.type_is_expanded then
							if int.type_is_native_array then
								write_array_fields_layouts(int, out_stream)
							end
						elseif not commit_map.has(int.object_as_pointer) then
							write_layout(int, out_stream)
						end
					end
					i := i + 1
				end
				ref := once ""
				ref.clear_count
				layout.object_as_pointer.append_in(ref)
				start_layout(ref, layout.type_generating_type, out_stream)
				write_contents(layout, out_stream)
				end_layout(out_stream)
			end
		ensure
			commit_map.has(layout.object_as_pointer)
		end

	start_layout (ref, type: STRING; out_stream: OUTPUT_STREAM) is
		require
			not ref.is_empty
			not type.is_empty
			out_stream.is_connected
		deferred
		end

	end_layout (out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		deferred
		end

	write_contents (layout: INTERNALS; out_stream: OUTPUT_STREAM) is
		require
			layout.type_is_expanded or else transient.reference(layout) = Void
		local
			i: INTEGER; int: INTERNALS
		do
			from
				i := 1
			until
				i > layout.type_attribute_count
			loop
				int := layout.object_attribute(i)
				if int = Void then
					write_reference_layout(Void, layout.type_attribute_name(i), out_stream)
				else
					if int.type_is_expanded then
						write_expanded(int, layout.type_attribute_name(i), out_stream)
					else
						write_reference_layout(int, layout.type_attribute_name(i), out_stream)
					end
				end
				i := i + 1
			end
		end

	write_array_fields_layouts (array: INTERNALS; out_stream: OUTPUT_STREAM) is
		require
			array.type_is_expanded and then array.type_is_native_array
		local
			f: INTEGER; int: INTERNALS
		do
			from
				f := 1
			until
				f > array.type_attribute_count
			loop
				int := array.object_attribute(f)
				if int /= Void and then not int.type_is_expanded and then not commit_map.has(int.object_as_pointer) then
					write_layout(int, out_stream)
				end
				f := f + 1
			end
		end

	write_expanded (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		require
			internals.type_is_expanded
		local
			type: STRING
		do
			type := internals.type_generating_type
			inspect
				type
			when "CHARACTER" then
				write_character_layout_object(internals, name, out_stream)
			when "BOOLEAN" then
				write_boolean_layout_object(internals, name, out_stream)
			when "INTEGER_8" then
				write_integer_8_layout_object(internals, name, out_stream)
			when "INTEGER_16" then
				write_integer_16_layout_object(internals, name, out_stream)
			when "INTEGER" then
				write_integer_layout_object(internals, name, out_stream)
			when "INTEGER_32" then
				write_integer_32_layout_object(internals, name, out_stream)
			when "INTEGER_64" then
				write_integer_64_layout_object(internals, name, out_stream)
			when "REAL" then
				write_real_layout_object(internals, name, out_stream)
			when "REAL_32" then
				write_real_32_layout_object(internals, name, out_stream)
			when "REAL_64" then
				write_real_64_layout_object(internals, name, out_stream)
			when "REAL_80" then
				write_real_80_layout_object(internals, name, out_stream)
			when "REAL_128" then
				write_real_128_layout_object(internals, name, out_stream)
			when "REAL_EXTENDED" then
				write_real_expanded_layout_object(internals, name, out_stream)
			else
				if internals.type_is_native_array then
					write_array_layout_object(internals, name, out_stream)
				else
					write_embedded_layout_object(internals, name, out_stream)
				end
			end
		end

	write_character_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_boolean_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_integer_8_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_integer_16_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_integer_32_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_integer_64_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_integer_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_32_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_64_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_80_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_128_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_real_expanded_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_array_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		deferred
		end

	write_embedded_layout_object (internals: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		do
			start_embedded_layout(internals, name, out_stream)
			write_contents(internals, out_stream)
			end_embedded_layout(internals, name, out_stream)
		end

	start_embedded_layout (layout: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		deferred
		end

	end_embedded_layout (layout: INTERNALS; name: STRING; out_stream: OUTPUT_STREAM) is
		require
			out_stream.is_connected
		deferred
		end

feature {} -- Internals
	layouts_pool: RECYCLING_POOL[REPOSITORY_LAYOUT] is
		once
			create Result.make
		end

	new_layout (a_kind: STRING): REPOSITORY_LAYOUT is
		do
			if layouts_pool.is_empty then
				create Result.make
			else
				Result := layouts_pool.item
			end
			check
				Result.is_clear
			end
			Result.set_kind(a_kind)
		ensure
			Result.kind.is_equal(a_kind)
		end

	release_layout (a_layout: REPOSITORY_LAYOUT) is
		do
			layouts_pool.recycle(a_layout)
		end

	strings: STRING_RECYCLING_POOL is
		once
			create Result.make
		end

	transient: REPOSITORY_TRANSIENT

feature {} -- Creation
	make is
			-- Create a not-connected empty repository.
		do
			if repository = Void then
				create {AVL_DICTIONARY[O_, STRING]} repository.make
				create update_error_handlers.with_capacity(2)
			else
				repository.clear_count
				update_error_handlers.clear_count
			end
		end

feature {} -- Transient objects
	register_transient_objects is
		deferred
		end

	unregister_transient_objects is
		deferred
		end

end -- class REPOSITORY_IMPL
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- SmartEiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- SmartEiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with SmartEiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------------------------