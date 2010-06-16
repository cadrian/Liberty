class C_FUNCTION
	-- A "Function" node of an XML file made by gccxml. 

inherit
	GCCXML_NODE
	IDENTIFIED_NODE
	NAMED_NODE
		rename 
			c_name as function_name
			c_string_name as function_string_name
		end
	FILED_NODE
	STORABLE_NODE
	WRAPPABLE_NODE
	CONTEXTED_NODE

insert 
	EXCEPTIONS

creation make
feature {ANY}
	store is
		do
			functions.store(Current)
		end

	returns: UNICODE_STRING is
		do
			Result := attribute_at(once U"returns")
		end

	return_type: TYPED_NODE is
		do
			Result := types.at(returns)
		end

	eiffel_name: STRING is
		-- The Eiffel version of Current's function name.
		-- NOTE: this way of assigning feature names is not entirely
		-- bullet-proof. In fact MyFunction and myfunction will get the same
		-- Eiffel feature name. I could say that such code is not worth your
		-- time; such cases are handled much more effectively by the developer
		-- of a wrapper library with case-by-case inspection.
		do
			if stored_eiffel_name=Void then 
				stored_eiffel_name := eiffel_feature(function_name.as_utf8)	
			end
			Result := stored_eiffel_name
		end
	
	has_arguments: BOOLEAN is
		-- Does Current function have arguments?
	do
		Result := children_count>0
	end

	is_variadic: BOOLEAN is
		-- Does current function accept a variable number of arguments?
	do
		if has_arguments 
			then Result := argument(children_count).is_ellipsis
		else Result:=False
		end
	end

	is_wrappable: BOOLEAN is
		-- Are all arguments wrappable and its return type either void or
		-- wrappable? The variadic part of the function, the ellipsis ("...")
		-- is ignored. 
	local i: INTEGER_32
	do
		Result := (return_type.is_void or return_type.has_wrapper)
	    if Result then
			-- Check for 
			from i:=children_count until not Result or i<1 loop
				Result := argument(i).has_wrapper or else argument(i).is_ellipsis
				i := i-1
			end
		end
	end

	wrap_on (a_stream: OUTPUT_STREAM) is 
		do
			if not is_wrappable then
				log("Function `@(1)' is not wrappable%N", <<function_string_name>>) 
				buffer.reset
				buffer.put_message(once "	-- function @(1) (at line @(2) in file @(3) is not wrappable%N",
				<<function_string_name, line_row.to_utf8, c_file.c_string_name>>)
				-- TODO: provide the reason; using developer_exception_name
				-- triggers some recursion bug AFAIK. Paolo 2009-10-02
			elseif not is_public then
				log(once "Skipping 'hidden' function `@(1)'%N", <<function_string_name>>)
				buffer.put_message(once "%T-- `hidden' function @(1) skipped.%N",<<function_string_name>>)
			elseif not is_in_main_namespace then
				log(once "Skipping function `@(1)' belonging to namespace @(2)%N",
				<<function_string_name, namespace.c_string_name>>)
				buffer.put_message(once "%T-- function @(1) in namespace @(2) skipped.%N",
				<<function_string_name, namespace.c_string_name>>)
			elseif avoided.has(function_string_name) then
				log(once "Skipping function `@(1)' as requested.%N", <<function_string_name>>)
				buffer.put_message(once "%T-- function @(1) @(2) skipped as requested.%N", <<function_string_name>>) 
			else
				log(once "Function @(1)",<<function_string_name>>)
				buffer.put_message(once "%T@(1)", <<eiffel_name>>)
				if has_arguments then append_arguments end
				append_return_type
				append_description 
				append_body
				log_string(once "%N")
			end
			buffer.print_on(a_stream)
		end

	append_description is
			-- Put a description on 'buffer' formatting it as an Eiffel comment
			-- with lines shorter that 'description_lenght' characters.  		
		
		-- local description: COLLECTION[STRING];  word: STRING; iter: ITERATOR[STRING];  length,new_length: INTEGER

		do
			-- TODO: implement C_FUNCTION.append_description%N")

			-- description := feature_description(class_name, name)
			-- if description/=Void then
			-- 	from 
			-- 		iter:=a_description.get_new_iterator; iter.start; 
			-- 		buffer.append(once "%N%T%T-- "); length:=0
			-- 	until iter.is_off loop
			-- 		word := iter.item
			-- 		new_length := length + word.count
			-- 		if new_length>description_lenght then
			-- 			buffer.append(once "%N%T%T-- ")
			-- 			length := 0
			-- 		else
			-- 			buffer.put(' ')
			-- 			length := new_length + 1
			-- 		end
			-- 		buffer.append(word)
			-- 		iter.next
			-- 	end
			-- end
		end

	append_arguments is
			-- Append the arguments of function referred by `a_node' into
			-- `buffer'. 

			-- C requires at least one argument before the eventual ellipsis;
			-- C++ allows ellipsis to be the only argument. (source
			-- http://publib.boulder.ibm.com/infocenter/iadthelp/v7r0/index.jsp?topic=/com.ibm.etools.iseries.langref.doc/as400clr155.htm)  
		require has_arguments
		local i, last: INTEGER
		do
			buffer.append(once " (")
			-- Omit the eventual ellipsis
			if is_variadic then -- Skip the last argument
				last:=children_count-1
			else last:= children_count
			end
			log(once "(@(1) args: ",<<children_count.out>>);
			from i:=1 until i>last-1 loop
				argument(i).put_on(buffer)
				buffer.append(once "; ") 
				i := i + 1
			end
			argument(last).put_on(buffer)
			log_string(once ")")
			buffer.append(once ")")
		end

	append_return_type is
			-- Append the Eiffel equivalent type of the return type of
			-- Current node to `buffer' and the "is" keyword, i.e. ": INTEGER_32 is " or ":
			-- POINTER is". When result of `a_node' is "void" only " is" is appended.
		do
			if return_type.is_void then 
				-- don't print anything; the correct "return type" of a C
				-- function returning void (i.e. a command) is an empty string.
			else
				buffer.append(once ": ")
				buffer.append(return_type.wrapper_type)
			end
			buffer.append(once " is%N")
		rescue
			log(once "Unwrappable return type: @(1)... ",<<developer_exception_name>>)
		end

	append_body is
			-- Append the body of function to `buffer'
		local
			actual_c_symbol,description,dir: STRING
		do
			description := function_string_name
			if is_variadic then
				description := description+variadic_function_note
			end
			-- Deal with argument-less functions like "fork". An
			-- argument-less function returning an integer shall be marked with
			-- "()", the empty argument list, otherwise the C compiler will
			-- interpret it as the address of the call casted to an integer.
			if not has_arguments then actual_c_symbol := function_string_name+(once "()")
			else actual_c_symbol := function_string_name
			end
			-- Temporary code to handle output to standard output.
			if directory=Void then dir:=once "the almighty standard output"
			else dir := directory
			end
			-- end of temporary. TODO: remove when the tool is robust enought.
			buffer.put_message(once "%
			% 		-- @(1) (node at line @(3))%N%
			%		external %"plug_in%"%N%
			%		alias %"{%N%
			%			location: %".%"%N%
			%			module_name: %"plugin%"%N%
			%			feature_name: %"@(2)%"%N%
			%		}%"%N%
			%		end%N%N",
			<<description, actual_c_symbol, line.out>>)
		end
		
feature {} -- Implementation
	argument (an_index: INTEGER): C_FUNCTION_ARGUMENT is
		-- The argument at `an_index'.	
	do
		Result?=child(an_index)
	ensure no_child_with_wrong_type: Result/=Void
	end

	stored_eiffel_name: STRING is
		-- Buffered Eiffellized name of Current
		attribute
		end

	compute_eiffel_name is
			
		do
			
		end

-- invariant name.is_equal(once U"Function")
end -- class C_FUNCTION

-- Copyright 2008,2009,2010 Paolo Redaelli

-- wrappers-generator  is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, either version 2 of the License, or (at your option)
-- any later version.

-- wrappers-generator is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.

-- You should have received a copy of the GNU General Public License along with
-- this program.  If not, see <http://www.gnu.org/licenses/>.
