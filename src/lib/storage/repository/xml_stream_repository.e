-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class XML_STREAM_REPOSITORY [O_ -> STORABLE]
	--
	-- To be used via streams that commit and update the XML repository
	--
inherit
	XML_REPOSITORY_IMPL[O_]

create {ANY}
	connect_to

feature {ANY} -- Updating and committing
	commit is
		do
			write_to_stream(commit_stream)
		end

	is_commitable: BOOLEAN is
		do
			Result := commit_stream /= Void and then commit_stream.is_connected
		end

	update is
		do
			read_from_stream(update_stream)
		end

	is_updateable: BOOLEAN is
		do
			Result := update_stream /= Void and then update_stream.is_connected
		end

	is_connected: BOOLEAN is
		do
			Result := commit_stream /= Void and then commit_stream.is_connected
		end

feature {ANY} -- Creation
	connect_to (in_stream: like update_stream; out_stream: like commit_stream) is
			-- Connect to a repository with streams as physical store.
		do
			make
			update_stream := in_stream
			commit_stream := out_stream
		end

feature {}
	update_stream: INPUT_STREAM
	commit_stream: OUTPUT_STREAM

end -- class XML_STREAM_REPOSITORY
--
-- Copyright (c) 2009 by all the people cited in the AUTHORS file.
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
