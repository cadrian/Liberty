-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class LOG_INTERNAL_CONF
	--
	-- The internal logging configuration manager
	--

inherit
	EIFFEL_NON_TERMINAL_NODE_IMPL_VISITOR
		undefine
			is_equal
		end
	EIFFEL_TERMINAL_NODE_IMPL_VISITOR
		undefine
			is_equal
		end
	EIFFEL_LIST_NODE_IMPL_VISITOR
		undefine
			is_equal
		end

insert
	SINGLETON

create {LOG_CONFIGURATION}
	make

feature {}
	root: LOGGER
	loggers: HASHED_DICTIONARY[LOGGER, FIXED_STRING]
	outputs: HASHED_DICTIONARY[LOG_OUTPUT, FIXED_STRING]

feature {EIFFEL_NON_TERMINAL_NODE_IMPL}
	visit_eiffel_non_terminal_node_impl (node: EIFFEL_NON_TERMINAL_NODE_IMPL) is
		do
			pass.call([node])
		end

feature {}
	do_pass_1 (on_error: PROCEDURE[TUPLE[STRING]]; path_resolver: FUNCTION[TUPLE[STRING], STRING]; node: EIFFEL_NON_TERMINAL_NODE_IMPL) is
			-- Create outputs and loggers
		require
			on_error /= Void
		local
			output_name: FIXED_STRING; output: LOG_OUTPUT
			logger_name: FIXED_STRING; logger: LOGGER
			term: EIFFEL_TERMINAL_NODE
			num: TYPED_EIFFEL_IMAGE[INTEGER_64]; rotation: INTEGER_64
			rotation_condition: PREDICATE[TUPLE[FILE_STREAM]]
			file_path: STRING
		do
			inspect
				node.name
			when "Configuration" then
				node.node_at(3).accept(Current)
				node.node_at(4).accept(Current)
				node.node_at(2).accept(Current)
				root := loggers.fast_reference_at(last_class_name.intern)
				if root = Void then
					on_error.call(["Unknown root logger: " + last_class_name])
				end
			when "Root" then
				node.node_at(1).accept(Current)
			when "Outputs" then
				node.node_at(1).accept(Current)
			when "Output" then
				node.node_at(0).accept(Current)
				output_name := last_entity_name.intern
				output := outputs.fast_reference_at(output_name)
				if output = Void then
					node.node_at(3).accept(Current)
					-- TODO: to check when the "url" construct is implemented
					file_path := path_resolver.item([last_string])
					create file_options.make(file_path)
					if file_options.is_connected then
						node.node_at(4).accept(Current)
						create output.make(file_options.retriever, output_name)
						outputs.put(output, output_name)
					else
						on_error.call([output_name + ": could not connect to " + file_path])
					end
				else
					on_error.call(["Duplicate output name: " + output_name])
				end
			when "File_Option" then
				inspect
					node.name_at(0)
				when "KW rotated" then
					node.node_at(3).accept(Current)
					node.node_at(2).accept(Current)
				when "KW zipped" then
					node.node_at(2).accept(Current)
					file_options.zipped(last_string.intern)
				end
			when "Rotation" then
				if node.count = 1 then
					rotation := 1
				else
					term ::= node.node_at(1)
					if num ?:= term.image then
						num ::= term.image
						rotation := num.decoded
						if rotation < 1 then
							on_error.call(["Bad retention value: " + term.image.image])
							rotation := 1
						end
					else
						on_error.call(["Bad retention value: " + term.image.image])
						rotation := 1
					end
				end
				inspect
					node.name_at(node.upper)
				when "KW day",      "KW days"      then
					rotation_condition := agent each_days(?, rotation)
				when "KW week",     "KW weeks"     then
					rotation_condition := agent each_weeks(?, rotation, 0)
				when "KW year",     "KW years"     then
					rotation_condition := agent each_years(?, rotation)
				when "KW month",    "KW months"    then
					rotation_condition := agent each_months(?, rotation)
				when "KW hour",     "KW hours"     then
					rotation_condition := agent each_hours(?, rotation)
				when "KW minute",   "KW minutes"   then
					rotation_condition := agent each_minutes(?, rotation)
				when "KW byte",     "KW bytes"     then
					rotation_condition := agent each_bytes(?, rotation)
				when "KW kilobyte", "KW kilobytes" then
					rotation_condition := agent each_bytes(?, rotation * 1024)
				when "KW megabyte", "KW megabytes" then
					rotation_condition := agent each_bytes(?, rotation * 1024 * 1024)
				when "KW gigabyte", "KW gigabytes" then
					rotation_condition := agent each_bytes(?, rotation * 1024 * 1024 * 1024)
				end
				file_options.rotated(rotation_condition, last_retention)
			when "Retention" then
				if node.is_empty then
					last_retention := -1
				else
					term ::= node.node_at(2)
					if num ?:= term.image then
						num ::= term.image
						last_retention := num.decoded
						if last_retention < 0 then
							on_error.call(["Bad retention value: " + term.image.image])
							last_retention := -1
						end
					else
						on_error.call(["Bad retention value: " + term.image.image])
						last_retention := -1
					end
				end
			when "Loggers" then
				node.node_at(1).accept(Current)
			when "Logger" then
				node.node_at(0).accept(Current)
				logger_name := last_class_name.intern
				last_entity_name := Void
				node.node_at(3).accept(Current)
				if last_entity_name = Void then
					output := default_output
				else
					output_name := last_entity_name.intern
					output := outputs.fast_reference_at(output_name)
					if output = Void then
						on_error.call(["Unknown output: " + output_name])
					end
				end
				create logger.make(output, logger_name, generation_id)
				loggers.put(logger, logger_name)
			when "Logger_Output" then
				if not node.is_empty then
					node.node_at(1).accept(Current)
				end
			when "Level" then
				if not node.is_empty then
					node.node_at(1).accept(Current)
				end
			end
		end

	do_pass_2 (on_error: PROCEDURE[TUPLE[STRING]]; node: EIFFEL_NON_TERMINAL_NODE_IMPL) is
			-- Attach loggers' parents
		require
			on_error /= Void
		local
			logger_name: FIXED_STRING; logger, parent: LOGGER
		do
			inspect
				node.name
			when "Configuration" then
				node.node_at(4).accept(Current)
			when "Loggers" then
				node.node_at(1).accept(Current)
			when "Logger" then
				node.node_at(0).accept(Current)
				logger_name := last_class_name.intern
				current_logger := loggers.fast_reference_at(logger_name)
				check
					current_logger /= Void
				end
				node.node_at(2).accept(Current)
				node.node_at(4).accept(Current)
				current_logger.set_level(last_level)
				current_logger := Void
			when "Level" then
				if not node.is_empty then
					node.node_at(1).accept(Current)
				end
			when "Parent" then
				check
					current_logger /= Void
				end
				last_level := levels.trace
				if not node.is_empty then
					if logger = root then
						on_error.call([once "The root logger cannot have a parent"])
					else
						last_class_name := Void
						node.node_at(1).accept(Current)
						if last_class_name /= Void then
							parent := loggers.fast_reference_at(last_class_name.intern)
							if parent /= Void then
								current_logger.set_parent(parent)
								last_level := parent.level
							else
								on_error.call(["Unknown logger " + last_class_name + " for logger " + logger_name])
							end
						else
							logger.set_parent(root)
						end
					end
				end
			end
		end

	file_options: LOG_FILE_OPTIONS

	each_days (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		local
			now, last_change: TIME; elapsed: REAL
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			elseif now.year /= last_change.year or else now.year_day /= last_change.year_day then
				elapsed := last_change.elapsed_seconds(now)
				Result := elapsed >= (number * 86400).force_to_real_64
			end
		end

	each_weeks (stream: FILE_STREAM; number: INTEGER_64; week_day: INTEGER): BOOLEAN is
		require
			number > 0
			week_day.in_range(0, 6)
		local
			now, last_change: TIME; elapsed: REAL
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			elseif now.year /= last_change.year or else now.year_day /= last_change.year_day then
				-- TODO: not sure of that algorithm (thought power exhausted)
				elapsed := last_change.elapsed_seconds(now)
				if last_change.week_day = week_day then
					Result := elapsed >= ((number - 1) * 86400 * 7).force_to_real_64
				else
					Result := elapsed >= (number * 86400 * 7).force_to_real_64
				end
			end
		end

	each_months (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		local
			now, last_change: TIME
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			else
				Result := (now.year - last_change.year) * 12 + (now.month - last_change.month) >= number
			end
		end

	each_years (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		local
			now, last_change: TIME
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			else
				Result := (now.year - last_change.year) >= number
			end
		end

	each_hours (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		local
			now, last_change: TIME; elapsed: REAL
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			elseif now.year /= last_change.year or else now.year_day /= last_change.year_day or else now.hour /= last_change.hour then
				elapsed := last_change.elapsed_seconds(now)
				Result := elapsed >= (number * 3600).force_to_real_64
			end
		end

	each_minutes (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		local
			now, last_change: TIME; elapsed: REAL
		do
			now.update
			last_change := ft.last_change_of(stream.path)
			if now < last_change then
				Result := True
			elseif now.year /= last_change.year or else now.year_day /= last_change.year_day or else now.hour /= last_change.hour or else now.minute /= last_change.minute then
				elapsed := last_change.elapsed_seconds(now)
				Result := elapsed >= (number * 60).force_to_real_64
			end
		end

	each_bytes (stream: FILE_STREAM; number: INTEGER_64): BOOLEAN is
		require
			number > 0
		do
			Result := ft.size_of(stream.path) >= number
		end

	ft: FILE_TOOLS

feature {EIFFEL_TERMINAL_NODE_IMPL}
	visit_eiffel_terminal_node_impl (node: EIFFEL_TERMINAL_NODE_IMPL) is
		local
			string: TYPED_EIFFEL_IMAGE[STRING]
		do
			inspect
				node.name
			when "KW class name" then
				last_class_name := node.image.image
			when "KW entity name" then
				last_entity_name := node.image.image
			when "KW string" then
				string ::= node.image
				last_string := string.decoded
			when "KW number" then
				last_number := node.image
			when "KW error" then
				last_level := levels.error
			when "KW warning" then
				last_level := levels.warning
			when "KW info" then
				last_level := levels.info
			when "KW trace" then
				last_level := levels.trace
			else
				-- nothing (syntax sugar)
			end
		end

	fatal_error (message: STRING) is
		do
			std_error.put_line(message)
			die_with_code(1)
		end

	default_path_resolver: FUNCTION[TUPLE[STRING], STRING] is
		once
			Result := agent resolve_path
		end

	resolve_path (a_path: STRING): STRING is
		do
			Result := a_path
		end

feature {EIFFEL_LIST_NODE_IMPL}
	visit_eiffel_list_node_impl (node: EIFFEL_LIST_NODE_IMPL) is
		local
			i: INTEGER
		do
			from
				i := node.lower
			until
				i > node.upper
			loop
				node.item(i).accept(Current)
				i := i + 1
			end
		end

feature {LOG_CONFIGURATION}
	load (a_stream: INPUT_STREAM; when_error: PROCEDURE[TUPLE[STRING]]; a_path_resolver: FUNCTION[TUPLE[STRING], STRING]) is
		local
			conf: STRING
			on_error: like when_error
			path_resolver: FUNCTION[TUPLE[STRING], STRING]
		do
			generations.increment

			if when_error = Void then
				on_error := agent fatal_error
			else
				on_error := when_error
			end

			if a_path_resolver = Void then
				path_resolver := default_path_resolver
			else
				path_resolver := a_path_resolver
			end

			loggers.clear_count
			outputs.clear_count

			conf := once ""
			conf.clear_count
			from
				a_stream.read_line
			until
				a_stream.end_of_input
			loop
				conf.append(a_stream.last_string)
				conf.extend('%N')
				a_stream.read_line
			end
			conf.append(a_stream.last_string)
			parser_buffer.initialize_with(conf)

			grammar.reset
			if parser.eval(parser_buffer, grammar.table, once "Configuration") then
				if parser.error /= Void then
					on_error.call([parser.error.message])
				else
					pass := agent do_pass_1(on_error, path_resolver, ?)
					grammar.root_node.accept(Current)
					pass := agent do_pass_2(on_error, ?)
					grammar.root_node.accept(Current)
				end
			else
				if when_error /= Void then
					when_error.call(["Unknown error while loading log configuration"])
				else
					std_error.put_line("Unknown error while loading log configuration")
					die_with_code(1)
				end
			end
		end

	conf_logger (a_tag: FIXED_STRING): LOGGER is
		require
			a_tag.intern = a_tag
		local
			i: INTEGER; parent: LOGGER; parent_tag: FIXED_STRING
		do
			if loggers = Void then
				load_default
			end

			Result := loggers.fast_reference_at(a_tag)
			if Result = Void then
				i := a_tag.first_index_of('[')
				if a_tag.valid_index(i) then
					parent_tag := a_tag.substring(a_tag.lower, i - 1).intern
					parent := loggers.fast_reference_at(parent_tag)
					if parent = Void then
						create parent.make(root.output, parent_tag, generation_id)
						parent.set_parent(root)
						loggers.put(parent, parent_tag)
					end
				else
					parent := root
				end
				check
					parent /= Void
				end
				create Result.make(parent.output, a_tag, generation_id)
				Result.set_parent(parent)
				loggers.put(Result, a_tag)
			end
		ensure
			Result /= Void
		end

	generation_id: INTEGER is
		do
			Result := generations.value
		end

feature {}
	make is
		do
			create generations
		end

	load_default is
		local
			in: TEXT_FILE_READ
			o: LOG_OUTPUT
		do
			if loggers = Void then
				create loggers.make
				check
					outputs = Void
				end
				create outputs.make
			end

			if ft.file_exists("log.rc") then
				create in.connect_to("log.rc")
				if in.is_connected then
					load(in, Void, Void)
					in.disconnect
				end
				if root = Void then
					std_error.put_line(once "Could not initialize the logging framework.%NPlease check your log.rc file or explicitly call LOG_CONFIGURATION.load")
					die_with_code(1)
				end
			else
				generations.increment
				create o.make(agent pass_through(std_output), "root".intern)
				create root.make(o, "root".intern, generation_id)
				root.set_level(levels.info)
			end
		end

	last_class_name: STRING
	last_entity_name: STRING
	last_string: STRING
	last_number: EIFFEL_IMAGE
	last_level: LOG_LEVEL
	last_retention: INTEGER_64
	current_logger: LOGGER
	pass: PROCEDURE[TUPLE[EIFFEL_NON_TERMINAL_NODE_IMPL]]

	levels: LOG_LEVELS

	grammar: LOG_GRAMMAR is
		once
			create Result.make(create {LOG_NODE_FACTORY}.make)
		end

	parser_buffer: MINI_PARSER_BUFFER is
		once
			create Result
		end

	parser: DESCENDING_PARSER is
		once
			create Result.make
		end

	default_output: LOG_OUTPUT is
		once
			create Result.make(agent pass_through(std_output), "default".intern)
		end

	generations: COUNTER

	pass_through (a_output: OUTPUT_STREAM): OUTPUT_STREAM is
		do
			Result := a_output
		end

end -- class LOG_INTERNAL_CONF
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