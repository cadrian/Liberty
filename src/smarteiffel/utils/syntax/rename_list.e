-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class RENAME_LIST

inherit
	VISITABLE

insert
	GLOBALS

creation {ANY}
	make

feature {ANY}
	pretty is
		local
			i, rank: INTEGER
		do
			pretty_printer.set_indent_level(2)
			pretty_printer.keyword(once "rename")
			from
				i := list.lower
			until
				i > list.upper
			loop
				rank := rank + 1
				list.item(i).pretty(rank)
				i := i + 1
				if i <= list.upper then
					pretty_printer.put_string(once ", ")
				end
			end
			pretty_printer.set_indent_level(0)
		end

	accept (visitor: RENAME_LIST_VISITOR) is
		do
			visitor.visit_rename_list(Current)
		end

feature {PARENT_EDGE}
	name_in_child (fn: FEATURE_NAME): FEATURE_NAME is
			-- Gives Void or the name of `fn' after renaming if any.
		require
			fn /= Void
		local
			i: INTEGER; rp: RENAME_PAIR; no_longer_exists: BOOLEAN
		do
			Result := fn
			from
				i := list.upper
			until
				i < list.lower
			loop
				rp := list.item(i)
				if rp.old_name.is_equal(fn) then
					Result := rp.new_name
				elseif rp.new_name.is_equal(fn) then
					no_longer_exists := True
				end
				i := i - 1
			end
			if no_longer_exists and then Result = fn then
				Result := Void
			end
		end

	name_in_parent (fn: FEATURE_NAME): FEATURE_NAME is
			-- Assume `fn' is the result of a previous `name_in_child' call.
		require
			fn /= Void
		local
			i: INTEGER; rp: RENAME_PAIR
		do
			from
				i := list.upper
			until
				Result /= Void
			loop
				rp := list.item(i)
				if rp.new_name = fn then
					Result := rp.old_name
				end
				i := i - 1
			end
		ensure
			fn = name_in_child(Result)
		end

	is_target_of_rename (fn: FEATURE_NAME): BOOLEAN is
		require
			fn /= Void
		local
			i: INTEGER; rp: RENAME_PAIR
		do
			from
				i := list.upper
			until
				i < list.lower or Result
			loop
				rp := list.item(i)
				Result := rp.new_name.is_equal(fn)
				i := i - 1
			end
		end

	is_source_of_rename (fn: FEATURE_NAME): BOOLEAN is
		require
			fn /= Void
		local
			i: INTEGER; rp: RENAME_PAIR
		do
			from
				i := list.upper
			until
				i < list.lower or Result
			loop
				rp := list.item(i)
				Result := rp.old_name.is_equal(fn)
				i := i - 1
			end
		end

	add_last (rp: RENAME_PAIR) is
		require
			rp /= Void
		do
			list.add_last(rp)
		end

	initialize_and_check_level_1 is
		local
			i, j: INTEGER; rp1, rp2: RENAME_PAIR
		do
			from
				i := list.upper
			until
				i < list.lower
			loop
				rp1 := list.item(i)
				i := i - 1
				from
					j := i
				until
					j < list.lower
				loop
					rp2 := list.item(j)
					if rp2.old_name.is_equal(rp1.old_name) then
						error_handler.add_position(rp1.old_name.start_position)
						error_handler.add_position(rp2.old_name.start_position)
						error_handler.append("Multiple rename for the same feature is not allowed.")
						error_handler.print_as_fatal_error
					end
					j := j - 1
				end
			end
		end

	check_level_2 (parent_type: TYPE) is
		require
			parent_type /= Void
		local
			i: INTEGER; rename_pair: RENAME_PAIR
		do
			from
				i := list.upper
			until
				i < list.lower
			loop
				rename_pair := list.item(i)
				if not parent_type.valid_feature_name(rename_pair.old_name) then
					error_handler.add_position(rename_pair.old_name.start_position)
					error_handler.append("Cannot rename ")
					error_handler.add_feature_name(rename_pair.old_name)
					error_handler.append(" because type ")
					error_handler.append(parent_type.name.to_string)
					error_handler.append(" does not have ")
					error_handler.add_feature_name(rename_pair.old_name)
					error_handler.append(".")
					error_handler.print_as_fatal_error
				end
				i := i - 1
			end
		end

	count: INTEGER is
		do
			Result := list.count
		end

	item (i: INTEGER): RENAME_PAIR is
		require
			i.in_range(1, count)
		do
			Result := list.item(i - 1)
		end

feature {RENAME_LIST_VISITOR}
	list: FAST_ARRAY[RENAME_PAIR]

feature {}
	make (first: RENAME_PAIR) is
		require
			first /= Void
		do
			create list.with_capacity(4)
			list.add_last(first)
		ensure
			list.first = first
		end

invariant
	not list.is_empty

end -- class RENAME_LIST
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
-- Copyright(C) 2003-2004: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------------------------
