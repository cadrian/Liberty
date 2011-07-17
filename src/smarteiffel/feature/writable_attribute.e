-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class WRITABLE_ATTRIBUTE
	--
	-- For instance variables (ordinary attribute).
	--

inherit
	ATTRIBUTE
		redefine
			inline_expression_0,
			set_end_comment
		end
	
creation {FEATURE_TEXT}
	make

creation {WRITABLE_ATTRIBUTE}
	with

feature {ANY}
	specialized_feature_stamp: FEATURE_STAMP
			-- The good feature_stamp for the feature in some type
			-- (unrelated to `like_what' due to renamings).

	has_been_specialized: BOOLEAN is
		do
			Result := specialized_feature_stamp /= Void
			if not ace.boost then
				if Result and then require_assertion /= Void then
					Result := require_assertion.has_been_specialized
				end
				if Result and then ensure_assertion /= Void then
					Result := ensure_assertion.has_been_specialized
				end
			end
		end

	side_effect_free (target_type: TYPE): BOOLEAN is
		do
			Result := True -- (Read is not a side effect.)
		end

	use_current (type: TYPE): BOOLEAN is
		do
			Result := True
		end

	accept (visitor: WRITABLE_ATTRIBUTE_VISITOR) is
		do
			visitor.visit_writable_attribute(Current)
		end

	pretty (indent_level: INTEGER; is_inline_agent: BOOLEAN) is
		local
			il: INTEGER
			is_long_form: BOOLEAN
			fn: FEATURE_NAME
		do
			check
				indent_level=1
				not is_inline_agent
			end
			pretty_print_names
			pretty_printer.put_string(once ": ")
			pretty_printer.put_type_mark(result_type)
			is_long_form := obsolete_mark /= Void or else require_assertion /= Void or else ensure_assertion /= Void
			if is_long_form then
				pretty_printer.keyword(once "is")
			end
			if header_comment /= Void then
				if header_comment.start_position.line = first_name.start_position.line then
					-- Let the comment at its original place.
					header_comment.pretty(2)
				else
					il := pretty_printer.indent_level_for_header_comment_of_feature
					pretty_printer.set_indent_level(il)
					header_comment.pretty(il)
				end
			end
			if is_long_form then
				if obsolete_mark /= Void then
					pretty_printer.set_indent_level(2)
					pretty_printer.keyword(once "obsolete")
					obsolete_mark.pretty_without_once(2)
				end
				if require_assertion /= Void then
					pretty_printer.set_indent_level(2)
					require_assertion.pretty(2)
				end
				pretty_printer.set_indent_level(2)
				pretty_printer.keyword(once "attribute")
				if ensure_assertion /= Void then
					pretty_printer.set_indent_level(2)
					ensure_assertion.pretty(2)
				end
				pretty_printer.set_indent_level(2)
				pretty_printer.keyword(once "end")
			end
			if end_comment /= Void and then not end_comment.is_dummy_feature_end(Current) then
				end_comment.pretty(2)
			elseif pretty_printer.print_end_of_feature then
				if is_long_form then
					pretty_printer.put_string(once "-- ")
					fn := first_name
					fn.inside_end_comment_pretty_print
				elseif header_comment = Void then
					pretty_printer.put_character(';')
				end
			end
			pretty_printer.set_indent_level(0)
		end

	end_comment: COMMENT

feature {CALL_0}
	inline_expression_0 (type: TYPE; feature_stamp: FEATURE_STAMP; call_site: POSITION
								target_type: TYPE; target: EXPRESSION; return_type: TYPE): INLINE_MEMO is
		local
			good_position_for_current: POSITION; lt: LIVE_TYPE
		do
			if target_type.is_kernel_expanded then
				if target.is_current then
					if first_name.to_string = as_item then
						-- Simplifying the `item' attribute:
						good_position_for_current := target_type.class_text.name.start_position
						Result := smart_eiffel.get_inline_memo
						Result.set_expression(create {IMPLICIT_CURRENT}.make(good_position_for_current))
					end
				end
			end
			if Result = Void and then return_type.is_reference then
				-- Looking for dead-attribute access (yes, it is always Void):
				lt := return_type.live_type
				if lt = Void or else lt.run_time_set.count = 0 then
					if target.side_effect_free(type) then
						Result := smart_eiffel.get_inline_memo
						Result.set_expression(create {E_VOID}.make(target.start_position))
					end
				end
			end
			if Result /= Void then
				smart_eiffel.magic_count_increment
			end
		end

feature {EIFFEL_PARSER}
	set_end_comment (ec: like end_comment) is
		require else
			end_comment = Void
			ec /= Void
		do
			end_comment := ec
		ensure
			end_comment = ec
		end

feature {ANONYMOUS_FEATURE_MIXER}
	specialize_signature_in (new_type: TYPE): like Current is
		do
			result_type.specialize_in(new_type)
			Result := Current
		end

	specialize_body_in (new_type: TYPE; can_twin: BOOLEAN): like Current is
		local
			sfs: like specialized_feature_stamp
		do
			sfs := new_type.lookup(names.item(rank))
			if specialized_feature_stamp = Void then
				specialized_feature_stamp := sfs
			end
			if sfs = specialized_feature_stamp then
				Result := Current
			else
				check
					can_twin
				end
				--|*** remove the next test
				if can_twin then
					Result := twin
				else
					Result := Current
				end
				Result.set_specialized_feature_stamp(sfs)
			end
		end

feature {ANONYMOUS_FEATURE_MIXER}
	specialize_signature_thru (parent_type: TYPE; parent_edge: PARENT_EDGE; new_type: TYPE): like Current is
		local
			rt: like result_type
		do
			rt := result_type.specialize_thru(parent_type, parent_edge, new_type)
			if result_type = rt then
				Result := Current
			else
				Result := twin
				Result.set_result_type(rt)
			end
		end

	specialize_body_thru (parent_type: TYPE; parent_edge: PARENT_EDGE; new_type: TYPE; can_twin: BOOLEAN): like Current is
		local
			sfs: like specialized_feature_stamp
		do
			sfs := specialized_feature_stamp.specialize_thru(parent_type, parent_edge, new_type)
			if sfs = specialized_feature_stamp then
				Result := Current
			else
				if can_twin then
					Result := twin
				else
					Result := Current
				end
				Result.set_specialized_feature_stamp(sfs)
			end
		end

feature {WRITABLE_ATTRIBUTE}
	set_result_type (rt: like result_type) is
		require
			rt /= Void
		do
			result_type := rt
		ensure
			result_type = rt
		end

	set_specialized_feature_stamp (sfs: like specialized_feature_stamp) is
		do
			specialized_feature_stamp := sfs
		end

feature {}
	new_run_feature_for (t: TYPE; fn: FEATURE_NAME): RUN_FEATURE_2 is
		do
			create Result.for(t.live_type, Current, fn)
		end

	rank: INTEGER
			-- To find the the corresponding name in the `feature_text' (i.e.
			-- in most cases, this is simply one, because people are not
			-- used to have a lot of synonyms).

	add_into_ (ft: like feature_text; fd: DICTIONARY[ANONYMOUS_FEATURE, FEATURE_NAME]) is
		local
			n: like names; fn: FEATURE_NAME; i: INTEGER; writable_attribute: like Current
		do
			n := ft.names
			i := n.count
			fn := n.item(i)
			rank := i
			fd.add(Current, fn)
			-- Creation of copies for synonyms:
			from
				i := i - 1
			until
				i = 0
			loop
				fn := n.item(i)
				create writable_attribute.with(ft, Current, i)
				fd.add(writable_attribute, fn)
				i := i - 1
			end
		end

	with (ft: like feature_text; model: like Current; r: like rank) is
		require
			ft /= Void
			model /= Void
			r >= 1
		do
			feature_text := ft
			make(model.result_type, model.obsolete_mark, model.header_comment, model.require_assertion)
			end_comment := model.end_comment
			rank := r
		end

	make (rt: like result_type; om: like obsolete_mark; hc: like header_comment; ra: like require_assertion) is
		require
			rt /= Void
		do
			result_type := rt
			obsolete_mark := om
			header_comment := hc
			require_assertion := ra
		ensure
			result_type = rt
			obsolete_mark = om
			header_comment = hc
			require_assertion = ra
		end

	collect_body (t: TYPE) is
		do
		end

feature {}
	inline_dynamic_dispatch_ (code_accumulator: CODE_ACCUMULATOR; type: TYPE) is
		do
		end
	
end -- class WRITABLE_ATTRIBUTE
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
