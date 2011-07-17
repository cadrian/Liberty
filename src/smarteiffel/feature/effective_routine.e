-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class EFFECTIVE_ROUTINE
	--
	-- Such a routine can have local variables.
	--

inherit
	E_ROUTINE
		redefine
			same_body_as
		end

feature {ANY}
	is_deferred: BOOLEAN is False

	frozen rescue_compound_in (type: TYPE): like rescue_compound is
		do
			Result := rescue_compound
			if Result = Void then
				Result := type.default_rescue_compound
			end
		end

	rescue_compound: INSTRUCTION

	set_rescue_compound (rc: like rescue_compound) is
		do
			rescue_compound := rc
		end

	has_been_specialized: BOOLEAN is
		do
			Result := True
			if local_vars /= Void then
				Result := local_vars.has_been_specialized
			end
			if Result and then routine_body /= Void then
				Result := routine_body.has_been_specialized
			end
			if Result and then rescue_compound /= Void then
				Result := rescue_compound.has_been_specialized
			end
			if not ace.boost then
				if Result and then require_assertion /= Void then
					Result := require_assertion.has_been_specialized
				end
				if Result and then ensure_assertion /= Void then
					Result := ensure_assertion.has_been_specialized
				end
			end
		end

	use_current (type: TYPE): BOOLEAN is
		do
			if routine_body /= Void then
				Result := routine_body.use_current(type)
			end
			if not Result and then rescue_compound_in(type) /= Void then
				Result := rescue_compound_in(type).use_current(type)
			end
			if not Result and then not ace.boost then
				if require_assertion /= Void then
					Result := require_assertion.use_current(type)
				end
				if not Result and then ensure_assertion /= Void then
					Result := ensure_assertion.use_current(type)
				end
			end
		end

feature {FEATURE_ACCUMULATOR}
	frozen same_body_as (other: ANONYMOUS_FEATURE): BOOLEAN is
		do
			Result := Precursor(other)
			if Result then
				-- ***
			end
		end

feature {ANONYMOUS_FEATURE_MIXER}
	specialize_body_in (new_type: TYPE; can_twin: BOOLEAN): like Current is
		local
			lv: like local_vars; rb: like routine_body; rc: like rescue_compound
		do
			if local_vars /= Void then
				lv := local_vars.specialize_in(new_type)
				check
					smart_eiffel.specializing_feature_local_var_list = Void
				end
				smart_eiffel.set_specializing_feature_variables(lv)
			end
			if routine_body /= Void then
				rb := routine_body.specialize_in(new_type)
			end
			if rescue_compound /= Void then
				rc := rescue_compound.specialize_in(new_type)
			end
			if lv = local_vars and then rb = routine_body and then rc = rescue_compound then
				Result := Current
			else
				if can_twin then
					Result := twin
					Result.init(lv, rb, rc)
				else
					Result := Current
					local_vars := lv
					routine_body := rb
					rescue_compound := rc
				end
			end
			check
				smart_eiffel.specializing_feature_local_var_list = lv
			end
			if lv /= Void then
				smart_eiffel.set_specializing_feature_variables(Void)
			end
		end

feature {FEATURE_STAMP, PRECURSOR_CALL}
	specialize_2 (type: TYPE): like Current is
		local
			rb: like routine_body; rc: like rescue_compound; ra: like require_assertion
			ea: like ensure_assertion
		do
			if ace.boost then
				ra := require_assertion
				ea := ensure_assertion
			else
				if require_assertion /= Void then
					ra ::= require_assertion.specialize_2(type)
				end
				if ensure_assertion /= Void then
					ea := ensure_assertion.specialize_2(type)
				end
			end
			if routine_body /= Void then
				rb := routine_body.specialize_2(type)
			end
			if rescue_compound /= Void then
				rc := rescue_compound.specialize_2(type)
			end
			if rb = routine_body and then rc = rescue_compound and then ra = require_assertion and then ea = ensure_assertion then
				Result := Current
			else
				Result := twin
				Result.init(local_vars, rb, rc)
				Result.set_require_assertion(ra)
				Result.set_ensure_assertion(ea)
			end
		end

