-- See the Copyright notice at the end of this file.
--
expanded class XML_PARSER_BUFFER

insert
   ANY
      redefine
         default_create
      end

create {XML_PARSER}
   default_create, set

feature {XML_PARSER}
   buffer: UNICODE_PARSER_BUFFER
   url: URL
   entity: UNICODE_STRING

   set (a_buffer: like buffer; a_url: like url; a_entity: like entity)
      do
         buffer := a_buffer
         url := a_url
         entity := a_entity
      ensure
         buffer = a_buffer
         url = a_url
         entity = a_entity
      end

   default_create
      do
         set(Void, Void, Void)
      end

end -- class XML_PARSER_BUFFER
--
-- Copyright (C) 2009-2017: by all the people cited in the AUTHORS file.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
