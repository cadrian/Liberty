-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class C_SPLITTER_LEGACY_ITERATOR

inherit
        ITERATOR[STRING]

creation {C_SPLITTER_LEGACY}
        make

feature {ANY}
        start is
                do
                        index := count
                end

        is_off: BOOLEAN is
                do
                        Result := index = 0
                end

        item: STRING is
                do
                        Result := once ""
                        Result.clear_count
                        index.append_in(Result)
                end

        next is
                do
                        index := index - 1
                end

feature {}
        make (a_count: like count) is
                require
                        a_count > 0
                do
                        count := a_count
                        start
                end

        index: INTEGER
        count: INTEGER

   iterable_generation: INTEGER is 0 -- not managed

invariant
        index.in_range(0, count)
        index /= 0 implies not is_off

end -- class C_SPLITTER_LEGACY_ITERATOR
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
