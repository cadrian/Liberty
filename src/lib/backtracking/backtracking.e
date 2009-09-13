-- See the Copyright notice at the end of this file.
--
deferred class BACKTRACKING
	--
	-- This class is intended to explore structures that matches the and/or
	-- graph of BACKTRACKING_NODE. The alternatives have a context that is
	-- gotten and restored throught features 'get_context' and 'restore_context'.
	--
	-- See tutorial/backtracking for examples.
	--
	-- The instances of the BACKTRACKING childs are typically
	-- used through lines like the following ones that enumerate the
	-- solutions:
	--
	--         from
	--            set_current_node(root)
	--            search_first
	--         until
	--            is_off
	--         loop
	--            ... -- do something
	--            search_next
	--         end
	--
	-- These features are declared to be bound to ANY but dont hesitate to
	-- change the type of the context to what your context is.
	--

inherit
	ABSTRACT_BACKTRACKING

insert
	BACKTRACKING_GLOBALS

feature {ANY}
	set_current_node (node: like current_node) is
			-- Set the next node of the BACKTRACKING_NODE graph to be evaluated.
		do
			current_node := node
		ensure
			definition: current_node = node
		end

	push_and (node: BACKTRACKING_NODE) is
			-- Pushes 'node' in front of the continuation path.
		require
			node_not_void: node /= Void
		local
			sequence: BACKTRACKING_SEQUENCE
		do
			sequence := pool_of_sequence.get_instance
			sequence.set_next(node)
			push_sequence(sequence)
		end

	push_and_list (list: BACKTRACKING_NODE_AND_LIST) is
			-- Pushes 'list' in front of the continuation path.
		require
			list_not_void: list /= Void
		local
			sequence: BACKTRACKING_SEQUENCE_LIST
		do
			sequence := pool_of_sequence_list.get_instance
			sequence.set_list(list)
			push_sequence(sequence)
		end

	push_or (node: BACKTRACKING_NODE) is
			-- Pushes 'node' in front of the possible alternatives.
		require
			node_not_void: node /= Void
		local
			alternative: BACKTRACKING_ALTERNATIVE
		do
			alternative := pool_of_alternative.get_instance
			alternative.set_next(node)
			push_alternative(alternative)
		end

	push_or_list (list: BACKTRACKING_NODE_OR_LIST) is
			-- Pushes 'list' in front of the possible alternatives.
		require
			list_not_void: list /= Void
		local
			alternative: BACKTRACKING_ALTERNATIVE_LIST
		do
			alternative := pool_of_alternative_list.get_instance
			alternative.set_list(list)
			push_alternative(alternative)
		end

feature {} -- internal
	current_node: BACKTRACKING_NODE
			-- Current node of the BACKTRACKING_NODE graph to be evaluated.

	evaluate_current_state is
			-- That feature is called to evaluate the current state
		do
			current_node.explore(Current)
		end

end -- class BACKTRACKING
--
-- ------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- This file is part of the SmartEiffel standard library.
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
-- documentation files (the "Software"), to deal in the Software without restriction, including without
-- limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
-- conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial
-- portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
-- LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
-- EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
-- AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
-- OR OTHER DEALINGS IN THE SOFTWARE.
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------