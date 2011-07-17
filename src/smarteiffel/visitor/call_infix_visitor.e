-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class CALL_INFIX_VISITOR

inherit
	CALL_INFIX_MINUS_VISITOR
	CALL_INFIX_OR_VISITOR
	CALL_INFIX_INT_DIV_VISITOR
	CALL_INFIX_LT_VISITOR
	CALL_INFIX_IMPLIES_VISITOR
	CALL_INFIX_FREEOP_VISITOR
	CALL_INFIX_LE_VISITOR
	CALL_INFIX_PLUS_VISITOR
	CALL_INFIX_GT_VISITOR
	CALL_INFIX_GE_VISITOR
	CALL_INFIX_DIV_VISITOR
	CALL_INFIX_POWER_VISITOR
	CALL_INFIX_OR_ELSE_VISITOR
	CALL_INFIX_AND_THEN_VISITOR
	CALL_INFIX_XOR_VISITOR
	CALL_INFIX_INT_REM_VISITOR
	CALL_INFIX_TIMES_VISITOR
	CALL_INFIX_AND_VISITOR

end -- class CALL_INFIX_VISITOR
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
