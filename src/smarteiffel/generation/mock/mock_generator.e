-- This file is part of Liberty Eiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class MOCK_GENERATOR

insert
   GLOBALS

feature {MOCK}
   generate (features: MAP[ANONYMOUS_FEATURE, FEATURE_NAME])
      require
         features /= Void
      local
         i: INTEGER
      do
         create file.connect_to(file_name)
         if file.is_connected then
            echo.put_string(once "Generating features for ")
            echo.put_string(file_name)
            echo.put_new_line
            generate_class_opening
            generate_class_header
            from
               i := features.lower
            until
               i > features.upper
            loop
               echo.put_string(once " - ")
               echo.put_line(features.key(i).to_string)
               signature.prepare(features.key(i), features.item(i))
               generate_feature
               signature.recycle
               i := i + 1
            end
            generate_class_footer
            generate_class_closing
            file.disconnect
         else
            error_handler.append(once "Could not write to ")
            error_handler.append(file_name)
            error_handler.print_as_fatal_error
         end
      end

   sibling: MOCK_GENERATOR

   set_sibling (s: like sibling) assign sibling
      require
         s.mocked_class = mocked_class
         sibling = Void
      do
         sibling := s
      ensure
         sibling = s
      end

feature {MOCK_GENERATOR}
   class_name: STRING
   mocked_class: CLASS_TEXT

feature {}
   generate_class_opening
      local
         now: TIME; date: STRING
      do
         now.update
         formatter.set_time(now)
         date := once ""
         date.clear_count
         formatter.append_in(date)
         file.put_string(once "-- File generated by `se mock' on ")
         file.put_line(date)
         file.put_string(once "class ")
         file.put_line(class_name)
      end

   generate_class_header
      require
         file.is_connected
      deferred
      end

   generate_class_footer
      require
         file.is_connected
      deferred
      end

   generate_class_closing
      do
         file.put_string(once "end -- class ")
         file.put_line(class_name)
      end

   generate_feature
      require
         file.is_connected
         signature.is_ready
      deferred
      end

feature {}
   make (a_mocked_class: like mocked_class; a_file_name: like file_name)
      require
         a_mocked_class /= Void
         a_file_name.has_suffix(once ".e")
      local
         bd: BASIC_DIRECTORY
      do
         mocked_class := a_mocked_class
         file_name := a_file_name
         bd.compute_short_name_of(file_name)
         class_name := bd.last_entry.twin
         class_name.remove_suffix(once ".e")
         class_name.to_upper
      ensure
         mocked_class = a_mocked_class
         file_name = a_file_name
      end

   formatter: TIME_IN_ENGLISH
      once
         create Result
      end

   file_name: STRING
   file: TEXT_FILE_WRITE

   signature: MOCK_SIGNATURE
      once
         create Result.make
      end

invariant
   class_name /= Void
   file_name /= Void
   sibling /= Current
   sibling /= Void implies sibling.mocked_class = mocked_class

end -- class MOCK_GENERATOR
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
-- Copyright (C) 2011-2017: Cyril ADRIAN
--
-- http://www.gnu.org/software/liberty-eiffel/
--
--
-- Liberty Eiffel is based on SmartEiffel (Copyrights below)
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- ------------------------------------------------------------------------------------------------------------------------------
