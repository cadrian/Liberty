-- This file is part of Liberty The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class EFFECT
   --
   -- A parser builder.
   --

insert
   LOGGING

create {}
   make

feature {}
   output_effect, output_reduce, output_position, output_image: TEXT_FILE_WRITE

   connect_or_die (name: ABSTRACT_STRING): TEXT_FILE_WRITE is
      do
         create Result.connect_to(name)
         if not Result.is_connected then
            std_error.put_line("Cannot write file: #(1)" # name)
            die_with_code(1)
         end
      ensure
         Result.is_connected
      end

   generate (name: FIXED_STRING; input: INPUT_STREAM) is
      local
         grammar: PACKRAT_GRAMMAR
         source: STRING
         parser: PACKRAT_PARSER
         error: PARSE_ERROR
         table: PARSE_TABLE[PACKRAT_PARSE_CONTEXT]
         effect_grammar: EFFECT_GRAMMAR_PRINTER
         effect_reduce: EFFECT_REDUCE_PRINTER
      do
         from
            source := ""
            input.read_line
         until
            input.end_of_input
         loop
            source.append(input.last_string)
            source.extend('%N')
            input.read_line
         end
         source.append(input.last_string)

         create grammar.make

         output_effect   := connect_or_die(once "#(1)_effect_grammar.e"  # name)
         output_reduce   := connect_or_die(once "#(1)_effect_reduce.e"   # name)
         output_position := connect_or_die(once "#(1)_effect_position.e" # name)
         output_image    := connect_or_die(once "#(1)_effect_image.e"    # name)

         table := grammar.parse_table(source)
         if table = Void then
            if grammar.error = Void then
               std_error.put_line("**** error")
            else
               from
                  error := parser.error
               until
                  error = Void
               loop
                  std_error.put_line(error.message)
                  error := error.next
               end
            end
            die_with_code(1)
         end

         -- ----------------------------------------------------------------------

         create effect_grammar.make(table)
         output_effect.put_string(once "[
         -- That class was generated by 'effect', please don't edit
         class #(1)_EFFECT_GRAMMAR

         insert
            PACKRAT_INTERNAL
            PACKRAT

         create {ANY}
            make

         feature {ANY}
            table: PARSE_TABLE[PACKRAT_PARSE_CONTEXT] is
               do
                  if table_memory = Void then
                     reset_table
                  end
                  Result := table_memory
               end

         feature {}
            make (a_reducer: like reducer) is
               require
                  a_reducer /= Void
               do
                  reducer := a_reducer
               ensure
                  reducer = a_reducer
               end

               reducer: #(1)_EFFECT_REDUCER

            default_table: PARSE_TABLE[PACKRAT_PARSE_CONTEXT] is
               once
                  Result := #(2)
               end

            table_memory: PARSE_TABLE[PACKRAT_PARSE_CONTEXT]

         invariant
            reducer /= Void

         end -- class #(1)_EFFECT_GRAMMAR

         ]"
           # name.as_upper
           # ("{PARSE_TABLE[PACKRAT_PARSE_CONTEXT] << #(1) >> }" # effect_grammar.out))

         -- ----------------------------------------------------------------------

         create effect_reduce.make(table)
         output_reduce.put_string(once "[
         -- That class was generated by 'effect', please don't edit
         deferred class #(1)_EFFECT_REDUCE

         feature {#(1)_EFFECT}
         #(2)
         end -- class #(1)_EFFECT_REDUCE

         ]"
           # name.as_upper
           # effect_reduce.out)

         -- ----------------------------------------------------------------------

         output_position.put_string(once "[
         -- That class was generated by 'effect', please don't edit
         expanded class #(1)_EFFECT_POSITION

         insert
            PACKRAT_POSITION
               export
                  {#(1)_EFFECT_GRAMMAR} default_create
               end

         end -- class #(1)_EFFECT_POSITION

         ]"
           # name.as_upper)

         -- ----------------------------------------------------------------------

         output_image.put_string(once "[
         -- That class was generated by 'effect', please don't edit
         expanded class #(1)_EFFECT_IMAGE

         insert
            PACKRAT_IMAGE
               export
                  {#(1)_EFFECT_GRAMMAR} make
               redefine
                  position
               end

         feature {}
            position: #(1)_EFFECT_POSITION

         end -- class #(1)_EFFECT_IMAGE

         ]"
           # name.as_upper)

         -- ----------------------------------------------------------------------

         output_effect.disconnect
         output_reduce.disconnect
         output_position.disconnect
         output_image.disconnect
      end

feature {}
   make is
      local
         input: REGULAR_FILE
      do
         if not arguments.parse_command_line then
            arguments.usage(std_error)
            die_with_code(1)
         elseif option_help.is_set then
            arguments.usage(std_output)
            die_with_code(0)
         elseif not arguments.parse_command_line or else not argument_file.is_set then
            arguments.usage(std_error)
            die_with_code(1)
         end

         input := argument_file.item

         if not input.name.has_suffix(".ef") then
            std_error.put_line("File does not have the right suffix (expect *.ef): #(1)" # input.path)
            die_with_code(1)
         end

         if not input.exists then
            std_error.put_line("File does not exist: #(1)" # input.path)
            die_with_code(1)
         end

         generate(input.name.substring(input.name.lower, input.name.upper - 3), input.read)
         input.read.disconnect
      end

   arguments: COMMAND_LINE_ARGUMENTS is
      once
         create Result.make(option_help or argument_file)
      end

   argument_file: COMMAND_LINE_TYPED_ARGUMENT[REGULAR_FILE] is
      once
         Result := cli_factory.positional_file("grammar.ef", "The file containing the grammar (*.ef files)")
      end

   option_help: COMMAND_LINE_TYPED_ARGUMENT[BOOLEAN] is
      once
         Result := cli_factory.option_boolean("h", "help", "Command usage")
      end

   cli_factory: COMMAND_LINE_ARGUMENT_FACTORY

end -- class EFFECT
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- Liberty Eiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- Liberty Eiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with Liberty Eiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright(C) 2011-2012: Cyril ADRIAN, Paolo REDAELLI
--
-- http://liberty-eiffel.blogspot.com - https://github.com/LibertyEiffel/Liberty
--
--
-- Liberty Eiffel is based on SmartEiffel (Copyrights blow)
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- ------------------------------------------------------------------------------------------------------------------------------