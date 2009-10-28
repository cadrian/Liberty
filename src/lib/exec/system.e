-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
expanded class SYSTEM
	--
	-- This expanded class allow to execute system command and to get/set environment variables.
	--

insert
	ANY

feature {ANY}
	get_environment_variable (variable: STRING): STRING is
			-- Try to get the value of the system environment `variable' or some
			-- `variable' in the system registry. Gives Void when no information
			-- about the `variable' is available. Under UNIX like system, this
			-- is in fact the good way to know about some system environment
			-- variable.
			-- Under Windows, this function also look in the system registery.
		require
			variable /= Void
		local
			p, null: POINTER
		do
			p := variable.to_external
			p := basic_getenv(p)
			if p /= null then
				create Result.from_external_copy(p)
			end
		end

	set_environment_variable (variable, value: STRING) is
			-- Try to assign the system environment `variable' with `value'.
		require
			variable /= Void
			value /= Void
		do
			basic_putenv(variable.to_external, value.to_external)
		end

	execute_command (system_command_line: STRING): INTEGER is
			-- To execute a `system_command_line' as for example, "ls -l" on UNIX.
			-- The `Result' depends of the actual operating system. As an exemple,
			-- this `execute' feature is under UNIX the equivalent of a `system' call.
		require
			only_one_command: not system_command_line.has('%N')
		local
			p: POINTER
		do
			p := system_command_line.to_external
			Result := basic_system(p)
		end

	execute_command_line (system_command_line: STRING) is
			-- The equivalent of `execute_command' without `Result'.
		require
			only_one_command: not system_command_line.has('%N')
		do
			if execute_command(system_command_line) = 0 then
			end
		end

feature {}
	basic_getenv (environment_variable: POINTER): POINTER is
			-- To implement `get_environment_variable'.
		external "plug_in"
		alias "{
			location: "${sys}/runtime"
			module_name: "basic_getenv"
			feature_name: "basic_getenv"
			}"
		end

	basic_putenv (variable, value: POINTER) is
			-- To implement `set_environment_variable'.
		external "plug_in"
		alias "{
			location: "${sys}/runtime"
			module_name: "basic_putenv"
			feature_name: "basic_putenv"
			}"
		end

	basic_system (system_command_line: POINTER): INTEGER is
		external "plug_in"
		alias "{
			location: "${sys}/runtime"
			module_name: "basic_system"
			feature_name: "basic_system"
			}"
		end

end -- class SYSTEM
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