feature {ANONYMOUS_FEATURE_MIXER}
	specialize_body_thru (parent_type: TYPE; parent_edge: PARENT_EDGE; new_type: TYPE; can_twin: BOOLEAN): like Current is
		local
			lv, lv_memory: like local_vars; rb: like routine_body; rc: like rescue_compound
		do
			if local_vars /= Void then
				lv := local_vars.specialize_thru(parent_type, parent_edge, new_type)
				lv_memory := smart_eiffel.specializing_feature_local_var_list
				smart_eiffel.set_specializing_feature_variables(lv)
			end
			if routine_body /= Void then
				rb := routine_body.specialize_thru(parent_type, parent_edge, new_type)
			end
			if rescue_compound /= Void then
				rc := rescue_compound.specialize_thru(parent_type, parent_edge, new_type)
			end
			if lv = local_vars and then rb = routine_body and then rc = rescue_compound then
				Result := Current
			else
				if can_twin then
					Result := twin
					Result.init(lv, rb, rc)
				else
					Result := Current
					local_vars := lv
					routine_body := rb
					rescue_compound := rc
				end
			end
			check
				lv /= Void implies smart_eiffel.specializing_feature_local_var_list = lv
			end
			if lv /= Void then
				smart_eiffel.set_specializing_feature_variables(lv_memory)
			end
		end

feature {FEATURE_STAMP, LIVE_TYPE, PRECURSOR_CALL}
	simplify (type: TYPE): like Current is
		local
			rb: like routine_body; rc: like rescue_compound
		do
			if routine_body /= Void then
				rb := routine_body.simplify(type)
			end
			if rescue_compound = Void then
				if rb /= Void then
					rb := remove_first_redundant_initialisation(type, rb)
				end
			else
				rc := rescue_compound.simplify(type)
			end
			if rb = routine_body and then rc = rescue_compound then
				Result := Current
			else
				Result := twin
				Result.init(local_vars, rb, rc)
			end
		end

feature {EFFECTIVE_ROUTINE}
	init (lv: like local_vars; rb: like routine_body; rc: like rescue_compound) is
		do
			local_vars := lv
			routine_body := rb
			rescue_compound := rc
		ensure
			local_vars = lv
			routine_body = rb
			rescue_compound = rc
		end

feature {}
	collect_body (type: TYPE) is
		local
			dummy: TYPE
		do
			if local_vars /= Void then
				local_vars.collect(type)
			end
			if routine_body /= Void then
				dummy := routine_body.collect(type)
			end
			if rescue_compound /= Void then
				dummy := rescue_compound.collect(type)
			else
				type.collect_default_rescue(Current)
			end
		end

