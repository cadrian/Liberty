-- See the Copyright notice at the end of this file.
--
class RECYCLING_POOL[R_ -> RECYCLABLE]
	--
	-- RECYCLABLE objects container.
	--
	-- Useful to implement recycling support in libraries.
	--
	-- Has no sense for expanded types (it will not even compile).
	--
	-- This class is designed to work with and without the garbage collector. It takes advantage of the GC if
	-- it is used, but it also minimises the memory footprint when the GC is ''not'' used.
	--
	-- See also STRING_RECYCLING_POOL, especially tuned for STRING usage.
	--

insert
	STACK[R_]
		rename
			item as collection_item
		export
			{RECYCLING_POOL} lower, upper, storage, count;
			{ANY} is_empty;
			{} all
		redefine
			mark_native_arrays
		end
	ANY
		undefine
			fill_tagged_out_memory, copy, is_equal
		end

creation {ANY}
	make

creation {RECYCLING_POOL}
	collection_make

feature {ANY}
	item: R_ is
			--
			-- Returns a recycled object, if there is one to be obtained. Returns Void otherwise.
			--
			-- See also `recycle'
			--
		require
			not is_empty
		do
			Result := top
			pop
		end

  recycle (an_item: like item) is
			--
			-- Stores the object as being reuseable. Automatically calls the "recycle" feature of the object.
			--
			-- Two notes:
			--
			-- * You should not directly reuse the object after it is recycled; call `item' instead to obtain a
			-- fresh reference. Using it directly will lead to classic problems of double referencing. In a
			-- nutshell, '''be sure not to hold any reference to a recycled object'''.
			--
			-- * If the GC is used it may free some recycled objects so using a RECYCLING_POOL does not interfere
			-- with memory conservation.
			--
			-- See also `item'
			--
		require
			an_item /= Void
		do
			an_item.recycle
			push(an_item)
		end

feature {}
	mark_native_arrays is
		do
			clear_count
		end

end -- class RECYCLING_POOL
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