feature {}
	add_into_ (ft: like feature_text; fd: DICTIONARY[ANONYMOUS_FEATURE, FEATURE_NAME]) is
		do
			add_into_shared(ft, fd)
		end

	use_current_state: INTEGER

	computed_true: INTEGER is unique

	computed_false: INTEGER is unique

	not_computed: INTEGER is unique

	in_computation: INTEGER is unique

	pretty_print_routine_body (indent_level: INTEGER) is
		do
			if local_vars /= Void then
				local_vars.pretty
			end
			pretty_print_once_or_do(indent_level)
			if routine_body /= Void then
				routine_body.pretty(indent_level+1)
			end
		end

	pretty_print_once_or_do (indent_level: INTEGER) is
		deferred
		end

	pretty_print_rescue (indent_level: INTEGER) is
		do
			if rescue_compound /= Void then
				pretty_printer.set_indent_level(indent_level)
				pretty_printer.put_string(once "rescue")
				rescue_compound.pretty(indent_level+1)
			end
		end

	make_effective_routine (fa: like arguments; om: like obsolete_mark; hc: like header_comment
		ra: like require_assertion; lv: like local_vars; rb: like routine_body) is
		do
			make_routine(fa, om, hc, ra)
			local_vars := lv
			routine_body := rb
			use_current_state := not_computed
		ensure
			local_vars = lv
			routine_body = rb
		end

	left_most_current_direct_call_0_sequence (type: TYPE; e: EXPRESSION): CALL_0 is
			-- Is `e' a direct inlinable sequence of CALL_0 with a left-most Current?
			-- Examples: Current.foo
			--           Current.foo.bar
			--           Current.foo.bar.zoo
			-- This function also check that each call is a direct non-void call as well as some
			-- special situation when there is a user's expanded type in the way.
		local
			call_0: CALL_0; relay_type: TYPE
		do
			--|*** debug_counter: INTEGER
			call_0 ?= e
			if call_0 /= Void then
				relay_type := call_0.resolve_in(type)
				if relay_type.direct_non_void_call_flag then
					if relay_type.is_integer then
						-- Note: at time being, the `item' attribute of INTEGER is not handled here.
					elseif relay_type.is_user_expanded and then not relay_type.is_empty_expanded then
						-- It is not safe to inline in such a situation because it may remove a copy of the user's
						-- expanded.
					elseif call_0.target.is_current then
						Result := call_0
					elseif left_most_current_direct_call_0_sequence(type, call_0.target) /= Void then
						Result := call_0
					end
				end
			end
			--|*** 
			--|*** if Result /= Void then
			--|*** from
			--|*** debug_counter := 1
			--|*** call_0 ?= e
			--|*** until
			--|*** call_0.target.is_current
			--|*** loop
			--|*** error_handler.add_position(call_0.feature_name.start_position)
			--|*** call_0 ?= call_0.target
			--|*** debug_counter := debug_counter + 1
			--|*** end
			--|*** error_handler.add_position(call_0.feature_name.start_position)
			--|*** if debug_counter >= 2 then
			--|*** error_handler.append(once "left_most_current_direct_call_0_sequence of length ")
			--|*** error_handler.append_integer(debug_counter)
			--|*** error_handler.print_as_warning
			--|*** else
			--|*** error_handler.cancel
			--|*** end
			--|*** end
			--|*** 
		ensure
			Result = Void or else Result = e
		end

	left_most_current_direct_call_0_sequence_inline (type: TYPE; call_0: CALL_0; target_type: TYPE
		target: EXPRESSION): CALL_0 is
		require
			type /= Void
			call_0.resolve_in(target_type) /= Void
			left_most_current_direct_call_0_sequence(target_type, call_0) = call_0
		local
			call_0_target: CALL_0
		do
			if call_0.target.is_current then
				Result := call_0.inline_with(target)
			else
				call_0_target ?= call_0.target
				call_0_target := left_most_current_direct_call_0_sequence_inline(type, call_0_target, target_type, target)
				Result := call_0.inline_with(call_0_target)
			end
		ensure
			Result /= Void
		end

feature {ANONYMOUS_FEATURE}
	no_rescue_no_local_expanded_in (type: TYPE): BOOLEAN is
		do
			Result := True
			if local_vars /= Void then
				Result := local_vars.side_effect_free(type)
			end
			if Result then
				Result := rescue_compound = Void
				if Result then
					Result := type.default_rescue_compound = Void
				end
			end
		end

feature {}
	remove_first_redundant_initialisation (type: TYPE; rb: like routine_body): INSTRUCTION is
			-- The goal is to remove the first assignment of `rb' when this assignment 
			-- (re)set the default value to some local (or Result).
		require
			rb /= Void
			rescue_compound = Void
		local
			assignment: ASSIGNMENT; compound: COMPOUND
		do
			Result := rb
			if {ASSIGNMENT} ?:= rb then
				assignment ::= rb
				if assignment.reset_default_value_in_local_or_result(type) then
					Result := Void
					smart_eiffel.magic_count_increment
				end
			elseif {COMPOUND} ?:= rb then
				compound ::= rb
				if {ASSIGNMENT} ?:= compound.first then
					assignment ::= compound.first
					if assignment.reset_default_value_in_local_or_result(type) then
						Result := compound.twin_remove_first
						smart_eiffel.magic_count_increment
					end
				end 
			end
		end
	
feature {}
	inline_dynamic_dispatch_ (code_accumulator: CODE_ACCUMULATOR; type: TYPE) is
		local
			position: POSITION; compound: COMPOUND; sedb: INSTRUCTION
		do
			if routine_body /= Void then
				routine_body := routine_body.inline_dynamic_dispatch(code_accumulator, type) 
			end
			if not ace.boost then
				-- To see the eXit under -sedb as well:
				position := sedb_trace_before_exit
				if not position.is_unknown then
					code_accumulator.open_new_context
					code_accumulator.add_sedb(position, 'X')
					sedb := code_accumulator.current_context_to_instruction
					code_accumulator.close_current_context
					if routine_body = Void then
						routine_body := sedb
					elseif {COMPOUND} ?:= routine_body then
						compound ::= routine_body
						compound.add_last(sedb)
					else
						create {COMPOUND} routine_body.make_2(routine_body, sedb)
					end
				end
			end
		end
	
end -- class EFFECTIVE_ROUTINE
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