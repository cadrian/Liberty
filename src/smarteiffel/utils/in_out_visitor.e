-- This file is part of Liberty Eiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class IN_OUT_VISITOR
   --
   -- Default definition of a class traversal. Each "node" has `entry' and `exit' features; the `entry'
   -- feature returns a BOOLEAN which controls the traversal of the subtree.
   --

inherit
      -- "single" visitors
   AGENT_ARGS_VISITOR
   ASSERTION_VISITOR
   CLASS_NAME_VISITOR
   CLASS_TEXT_VISITOR
   CLIENT_LIST_VISITOR
   CREATION_CLAUSE_LIST_VISITOR
   CREATION_CLAUSE_VISITOR
   DECLARATION_VISITOR
   EFFECTIVE_ARG_LIST_VISITOR
   EXPORT_ITEM_VISITOR
   EXPORT_LIST_VISITOR
   FEATURE_CLAUSE_LIST_VISITOR
   FEATURE_CLAUSE_VISITOR
   FEATURE_NAME_LIST_VISITOR
   FEATURE_NAME_VISITOR
   FEATURE_TEXT_VISITOR
   FORMAL_ARG_LIST_VISITOR
   LOCAL_VAR_LIST_VISITOR
   LOOP_VARIANT_VISITOR
   PARENT_EDGE_VISITOR
   PARENT_LISTS_VISITOR
   RENAME_LIST_VISITOR
   RENAME_PAIR_VISITOR
   REQUIRE_ASSERTION_VISITOR
   TYPE_MARK_LIST_VISITOR
   TYPE_VISITOR
   WHEN_CLAUSE_VISITOR

      -- "group" visitors
   LOCAL_ARGUMENT_VISITOR
   TYPE_MARK_VISITOR
   ANONYMOUS_FEATURE_VISITOR
   EXPRESSION_VISITOR
   INSTRUCTION_VISITOR
   ASSERTION_LIST_VISITOR
   WHEN_ITEM_VISITOR
   AGENT_LAUNCHER_VISITOR

feature {CLASS_TEXT}
   visit_class_text (visited: CLASS_TEXT) is
      do
         if enter_class_text(visited) then
            if not visitting_class_texts.has(visited) then
               visitting_class_texts.add(visited)
               if visited.parent_lists /= Void then
                  visited.parent_lists.accept(Current)
               end
               if visited.creation_clause_list /= Void then
                  visited.creation_clause_list.accept(Current)
               end
               if visited.feature_clause_list /= Void then
                  visited.feature_clause_list.accept(Current)
               end
               if visited.class_invariant /= Void then
                  visited.class_invariant.accept(Current)
               end
               visitting_class_texts.remove(visited)
            end
            exit_class_text(visited)
         end
      end

feature {}
   enter_class_text (visited: CLASS_TEXT): BOOLEAN is
      do
         Result := True
      end

   exit_class_text (visited: CLASS_TEXT) is
      do
      end

   visitting_class_texts: SET[CLASS_TEXT] is
      once
         create {HASHED_SET[CLASS_TEXT]} Result.make
      end

feature {PARENT_LISTS}
   visit_parent_lists (visited: PARENT_LISTS) is
      local
         i, n: INTEGER
         list: FAST_ARRAY[PARENT_EDGE]
      do
         if enter_parent_lists(visited) then
            from
               list := visited.inherit_list
               if list = Void then
                  n := 0
               else
                  n := list.count
               end
               i := 0
            until
               i >= n
            loop
               list.item(i).accept(Current)
               i := i + 1
            end
            from
               list := visited.insert_list
               if list = Void then
                  n := 0
               else
                  n := list.count
               end
               i := 0
            until
               i >= n
            loop
               list.item(i).accept(Current)
               i := i + 1
            end
            exit_parent_lists(visited)
         end
      end

feature {}
   enter_parent_lists (visited: PARENT_LISTS): BOOLEAN is
      do
         Result := True
      end

   exit_parent_lists (visited: PARENT_LISTS) is
      do
      end

feature {PARENT_EDGE}
   visit_parent_edge (visited: PARENT_EDGE) is
      do
         if enter_parent_edge(visited) then
            visited.type_mark.accept(Current)
            if visited.rename_list /= Void then
               visited.rename_list.accept(Current)
            end
            if visited.export_list /= Void then
               visited.export_list.accept(Current)
            end
            if visited.undefine_list /= Void then
               visited.undefine_list.accept(Current)
            end
            if visited.redefine_list /= Void then
               visited.redefine_list.accept(Current)
            end
            exit_parent_edge(visited)
         end
      end

feature {}
   enter_parent_edge (visited: PARENT_EDGE): BOOLEAN is
      do
         Result := True
      end

   exit_parent_edge (visited: PARENT_EDGE) is
      do
      end

feature {RENAME_LIST}
   visit_rename_list (visited: RENAME_LIST) is
      local
         i: INTEGER
      do
         if enter_rename_list(visited) then
            if visited.list /= Void then
               from
                  i := visited.list.lower
               until
                  i > visited.list.upper
               loop
                  visited.list.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_rename_list(visited)
         end
      end

feature {}
   enter_rename_list (visited: RENAME_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_rename_list (visited: RENAME_LIST) is
      do
      end

feature {RENAME_PAIR}
   visit_rename_pair (visited: RENAME_PAIR) is
      do
         if enter_rename_pair(visited) then
            visited.old_name.accept(Current)
            visited.new_name.accept(Current)
            exit_rename_pair(visited)
         end
      end

feature {}
   enter_rename_pair (visited: RENAME_PAIR): BOOLEAN is
      do
         Result := True
      end

   exit_rename_pair (visited: RENAME_PAIR) is
      do
      end

feature {EXPORT_LIST}
   visit_export_list (visited: EXPORT_LIST) is
      local
         i: INTEGER
      do
         if enter_export_list(visited) then
            if visited.items /= Void then
               from
                  i := visited.items.lower
               until
                  i > visited.items.upper
               loop
                  visited.items.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_export_list(visited)
         end
      end

feature {}
   enter_export_list (visited: EXPORT_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_export_list (visited: EXPORT_LIST) is
      do
      end

feature {EXPORT_ITEM}
   visit_export_item (visited: EXPORT_ITEM) is
      do
         if enter_export_item(visited) then
            visited.clients.accept(Current)
            if visited.list /= Void then
               visited.list.accept(Current)
            end
            exit_export_item(visited)
         end
      end

feature {}
   enter_export_item (visited: EXPORT_ITEM): BOOLEAN is
      do
         Result := True
      end

   exit_export_item (visited: EXPORT_ITEM) is
      do
      end

feature {FEATURE_CLAUSE_LIST}
   visit_feature_clause_list (visited: FEATURE_CLAUSE_LIST) is
      local
         i: INTEGER
      do
         if enter_feature_clause_list(visited) then
            from
               i := visited.list.lower
            until
               i > visited.list.upper
            loop
               visited.list.item(i).accept(Current)
               i := i + 1
            end
            exit_feature_clause_list(visited)
         end
      end

feature {}
   enter_feature_clause_list (visited: FEATURE_CLAUSE_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_feature_clause_list (visited: FEATURE_CLAUSE_LIST) is
      do
      end

feature {FEATURE_CLAUSE}
   visit_feature_clause (visited: FEATURE_CLAUSE) is
      local
         i: INTEGER
      do
         if enter_feature_clause(visited) then
            if visited.clients /= Void then
               visited.clients.accept(Current)
            end
            if visited.list /= Void then
               from
                  i := visited.list.lower
               until
                  i > visited.list.upper
               loop
                  visited.list.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_feature_clause(visited)
         end
      end

feature {}
   enter_feature_clause (visited: FEATURE_CLAUSE): BOOLEAN is
      do
         Result := True
      end

   exit_feature_clause (visited: FEATURE_CLAUSE) is
      do
      end

feature {CREATION_CLAUSE_LIST}
   visit_creation_clause_list (visited: CREATION_CLAUSE_LIST) is
      local
         i: INTEGER
      do
         if enter_creation_clause_list(visited) then
            from
               i := visited.list.lower
            until
               i > visited.list.upper
            loop
               visited.list.item(i).accept(Current)
               i := i + 1
            end
            exit_creation_clause_list(visited)
         end
      end

feature {}
   enter_creation_clause_list (visited: CREATION_CLAUSE_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_creation_clause_list (visited: CREATION_CLAUSE_LIST) is
      do
      end

feature {CREATION_CLAUSE}
   visit_creation_clause (visited: CREATION_CLAUSE) is
      do
         if enter_creation_clause(visited) then
            if visited.clients /= Void then
               visited.clients.accept(Current)
            end
            if visited.procedure_list /= Void then
               visited.procedure_list.accept(Current)
            end
            exit_creation_clause(visited)
         end
      end

feature {}
   enter_creation_clause (visited: CREATION_CLAUSE): BOOLEAN is
      do
         Result := True
      end

   exit_creation_clause (visited: CREATION_CLAUSE) is
      do
      end

feature {CLIENT_LIST}
   visit_client_list (visited: CLIENT_LIST) is
      do
         if enter_client_list(visited) then
            if visited.type_mark_list /= Void then
               visited.type_mark_list.accept(Current)
            end
            exit_client_list(visited)
         end
      end

feature {}
   enter_client_list (visited: CLIENT_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_client_list (visited: CLIENT_LIST) is
      do
      end

feature {TYPE_MARK_LIST}
   visit_type_mark_list (visited: TYPE_MARK_LIST) is
      local
         i: INTEGER
      do
         if enter_type_mark_list(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.item(i).accept(Current)
               i := i + 1
            end
            exit_type_mark_list(visited)
         end
      end

feature {}
   enter_type_mark_list (visited: TYPE_MARK_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_type_mark_list (visited: TYPE_MARK_LIST) is
      do
      end

feature {CLASS_NAME}
   visit_class_name (visited: CLASS_NAME) is
      do
      end

feature {FEATURE_TEXT}
   visit_feature_text (visited: FEATURE_TEXT) is
      do
         if enter_feature_text(visited) then
            visited.anonymous_feature.accept(Current)
            exit_feature_text(visited)
         end
      end

feature {}
   enter_feature_text (visited: FEATURE_TEXT): BOOLEAN is
      do
         Result := True
      end

   exit_feature_text (visited: FEATURE_TEXT) is
      do
      end

feature {FORMAL_ARG_LIST}
   visit_formal_arg_list (visited: FORMAL_ARG_LIST) is
      local
         i: INTEGER
      do
         if enter_formal_arg_list(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.type_mark(i).accept(Current)
               i := i + 1
            end
            exit_formal_arg_list(visited)
         end
      end

feature {}
   enter_formal_arg_list (visited: FORMAL_ARG_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_formal_arg_list (visited: FORMAL_ARG_LIST) is
      do
      end

feature {LOCAL_VAR_LIST}
   visit_local_var_list (visited: LOCAL_VAR_LIST) is
      local
         i: INTEGER
      do
         if enter_local_var_list(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.type_mark(i).accept(Current)
               i := i + 1
            end
            exit_local_var_list(visited)
         end
      end

feature {}
   enter_local_var_list (visited: LOCAL_VAR_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_local_var_list (visited: LOCAL_VAR_LIST) is
      do
      end

feature {CLOSED_OPERAND}
   visit_closed_operand (visited: CLOSED_OPERAND) is
      do
         visited.original_capture.accept(Current)
      end

feature {UNUSED_EXPRESSION}
   visit_unused_expression (visited: UNUSED_EXPRESSION) is
      do
      end

feature {LOCAL_NAME_DEF}
   visit_local_name1 (visited: LOCAL_NAME_DEF) is
      do
      end

feature {ARGUMENT_NAME_DEF}
   visit_argument_name1 (visited: ARGUMENT_NAME_DEF) is
      do
      end

feature {LOCAL_NAME_REF}
   visit_local_name2 (visited: LOCAL_NAME_REF) is
      do
      end

feature {ARGUMENT_NAME_REF}
   visit_argument_name2 (visited: ARGUMENT_NAME_REF) is
      do
      end

feature {INTERNAL_LOCAL2}
   visit_internal_local2 (visited: INTERNAL_LOCAL2) is
      do
      end

feature {DYNAMIC_DISPATCH_TEMPORARY1}
   visit_dynamic_dispatch_temporary1 (visited: DYNAMIC_DISPATCH_TEMPORARY1) is
      do
      end

feature {DYNAMIC_DISPATCH_TEMPORARY1_ID}
   visit_dynamic_dispatch_temporary1_id (visited: DYNAMIC_DISPATCH_TEMPORARY1_ID) is
      do
      end

feature {DYNAMIC_DISPATCH_TEMPORARY2}
   visit_dynamic_dispatch_temporary2 (visited: DYNAMIC_DISPATCH_TEMPORARY2) is
      do
      end

feature {SEDB}
   visit_sedb (visited: SEDB) is
      do
      end

feature {NO_DISPATCH}
   visit_no_dispatch (visited: NO_DISPATCH) is
      do
         visited.side_effect_free_expression.accept(Current)
      end

feature {TYPE}
   visitting_types: SET[TYPE] is
      once
         create {HASHED_SET[TYPE]} Result.make
      end

   visit_type (visited: TYPE) is
      local
         i: INTEGER; gl: ARRAY[TYPE]
      do
         if enter_type(visited) then
            if not visitting_types.has(visited) then
               visitting_types.add(visited)
               visited.class_text.accept(Current)
               if visited.is_generic then
                  gl := visited.generic_list
                  if gl /= Void then
                     from
                        i := gl.lower
                     until
                        i > gl.upper
                     loop
                        gl.item(i).accept(Current)
                        i := i + 1
                     end
                  end
               end
               if visited.is_agent then
                  if visited.open_arguments /= Void then
                     from
                        i := visited.open_arguments.lower
                     until
                        i > visited.open_arguments.upper
                     loop
                        visited.open_arguments.item(i).accept(Current)
                        i := i + 1
                     end
                  end
                  if visited.agent_result /= Void then
                     visited.agent_result.accept(Current)
                  end
               end
               visitting_types.remove(visited)
            end
            exit_type(visited)
         end
      end

feature {}
   enter_type (visited: TYPE): BOOLEAN is
      do
         Result := True
      end

   exit_type (visited: TYPE) is
      do
      end

feature {CLASS_TYPE_MARK}
   visit_class_type_mark (visited: CLASS_TYPE_MARK) is
      do
         if enter_class_type_mark(visited) then
            visited.class_text.accept(Current)
            visited.class_text_name.accept(Current)
            exit_class_type_mark(visited)
         end
      end

feature {}
   enter_class_type_mark (visited: CLASS_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_class_type_mark (visited: CLASS_TYPE_MARK) is
      do
      end

feature {CLIENT_TYPE_MARK}
   visit_client_type_mark (visited: CLIENT_TYPE_MARK) is
      local
         ct: CLASS_TEXT
      do
         if enter_client_type_mark(visited) then
            ct := visited.try_class_text
            if ct /= Void then
               ct.accept(Current)
            end
            exit_client_type_mark(visited)
         end
      end

feature {}
   enter_client_type_mark (visited: CLIENT_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_client_type_mark (visited: CLIENT_TYPE_MARK) is
      do
      end

feature {LIKE_FEATURE_TYPE_MARK}
   visit_like_feature_type_mark (visited: LIKE_FEATURE_TYPE_MARK) is
      do
         if enter_like_feature_type_mark(visited) then
            --|*** visited.like_what.accept(Current)
            --|*** Don't know what to do here ? *** (Dom dec 12 th 2004) ***
            exit_like_feature_type_mark(visited)
         end
      end

feature {}
   enter_like_feature_type_mark (visited: LIKE_FEATURE_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_like_feature_type_mark (visited: LIKE_FEATURE_TYPE_MARK) is
      do
      end

feature {LIKE_ARGUMENT_TYPE_MARK}
   visit_like_argument_type_mark (visited: LIKE_ARGUMENT_TYPE_MARK) is
      do
         if enter_like_argument_type_mark(visited) then
            visited.like_what.accept(Current)
            exit_like_argument_type_mark(visited)
         end
      end

feature {}
   enter_like_argument_type_mark (visited: LIKE_ARGUMENT_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_like_argument_type_mark (visited: LIKE_ARGUMENT_TYPE_MARK) is
      do
      end

feature {LIKE_CURRENT_TYPE_MARK}
   visit_like_current_type_mark (visited: LIKE_CURRENT_TYPE_MARK) is
      do
      end

feature {AGENT_TYPE_MARK}
   visit_agent_type_mark (visited: AGENT_TYPE_MARK) is
      do
         if enter_agent_type_mark(visited) then
            visited.class_text.accept(Current)
            visited.written_open.accept(Current)
            if visited.result_type /= Void then
               visited.result_type.accept(Current)
            end
            exit_agent_type_mark(visited)
         end
      end

feature {}
   enter_agent_type_mark (visited: AGENT_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_agent_type_mark (visited: AGENT_TYPE_MARK) is
      do
      end

feature {ANY_TYPE_MARK}
   visit_any_type_mark (visited: ANY_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {STRING_TYPE_MARK}
   visit_string_type_mark (visited: STRING_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {FORMAL_GENERIC_TYPE_MARK}
   visit_formal_generic_type_mark (visited: FORMAL_GENERIC_TYPE_MARK) is
      do
      end

feature {}
   visit_generic_type_mark (visited: TYPE_MARK) is
      local
         i: INTEGER
      do
         if visited.generic_list /= Void then
            from
               i := visited.generic_list.lower
            until
               i > visited.generic_list.upper
            loop
               visited.generic_list.item(i).accept(Current)
               i := i + 1
            end
         end
      end

feature {USER_GENERIC_TYPE_MARK}
   visit_user_generic_type_mark (visited: USER_GENERIC_TYPE_MARK) is
      do
         if enter_user_generic_type_mark(visited) then
            visit_generic_type_mark(visited)
            exit_user_generic_type_mark(visited)
         end
      end

feature {}
   enter_user_generic_type_mark (visited: USER_GENERIC_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_user_generic_type_mark (visited: USER_GENERIC_TYPE_MARK) is
      do
      end

feature {EMPTY_TUPLE_TYPE_MARK}
   visit_empty_tuple_type_mark (visited: EMPTY_TUPLE_TYPE_MARK) is
      do
      end

feature {NON_EMPTY_TUPLE_TYPE_MARK}
   visit_non_empty_tuple_type_mark (visited: NON_EMPTY_TUPLE_TYPE_MARK) is
      do
         if enter_non_empty_tuple_type_mark(visited) then
            visit_generic_type_mark(visited)
            exit_non_empty_tupe_type_mark(visited)
         end
      end

feature {}
   enter_non_empty_tuple_type_mark (visited: NON_EMPTY_TUPLE_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_non_empty_tupe_type_mark (visited: NON_EMPTY_TUPLE_TYPE_MARK) is
      do
      end

feature {ARRAY_TYPE_MARK}
   visit_array_type_mark (visited: ARRAY_TYPE_MARK) is
      do
         if enter_array_type_mark(visited) then
            visited.class_text.accept(Current)
            visit_generic_type_mark(visited)
            exit_array_type_mark(visited)
         end
      end

feature {}
   enter_array_type_mark (visited: ARRAY_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_array_type_mark (visited: ARRAY_TYPE_MARK) is
      do
      end

feature {NATIVE_ARRAY_TYPE_MARK}
   visit_native_array_type_mark (visited: NATIVE_ARRAY_TYPE_MARK) is
      do
         if enter_native_array_type_mark(visited) then
            visited.class_text.accept(Current)
            visit_generic_type_mark(visited)
            exit_native_array_type_mark(visited)
         end
      end

feature {}
   enter_native_array_type_mark (visited: NATIVE_ARRAY_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_native_array_type_mark (visited: NATIVE_ARRAY_TYPE_MARK) is
      do
      end

feature {WEAK_REFERENCE_TYPE_MARK}
   visit_weak_reference_type_mark (visited: WEAK_REFERENCE_TYPE_MARK) is
      do
         if enter_weak_reference_type_mark(visited) then
            visited.class_text.accept(Current)
            visit_generic_type_mark(visited)
            exit_weak_reference_type_mark(visited)
         end
      end

feature {}
   enter_weak_reference_type_mark (visited: WEAK_REFERENCE_TYPE_MARK): BOOLEAN is
      do
         Result := True
      end

   exit_weak_reference_type_mark (visited: WEAK_REFERENCE_TYPE_MARK) is
      do
      end

feature {BOOLEAN_TYPE_MARK}
   visit_boolean_type_mark (visited: BOOLEAN_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {POINTER_TYPE_MARK}
   visit_pointer_type_mark (visited: POINTER_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {REAL_TYPE_MARK}
   visit_real_type_mark (visited: REAL_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {INTEGER_TYPE_MARK}
   visit_integer_type_mark (visited: INTEGER_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {CHARACTER_TYPE_MARK}
   visit_character_type_mark (visited: CHARACTER_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {NATURAL_TYPE_MARK}
   visit_natural_type_mark (visited: NATURAL_TYPE_MARK) is
      do
         visited.class_text.accept(Current)
      end

feature {WRITABLE_ATTRIBUTE}
   visit_writable_attribute (visited: WRITABLE_ATTRIBUTE) is
      do
         if enter_writable_attribute(visited) then
            visited.result_type.accept(Current)
            exit_writable_attribute(visited)
         end
      end

feature {}
   enter_writable_attribute (visited: WRITABLE_ATTRIBUTE): BOOLEAN is
      do
         Result := True
      end

   exit_writable_attribute (visited: WRITABLE_ATTRIBUTE) is
      do
      end

feature {CST_ATT_REAL}
   visit_cst_att_real (visited: CST_ATT_REAL) is
      do
      end

feature {CST_ATT_INTEGER}
   visit_cst_att_integer (visited: CST_ATT_INTEGER) is
      do
      end

feature {CST_ATT_BOOLEAN}
   visit_cst_att_boolean (visited: CST_ATT_BOOLEAN) is
      do
      end

feature {CST_ATT_UNIQUE}
   visit_cst_att_unique (visited: CST_ATT_UNIQUE) is
      do
      end

feature {CST_ATT_STRING}
   visit_cst_att_string (visited: CST_ATT_STRING) is
      do
      end

feature {CST_ATT_CHARACTER}
   visit_cst_att_character (visited: CST_ATT_CHARACTER) is
      do
      end

feature {}
   visitting_anonymous_features: HASHED_SET[POINTER] is
      once
         create Result.make
      end

   visit_anonymous_feature (visited: ANONYMOUS_FEATURE) is
      local
         visited_pointer: POINTER
      do
         visited_pointer := visited.to_pointer
         if not visitting_anonymous_features.has(visited_pointer) then
            visitting_anonymous_features.add(visited_pointer)
            do_visit_anonymous_feature(visited)
            visitting_anonymous_features.remove(visited_pointer)
         end
      end

   do_visit_anonymous_feature (visited: ANONYMOUS_FEATURE) is
      do
         if visited.result_type /= Void then
            visited.result_type.accept(Current)
         end
         if visited.require_assertion /= Void then
            visited.require_assertion.accept(Current)
         end
         if visited.ensure_assertion /= Void then
            visited.ensure_assertion.accept(Current)
         end
      end

   visitting_effective_routines: HASHED_SET[POINTER] is
      once
         create Result.make
      end

   visit_effective_routine (visited: EFFECTIVE_ROUTINE) is
      local
         visited_pointer: POINTER
      do
         visited_pointer := visited.to_pointer
         if not visitting_effective_routines.has(visited_pointer) then
            visitting_effective_routines.add(visited_pointer)
            do_visit_effective_routine(visited)
            visitting_effective_routines.remove(visited_pointer)
         end
      end

   do_visit_effective_routine (visited: EFFECTIVE_ROUTINE) is
      do
         visit_anonymous_feature(visited)
         if visited.arguments /= Void then
            visited.arguments.accept(Current)
         end
         if visited.local_vars /= Void then
            visited.local_vars.accept(Current)
         end
         if visited.routine_body /= Void then
            visited.routine_body.accept(Current)
         end
         if visited.rescue_compound /= Void then
            visited.rescue_compound.accept(Current)
         end
      end

feature {VOID_CALL}
   visit_void_call (visited: VOID_CALL) is
      do
      end

feature {VOID_PROC_CALL}
   visit_void_proc_call (visited: VOID_PROC_CALL) is
      do
      end

feature {RUN_TIME_ERROR_INSTRUCTION}
   visit_run_time_error_instruction (visited: RUN_TIME_ERROR_INSTRUCTION) is
      do
      end

feature {NON_VOID_NO_DISPATCH}
   visit_non_void_no_dispatch (visited: NON_VOID_NO_DISPATCH) is
      do
      end

feature {NATIVE_ARRAY_ITEM}
   visit_native_array_item (visited: NATIVE_ARRAY_ITEM) is
      do
         if enter_native_array_item(visited) then
            visited.index.accept(Current)
            exit_native_array_item(visited)
         end
      end

feature {}
   enter_native_array_item (visited: NATIVE_ARRAY_ITEM): BOOLEAN is
      do
         Result := True
      end

   exit_native_array_item (visited: NATIVE_ARRAY_ITEM) is
      do
      end

feature {NULL_POINTER}
   visit_null_pointer (visited: NULL_POINTER) is
      do
      end

feature {E_FUNCTION}
   visit_e_function (visited: E_FUNCTION) is
      do
         if enter_e_function(visited) then
            visit_effective_routine(visited)
            exit_e_function(visited)
         end
      end

feature {}
   enter_e_function (visited: E_FUNCTION): BOOLEAN is
      do
         Result := True
      end

   exit_e_function (visited: E_FUNCTION) is
      do
      end

feature {E_PROCEDURE}
   visit_e_procedure (visited: E_PROCEDURE) is
      do
         if enter_e_procedure(visited) then
            visit_effective_routine(visited)
            exit_e_procedure(visited)
         end
      end

feature {}
   enter_e_procedure (visited: E_PROCEDURE): BOOLEAN is
      do
         Result := True
      end

   exit_e_procedure (visited: E_PROCEDURE) is
      do
      end

feature {ONCE_FUNCTION}
   visit_once_function (visited: ONCE_FUNCTION) is
      do
         if enter_once_function(visited) then
            visit_effective_routine(visited)
            exit_once_function(visited)
         end
      end

feature {}
   enter_once_function (visited: ONCE_FUNCTION): BOOLEAN is
      do
         Result := True
      end

   exit_once_function (visited: ONCE_FUNCTION) is
      do
      end

feature {ONCE_PROCEDURE}
   visit_once_procedure (visited: ONCE_PROCEDURE) is
      do
         if enter_once_procedure(visited) then
            visit_effective_routine(visited)
            exit_once_procedure(visited)
         end
      end

feature {}
   enter_once_procedure (visited: ONCE_PROCEDURE): BOOLEAN is
      do
         Result := True
      end

   exit_once_procedure (visited: ONCE_PROCEDURE) is
      do
      end

feature {EXTERNAL_FUNCTION}
   visit_external_function (visited: EXTERNAL_FUNCTION) is
      do
         if enter_external_function(visited) then
            visit_anonymous_feature(visited)
            exit_external_function(visited)
         end
      end

feature {}
   enter_external_function (visited: EXTERNAL_FUNCTION): BOOLEAN is
      do
         Result := True
      end

   exit_external_function (visited: EXTERNAL_FUNCTION) is
      do
      end

feature {EXTERNAL_PROCEDURE}
   visit_external_procedure (visited: EXTERNAL_PROCEDURE) is
      do
         if enter_external_procedure(visited) then
            visit_anonymous_feature(visited)
            exit_external_procedure(visited)
         end
      end

feature {}
   enter_external_procedure (visited: EXTERNAL_PROCEDURE): BOOLEAN is
      do
         Result := True
      end

   exit_external_procedure (visited: EXTERNAL_PROCEDURE) is
      do
      end

feature {DEFERRED_FUNCTION}
   visit_deferred_function (visited: DEFERRED_FUNCTION) is
      do
         if enter_deferred_function(visited) then
            visit_anonymous_feature(visited)
            exit_deferred_function(visited)
         end
      end

feature {}
   enter_deferred_function (visited: DEFERRED_FUNCTION): BOOLEAN is
      do
         Result := True
      end

   exit_deferred_function (visited: DEFERRED_FUNCTION) is
      do
      end

feature {DEFERRED_PROCEDURE}
   visit_deferred_procedure (visited: DEFERRED_PROCEDURE) is
      do
         if enter_deferred_procedure(visited) then
            visit_anonymous_feature(visited)
            exit_deferred_procedure(visited)
         end
      end

feature {}
   enter_deferred_procedure (visited: DEFERRED_PROCEDURE): BOOLEAN is
      do
         Result := True
      end

   exit_deferred_procedure (visited: DEFERRED_PROCEDURE) is
      do
      end

feature {ASSERTION_LIST}
   visit_assertion_list (visited: ASSERTION_LIST) is
      local
         i: INTEGER
      do
         if not visited.is_empty then
            from
               i := visited.lower
            until
               i > visited.upper
            loop
               visited.item(i).accept(Current)
               i := i + 1
            end
         end
      end

feature {REQUIRE_ASSERTION}
   visit_require_assertion (visited: REQUIRE_ASSERTION) is
      local
         i: INTEGER
      do
         if enter_require_assertion(visited) then
            if visited.is_empty then
               from
                  i := visited.lower
               until
                  i > visited.upper
               loop
                  visited.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_require_assertion(visited)
         end
      end

feature {}
   enter_require_assertion (visited: REQUIRE_ASSERTION): BOOLEAN is
      do
         Result := True
      end

   exit_require_assertion (visited: REQUIRE_ASSERTION) is
      do
      end

feature {CLASS_INVARIANT}
   visit_class_invariant (visited: CLASS_INVARIANT) is
      local
         i: INTEGER
      do
         if enter_class_invariant(visited) then
            if visited.is_empty then
               from
                  i := visited.lower
               until
                  i > visited.upper
               loop
                  visited.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_class_invariant(visited)
         end
      end

feature {}
   enter_class_invariant (visited: CLASS_INVARIANT): BOOLEAN is
      do
         Result := True
      end

   exit_class_invariant (visited: CLASS_INVARIANT) is
      do
      end

feature {LOOP_INVARIANT}
   visit_loop_invariant (visited: LOOP_INVARIANT) is
      local
         i: INTEGER
      do
         if enter_loop_invariant(visited) then
            if visited.is_empty then
               from
                  i := visited.lower
               until
                  i > visited.upper
               loop
                  visited.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_loop_invariant(visited)
         end
      end

feature {}
   enter_loop_invariant (visited: LOOP_INVARIANT): BOOLEAN is
      do
         Result := True
      end

   exit_loop_invariant (visited: LOOP_INVARIANT) is
      do
      end

feature {ENSURE_ASSERTION}
   visit_ensure_assertion (visited: ENSURE_ASSERTION) is
      do
         if enter_ensure_assertion(visited) then
            exit_ensure_assertion(visited)
         end
      end

feature {}
   enter_ensure_assertion (visited: ENSURE_ASSERTION): BOOLEAN is
      do
         Result := True
      end

   exit_ensure_assertion (visited: ENSURE_ASSERTION) is
      do
      end

feature {ASSERTION}
   visit_assertion (visited: ASSERTION) is
      do
         if enter_assertion(visited) then
            if visited.expression /= Void then
               visited.expression.accept(Current)
            end
            exit_assertion(visited)
         end
      end

feature {}
   enter_assertion (visited: ASSERTION): BOOLEAN is
      do
         Result := True
      end

   exit_assertion (visited: ASSERTION) is
      do
      end

feature {FEATURE_NAME}
   visit_feature_name (visited: FEATURE_NAME) is
      do
      end

feature {FAKE_TARGET}
   visit_fake_target (visited: FAKE_TARGET) is
      do
      end

feature {CREATE_EXPRESSION}
   visit_create_expression (visited: CREATE_EXPRESSION) is
      do
         if enter_create_expression(visited) then
            if visited.explicit_type /= Void then
               visited.explicit_type.accept(Current)
            end
            if visited.call /= Void then
               visited.call.accept(Current)
            end
            exit_create_expression(visited)
         end
      end

feature {}
   enter_create_expression (visited: CREATE_EXPRESSION): BOOLEAN is
      do
         Result := True
      end

   exit_create_expression (visited: CREATE_EXPRESSION) is
      do
      end

feature {ABSTRACT_CURRENT}
   visit_abstract_current (visited: ABSTRACT_CURRENT) is
      do
      end

feature {CREATE_WRITABLE}
   visit_create_writable (visited: CREATE_WRITABLE) is
      do
         if enter_create_writable(visited) then
            visited.type_mark.accept(Current)
            exit_create_writable(visited)
         end
      end

feature {}
   enter_create_writable (visited: CREATE_WRITABLE): BOOLEAN is
      do
         Result := True
      end

   exit_create_writable (visited: CREATE_WRITABLE) is
      do
      end

feature {PRECURSOR_EXPRESSION}
   visit_precursor_expression (visited: PRECURSOR_EXPRESSION) is
      do
         if enter_precursor_expression(visited) then
            if visited.arguments /= Void then
               visited.arguments.accept(Current)
            end
            exit_precursor_expression(visited)
         end
      end

feature {}
   enter_precursor_expression (visited: PRECURSOR_EXPRESSION): BOOLEAN is
      do
         Result := True
      end

   exit_precursor_expression (visited: PRECURSOR_EXPRESSION) is
      do
      end

feature {MANIFEST_GENERIC}
   visit_manifest_generic (visited: MANIFEST_GENERIC) is
      local
         i: INTEGER
      do
         if enter_manifest_generic(visited) then
            visited.type_mark.accept(Current)
            if visited.optional_arguments /= Void then
               from
                  i := visited.optional_arguments.lower
               until
                  i > visited.optional_arguments.upper
               loop
                  visited.optional_arguments.item(i).accept(Current)
                  i := i + 1
               end
            end
            from
               i := visited.item_list.lower
            until
               i > visited.item_list.upper
            loop
               visited.item_list.item(i).accept(Current)
               i := i + 1
            end
            exit_manifest_generic(visited)
         end
      end

feature {}
   enter_manifest_generic (visited: MANIFEST_GENERIC): BOOLEAN is
      do
         Result := True
      end

   exit_manifest_generic (visited: MANIFEST_GENERIC) is
      do
      end

feature {OLD_MANIFEST_ARRAY}
   visit_old_manifest_array (visited: OLD_MANIFEST_ARRAY) is
      local
         i: INTEGER
      do
         if enter_old_manifest_array(visited) then
            if visited.list /= Void then
               from
                  i := visited.list.lower
               until
                  i > visited.list.upper
               loop
                  visited.list.item(i).accept(Current)
                  i := i + 1
               end
            end
            exit_old_manifest_array(visited)
         end
      end

feature {}
   enter_old_manifest_array (visited: OLD_MANIFEST_ARRAY): BOOLEAN is
      do
         Result := True
      end

   exit_old_manifest_array (visited: OLD_MANIFEST_ARRAY) is
      do
      end

feature {E_VOID}
   visit_e_void (visited: E_VOID) is
      do
      end

feature {FAKE_ARGUMENT}
   visit_fake_argument (visited: FAKE_ARGUMENT) is
      do
         if enter_fake_argument(visited) then
            visited.result_type.accept(Current)
            exit_fake_argument(visited)
         end
      end

feature {}
   enter_fake_argument (visited: FAKE_ARGUMENT): BOOLEAN is
      do
         Result := True
      end

   exit_fake_argument (visited: FAKE_ARGUMENT) is
      do
      end

feature {CHARACTER_CONSTANT}
   visit_character_constant (visited: CHARACTER_CONSTANT) is
      do
      end

feature {REAL_CONSTANT}
   visit_real_constant (visited: REAL_CONSTANT) is
      do
      end

feature {INTEGER_CONSTANT}
   visit_integer_constant (visited: INTEGER_CONSTANT) is
      do
      end

feature {NATURAL_CONSTANT}
   visit_natural_constant (visited: NATURAL_CONSTANT) is
      do
      end

feature {FEATURE_NAME_LIST}
   visit_feature_name_list (visited: FEATURE_NAME_LIST) is
      local
         i: INTEGER
      do
         if enter_feature_name_list(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.item(i).accept(Current)
               i := i + 1
            end
            exit_feature_name_list(visited)
         end
      end

feature {}
   enter_feature_name_list (visited: FEATURE_NAME_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_feature_name_list (visited: FEATURE_NAME_LIST) is
      do
      end

feature {OPEN_OPERAND}
   visit_open_operand (visited: OPEN_OPERAND) is
      do
      end

feature {ADDRESS_OF}
   visit_address_of (visited: ADDRESS_OF) is
      do
         if enter_address_of(visited) then
            if visited.feature_name /= Void then
               visited.feature_name.accept(Current)
            else
               visited.local_name.accept(Current)
            end
            exit_address_of(visited)
         end
      end

feature {}
   enter_address_of (visited: ADDRESS_OF): BOOLEAN is
      do
         Result := True
      end

   exit_address_of (visited: ADDRESS_OF) is
      do
      end

feature {EFFECTIVE_ARG_LIST}
   visit_effective_arg_list (visited: EFFECTIVE_ARG_LIST) is
      local
         i: INTEGER
      do
         if enter_effective_arg_list(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.expression(i).accept(Current)
               i := i + 1
            end
            exit_effective_arg_list(visited)
         end
      end

feature {}
   enter_effective_arg_list (visited: EFFECTIVE_ARG_LIST): BOOLEAN is
      do
         Result := True
      end

   exit_effective_arg_list (visited: EFFECTIVE_ARG_LIST) is
      do
      end

feature {}
   visit_call_support (visited: FEATURE_CALL) is
      do
         visited.target.accept(Current)
         if visited.arguments /= Void then
            visited.arguments.accept(Current)
         end
      end

feature {FUNCTION_CALL_0}
   visit_function_call_0 (visited: FUNCTION_CALL_0) is
      do
         if enter_call_0_c(visited) then
            visit_call_support(visited)
            exit_call_0_c(visited)
         end
      end

feature {}
   enter_call_0_c (visited: FUNCTION_CALL_0): BOOLEAN is
      do
         Result := True
      end

   exit_call_0_c (visited: FUNCTION_CALL_0) is
      do
      end

feature {STATIC_CALL_0_C}
   visit_static_call_0_c (visited: STATIC_CALL_0_C) is
      do
         if enter_static_call_0_c(visited) then
            visit_call_support(visited)
            exit_static_call_0_c(visited)
         end
      end

feature {}
   enter_static_call_0_c (visited: STATIC_CALL_0_C): BOOLEAN is
      do
         Result := True
      end

   exit_static_call_0_c (visited: STATIC_CALL_0_C) is
      do
      end

feature {CALL_PREFIX_NOT}
   visit_call_prefix_not (visited: CALL_PREFIX_NOT) is
      do
         if enter_call_prefix_not(visited) then
            visit_call_support(visited)
            exit_call_prefix_not(visited)
         end
      end

feature {}
   enter_call_prefix_not (visited: CALL_PREFIX_NOT): BOOLEAN is
      do
         Result := True
      end

   exit_call_prefix_not (visited: CALL_PREFIX_NOT) is
      do
      end

feature {CALL_PREFIX_MINUS}
   visit_call_prefix_minus (visited: CALL_PREFIX_MINUS) is
      do
         if enter_call_prefix_minus(visited) then
            visit_call_support(visited)
            exit_call_prefix_minus(visited)
         end
      end

feature {}
   enter_call_prefix_minus (visited: CALL_PREFIX_MINUS): BOOLEAN is
      do
         Result := True
      end

   exit_call_prefix_minus (visited: CALL_PREFIX_MINUS) is
      do
      end

feature {CALL_PREFIX_FREEOP}
   visit_call_prefix_freeop (visited: CALL_PREFIX_FREEOP) is
      do
         if enter_call_prefix_freeop(visited) then
            visit_call_support(visited)
            exit_call_prefix_freeop(visited)
         end
      end

feature {}
   enter_call_prefix_freeop (visited: CALL_PREFIX_FREEOP): BOOLEAN is
      do
         Result := True
      end

   exit_call_prefix_freeop (visited: CALL_PREFIX_FREEOP) is
      do
      end

feature {CALL_PREFIX_PLUS}
   visit_call_prefix_plus (visited: CALL_PREFIX_PLUS) is
      do
         if enter_call_prefix_plus(visited) then
            visit_call_support(visited)
            exit_call_prefix_plus(visited)
         end
      end

feature {}
   enter_call_prefix_plus (visited: CALL_PREFIX_PLUS): BOOLEAN is
      do
         Result := True
      end

   exit_call_prefix_plus (visited: CALL_PREFIX_PLUS) is
      do
      end

feature {FUNCTION_CALL_1}
   visit_function_call_1 (visited: FUNCTION_CALL_1) is
      do
         if enter_call_1_c(visited) then
            visit_call_support(visited)
            exit_call_1_c(visited)
         end
      end

feature {}
   enter_call_1_c (visited: FUNCTION_CALL_1): BOOLEAN is
      do
         Result := True
      end

   exit_call_1_c (visited: FUNCTION_CALL_1) is
      do
      end

feature {CALL_INFIX_AND_THEN}
   visit_call_infix_and_then (visited: CALL_INFIX_AND_THEN) is
      do
         if enter_call_infix_and_then(visited) then
            visit_call_support(visited)
            exit_call_infix_and_then(visited)
         end
      end

feature {}
   enter_call_infix_and_then (visited: CALL_INFIX_AND_THEN): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_and_then (visited: CALL_INFIX_AND_THEN) is
      do
      end

feature {CALL_INFIX_MINUS}
   visit_call_infix_minus (visited: CALL_INFIX_MINUS) is
      do
         if enter_call_infix_minus(visited) then
            visit_call_support(visited)
            exit_call_infix_minus(visited)
         end
      end

feature {}
   enter_call_infix_minus (visited: CALL_INFIX_MINUS): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_minus (visited: CALL_INFIX_MINUS) is
      do
      end

feature {CALL_INFIX_TIMES}
   visit_call_infix_times (visited: CALL_INFIX_TIMES) is
      do
         if enter_call_infix_times(visited) then
            visit_call_support(visited)
            exit_call_infix_times(visited)
         end
      end

feature {}
   enter_call_infix_times (visited: CALL_INFIX_TIMES): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_times (visited: CALL_INFIX_TIMES) is
      do
      end

feature {CALL_INFIX_INT_REM}
   visit_call_infix_int_rem (visited: CALL_INFIX_INT_REM) is
      do
         if enter_call_infix_int_rem(visited) then
            visit_call_support(visited)
            exit_call_infix_int_rem(visited)
         end
      end

feature {}
   enter_call_infix_int_rem (visited: CALL_INFIX_INT_REM): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_int_rem (visited: CALL_INFIX_INT_REM) is
      do
      end

feature {CALL_INFIX_OR}
   visit_call_infix_or (visited: CALL_INFIX_OR) is
      do
         if enter_call_infix_or(visited) then
            visit_call_support(visited)
            exit_call_infix_or(visited)
         end
      end

feature {}
   enter_call_infix_or (visited: CALL_INFIX_OR): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_or (visited: CALL_INFIX_OR) is
      do
      end

feature {CALL_INFIX_GT}
   visit_call_infix_gt (visited: CALL_INFIX_GT) is
      do
         if enter_call_infix_gt(visited) then
            visit_call_support(visited)
            exit_call_infix_gt(visited)
         end
      end

feature {}
   enter_call_infix_gt (visited: CALL_INFIX_GT): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_gt (visited: CALL_INFIX_GT) is
      do
      end

feature {CALL_INFIX_LT}
   visit_call_infix_lt (visited: CALL_INFIX_LT) is
      do
         if enter_call_infix_lt(visited) then
            visit_call_support(visited)
            exit_call_infix_lt(visited)
         end
      end

feature {}
   enter_call_infix_lt (visited: CALL_INFIX_LT): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_lt (visited: CALL_INFIX_LT) is
      do
      end

feature {CALL_INFIX_PLUS}
   visit_call_infix_plus (visited: CALL_INFIX_PLUS) is
      do
         if enter_call_infix_plus(visited) then
            visit_call_support(visited)
            exit_call_infix_plus(visited)
         end
      end

feature {}
   enter_call_infix_plus (visited: CALL_INFIX_PLUS): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_plus (visited: CALL_INFIX_PLUS) is
      do
      end

feature {CALL_INFIX_INT_DIV}
   visit_call_infix_int_div (visited: CALL_INFIX_INT_DIV) is
      do
         if enter_call_infix_int_div(visited) then
            visit_call_support(visited)
            exit_call_infix_int_div(visited)
         end
      end

feature {}
   enter_call_infix_int_div (visited: CALL_INFIX_INT_DIV): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_int_div (visited: CALL_INFIX_INT_DIV) is
      do
      end

feature {CALL_INFIX_XOR}
   visit_call_infix_xor (visited: CALL_INFIX_XOR) is
      do
         if enter_call_infix_xor(visited) then
            visit_call_support(visited)
            exit_call_infix_xor(visited)
         end
      end

feature {}
   enter_call_infix_xor (visited: CALL_INFIX_XOR): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_xor (visited: CALL_INFIX_XOR) is
      do
      end

feature {CALL_INFIX_POWER}
   visit_call_infix_power (visited: CALL_INFIX_POWER) is
      do
         if enter_call_infix_power(visited) then
            visit_call_support(visited)
            exit_call_infix_power(visited)
         end
      end

feature {}
   enter_call_infix_power (visited: CALL_INFIX_POWER): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_power (visited: CALL_INFIX_POWER) is
      do
      end

feature {CALL_INFIX_DIV}
   visit_call_infix_div (visited: CALL_INFIX_DIV) is
      do
         if enter_call_infix_div(visited) then
            visit_call_support(visited)
            exit_call_infix_div(visited)
         end
      end

feature {}
   enter_call_infix_div (visited: CALL_INFIX_DIV): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_div (visited: CALL_INFIX_DIV) is
      do
      end

feature {CALL_INFIX_OR_ELSE}
   visit_call_infix_or_else (visited: CALL_INFIX_OR_ELSE) is
      do
         if enter_call_infix_or_else(visited) then
            visit_call_support(visited)
            exit_call_infix_or_else(visited)
         end
      end

feature {}
   enter_call_infix_or_else (visited: CALL_INFIX_OR_ELSE): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_or_else (visited: CALL_INFIX_OR_ELSE) is
      do
      end

feature {CALL_INFIX_IMPLIES}
   visit_call_infix_implies (visited: CALL_INFIX_IMPLIES) is
      do
         if enter_call_infix_implies(visited) then
            visit_call_support(visited)
            exit_call_infix_implies(visited)
         end
      end

feature {}
   enter_call_infix_implies (visited: CALL_INFIX_IMPLIES): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_implies (visited: CALL_INFIX_IMPLIES) is
      do
      end

feature {CALL_INFIX_LE}
   visit_call_infix_le (visited: CALL_INFIX_LE) is
      do
         if enter_call_infix_le(visited) then
            visit_call_support(visited)
            exit_call_infix_le(visited)
         end
      end

feature {}
   enter_call_infix_le (visited: CALL_INFIX_LE): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_le (visited: CALL_INFIX_LE) is
      do
      end

feature {CALL_INFIX_FREEOP}
   visit_call_infix_freeop (visited: CALL_INFIX_FREEOP) is
      do
         if enter_call_infix_freeop(visited) then
            visit_call_support(visited)
            exit_call_infix_freeop(visited)
         end
      end

feature {}
   enter_call_infix_freeop (visited: CALL_INFIX_FREEOP): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_freeop (visited: CALL_INFIX_FREEOP) is
      do
      end

feature {CALL_INFIX_AND}
   visit_call_infix_and (visited: CALL_INFIX_AND) is
      do
         if enter_call_infix_and(visited) then
            visit_call_support(visited)
            exit_call_infix_and(visited)
         end
      end

feature {}
   enter_call_infix_and (visited: CALL_INFIX_AND): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_and (visited: CALL_INFIX_AND) is
      do
      end

feature {CALL_INFIX_GE}
   visit_call_infix_ge (visited: CALL_INFIX_GE) is
      do
         if enter_call_infix_ge(visited) then
            visit_call_support(visited)
            exit_call_infix_ge(visited)
         end
      end

feature {}
   enter_call_infix_ge (visited: CALL_INFIX_GE): BOOLEAN is
      do
         Result := True
      end

   exit_call_infix_ge (visited: CALL_INFIX_GE) is
      do
      end

feature {BUILT_IN_EQ_NEQ}
   visit_built_in_eq_neq (visited: BUILT_IN_EQ_NEQ) is
      do
         if enter_built_in_eq_neq(visited) then
            visited.left_side.accept(Current)
            visited.right_side.accept(Current)
            exit_built_in_eq_neq(visited)
         end
      end

feature {}
   enter_built_in_eq_neq (visited: BUILT_IN_EQ_NEQ): BOOLEAN is
      do
         Result := True
      end

   exit_built_in_eq_neq (visited: BUILT_IN_EQ_NEQ) is
      do
      end

feature {FUNCTION_CALL_N}
   visit_function_call_n (visited: FUNCTION_CALL_N) is
      do
         if enter_call_n(visited) then
            visit_call_support(visited)
            exit_call_n(visited)
         end
      end

feature {}
   enter_call_n (visited: FUNCTION_CALL_N): BOOLEAN is
      do
         Result := True
      end

   exit_call_n (visited: FUNCTION_CALL_N) is
      do
      end

feature {MANIFEST_STRING}
   visit_manifest_string (visited: MANIFEST_STRING) is
      do
      end

feature {AGENT_ARGS}
   visit_agent_args (visited: AGENT_ARGS) is
      do
         if enter_agent_args(visited) then
            visited.agent_type.accept(Current)
            exit_agent_args(visited)
         end
      end

feature {}
   enter_agent_args (visited: AGENT_ARGS): BOOLEAN is
      do
         Result := True
      end

   exit_agent_args (visited: AGENT_ARGS) is
      do
      end

feature {AGENT_CREATION}
   visit_agent_creation (visited: AGENT_CREATION) is
      do
         if enter_agent_creation(visited) then
            visited.code.accept(Current)
            exit_agent_creation(visited)
         end
      end

feature {}
   enter_agent_creation (visited: AGENT_CREATION): BOOLEAN is
      do
         Result := True
      end

   exit_agent_creation (visited: AGENT_CREATION) is
      do
      end

feature {E_OLD}
   visit_e_old (visited: E_OLD) is
      do
         if enter_e_old(visited) then
            visited.expression.accept(Current)
            exit_e_old(visited)
         end
      end

feature {}
   enter_e_old (visited: E_OLD): BOOLEAN is
      do
         Result := True
      end

   exit_e_old (visited: E_OLD) is
      do
      end

feature {FAKE_TUPLE}
   visit_fake_tuple (visited: FAKE_TUPLE) is
      local
         i: INTEGER
      do
         if enter_fake_tuple(visited) then
            from
               i := 1
            until
               i > visited.count
            loop
               visited.expression(i).accept(Current)
               i := i + 1
            end
            exit_fake_tuple(visited)
         end
      end

feature {}
   enter_fake_tuple (visited: FAKE_TUPLE): BOOLEAN is
      do
         Result := True
      end

   exit_fake_tuple (visited: FAKE_TUPLE) is
      do
      end

feature {MANIFEST_TUPLE}
   visit_manifest_tuple (visited: MANIFEST_TUPLE) is
      do
         if enter_manifest_tuple(visited) then
            if visited.effective_arg_list /= Void then
               visited.effective_arg_list.accept(Current)
            end
            exit_manifest_tuple(visited)
         end
      end

feature {}
   enter_manifest_tuple (visited: MANIFEST_TUPLE): BOOLEAN is
      do
         Result := True
      end

   exit_manifest_tuple (visited: MANIFEST_TUPLE) is
      do
      end

feature {IMPLICIT_CAST}
   visit_implicit_cast (visited: IMPLICIT_CAST) is
      do
      end

feature {GENERATOR_GENERATING_TYPE}
   visit_generator_generating_type (visited: GENERATOR_GENERATING_TYPE) is
      do
      end

feature {AGENT_EXPRESSION}
   visit_agent_expression (visited: AGENT_EXPRESSION) is
      do
         if enter_agent_expression(visited) then
            visited.written_link.accept(Current)
            visited.agent_type.accept(Current)
            visited.target.accept(Current)
            if visited.agent_args /= Void then
               visited.agent_args.accept(Current)
            end
            exit_agent_expression(visited)
         end
      end

feature {}
   enter_agent_expression (visited: AGENT_EXPRESSION): BOOLEAN is
      do
         Result := True
      end

   exit_agent_expression (visited: AGENT_EXPRESSION) is
      do
      end

feature {RESULT}
   visit_result (visited: RESULT) is
      do
      end

feature {EXPRESSION_WITH_COMMENT}
   visit_expression_with_comment (visited: EXPRESSION_WITH_COMMENT) is
      do
         if enter_expression_with_comment(visited) then
            visited.expression.accept(Current)
            exit_expression_with_comment(visited)
         end
      end

feature {}
   enter_expression_with_comment (visited: EXPRESSION_WITH_COMMENT): BOOLEAN is
      do
         Result := True
      end

   exit_expression_with_comment (visited: EXPRESSION_WITH_COMMENT) is
      do
      end

feature {COMMENT}
   visit_comment (visited: COMMENT) is
      do
      end

feature {IMPLICIT_CURRENT}
   visit_implicit_current (visited: IMPLICIT_CURRENT) is
      do
      end

feature {WRITTEN_CURRENT}
   visit_written_current (visited: WRITTEN_CURRENT) is
      do
      end

feature {WRITABLE_ATTRIBUTE_NAME}
   visit_writable_attribute_name (visited: WRITABLE_ATTRIBUTE_NAME) is
      do
         if enter_writable_attribute_name(visited) then
            visited.feature_name.accept(Current)
            exit_writable_attribute_name(visited)
         end
      end

feature {}
   enter_writable_attribute_name (visited: WRITABLE_ATTRIBUTE_NAME): BOOLEAN is
      do
         Result := True
      end

   exit_writable_attribute_name (visited: WRITABLE_ATTRIBUTE_NAME) is
      do
      end

feature {E_TRUE}
   visit_e_true (visited: E_TRUE) is
      do
      end

feature {E_FALSE}
   visit_e_false (visited: E_FALSE) is
      do
      end

feature {RETRY_INSTRUCTION}
   visit_retry_instruction (visited: RETRY_INSTRUCTION) is
      do
      end

feature {IFTHENELSE}
   visit_ifthenelse (visited: IFTHENELSE) is
      local
         i: INTEGER
      do
         if enter_ifthenelse(visited) then
            if visited.then_compound /= Void then
               visited.then_compound.accept(Current)
            end
            if visited.elseif_list /= Void then
               from
                  i := visited.elseif_list.lower
               until
                  i > visited.elseif_list.upper
               loop
                  visited.elseif_list.item(i).accept(Current)
                  i := i + 1
               end
            end
            if visited.else_compound /= Void then
               visited.else_compound.accept(Current)
            end
            exit_ifthenelse(visited)
         end
      end

feature {}
   enter_ifthenelse (visited: IFTHENELSE): BOOLEAN is
      do
         Result := True
      end

   exit_ifthenelse (visited: IFTHENELSE) is
      do
      end

feature {IFTHEN}
   visit_ifthen (visited: IFTHEN) is
      do
         if enter_ifthen(visited) then
            visited.expression.accept(Current)
            if visited.then_compound /= Void then
               visited.then_compound.accept(Current)
            end
            exit_ifthen(visited)
         end
      end

feature {}
   enter_ifthen (visited: IFTHEN): BOOLEAN is
      do
         Result := True
      end

   exit_ifthen (visited: IFTHEN) is
      do
      end

feature {ASSIGNMENT}
   visit_assignment (visited: ASSIGNMENT) is
      do
         if enter_assignment(visited) then
            visited.left_side.accept(Current)
            visited.right_side.accept(Current)
            exit_assignment(visited)
         end
      end

feature {}
   enter_assignment (visited: ASSIGNMENT): BOOLEAN is
      do
         Result := True
      end

   exit_assignment (visited: ASSIGNMENT) is
      do
      end

feature {ASSIGNMENT_CALL_ASSIGNER}
   visit_assignment_call_assigner (visited: ASSIGNMENT_CALL_ASSIGNER) is
      do
         if enter_assignment_call_assigner(visited) then
            visited.left_side.accept(Current)
            visited.right_side.accept(Current)
            exit_assignment_call_assigner(visited)
         end
      end

feature {}
   enter_assignment_call_assigner (visited: ASSIGNMENT_CALL_ASSIGNER): BOOLEAN is
      do
         Result := True
      end

   exit_assignment_call_assigner (visited: ASSIGNMENT_CALL_ASSIGNER) is
      do
      end

feature {ASSIGNMENT_ATTEMPT}
   visit_assignment_attempt (visited: ASSIGNMENT_ATTEMPT) is
      do
         if enter_assignment_attempt(visited) then
            visited.left_side.accept(Current)
            visited.right_side.accept(Current)
            exit_assignment_attempt(visited)
         end
      end

feature {}
   enter_assignment_attempt (visited: ASSIGNMENT_ATTEMPT): BOOLEAN is
      do
         Result := True
      end

   exit_assignment_attempt (visited: ASSIGNMENT_ATTEMPT) is
      do
      end

feature {ASSIGNMENT_TEST}
   visit_assignment_test (visited: ASSIGNMENT_TEST) is
      do
         if enter_assignment_test(visited) then
            if visited.left_writable /= Void then
               visited.left_writable.accept(Current)
            else
               check
                  visited.left_type_mark /= Void
               end
               visited.left_type_mark.accept(Current)
            end
            visited.right_side.accept(Current)
            exit_assignment_test(visited)
         end
      end

feature {}
   enter_assignment_test (visited: ASSIGNMENT_TEST): BOOLEAN is
      do
         Result := True
      end

   exit_assignment_test (visited: ASSIGNMENT_TEST) is
      do
      end

feature {DEBUG_COMPOUND}
   visit_debug_compound (visited: DEBUG_COMPOUND) is
      do
         if enter_debug_compound(visited) then
            if visited.compound /= Void then
               visited.compound.accept(Current)
            end
            exit_debug_compound(visited)
         end
      end

feature {}
   enter_debug_compound (visited: DEBUG_COMPOUND): BOOLEAN is
      do
         Result := True
      end

   exit_debug_compound (visited: DEBUG_COMPOUND) is
      do
      end

feature {CHECK_COMPOUND}
   visit_check_compound (visited: CHECK_COMPOUND) is
      do
         if enter_check_compound(visited) then
            visited.assertion_list.accept(Current)
            exit_check_compound(visited)
         end
      end

feature {}
   enter_check_compound (visited: CHECK_COMPOUND): BOOLEAN is
      do
         Result := True
      end

   exit_check_compound (visited: CHECK_COMPOUND) is
      do
      end

feature {PROCEDURE_CALL_0}
   visit_procedure_call_0 (visited: PROCEDURE_CALL_0) is
      do
         if enter_proc_call_0(visited) then
            visit_call_support(visited)
            exit_proc_call_0(visited)
         end
      end

feature {}
   enter_proc_call_0 (visited: PROCEDURE_CALL_0): BOOLEAN is
      do
         Result := True
      end

   exit_proc_call_0 (visited: PROCEDURE_CALL_0) is
      do
      end

feature {PROCEDURE_CALL_1}
   visit_procedure_call_1 (visited: PROCEDURE_CALL_1) is
      do
         if enter_proc_call_1(visited) then
            visit_call_support(visited)
            exit_proc_call_1(visited)
         end
      end

feature {}
   enter_proc_call_1 (visited: PROCEDURE_CALL_1): BOOLEAN is
      do
         Result := True
      end

   exit_proc_call_1 (visited: PROCEDURE_CALL_1) is
      do
      end

feature {PROCEDURE_CALL_N}
   visit_procedure_call_n (visited: PROCEDURE_CALL_N) is
      do
         if enter_proc_call_n(visited) then
            visit_call_support(visited)
            exit_proc_call_n(visited)
         end
      end

feature {}
   enter_proc_call_n (visited: PROCEDURE_CALL_N): BOOLEAN is
      do
         Result := True
      end

   exit_proc_call_n (visited: PROCEDURE_CALL_N) is
      do
      end

feature {AGENT_INSTRUCTION}
   visit_agent_instruction (visited: AGENT_INSTRUCTION) is
      do
         if enter_agent_instruction(visited) then
            visited.written_link.accept(Current)
            visited.target.accept(Current)
            visited.agent_args.accept(Current)
            exit_agent_instruction(visited)
         end
      end

feature {}
   enter_agent_instruction (visited: AGENT_INSTRUCTION): BOOLEAN is
      do
         Result := True
      end

   exit_agent_instruction (visited: AGENT_INSTRUCTION) is
      do
      end

feature {CREATE_INSTRUCTION}
   visit_create_instruction (visited: CREATE_INSTRUCTION) is
      do
         if enter_create_instruction(visited) then
            if visited.explicit_type /= Void then
               visited.explicit_type.accept(Current)
            end
            if visited.call /= Void then
               visited.call.accept(Current)
            end
            exit_create_instruction(visited)
         end
      end

feature {}
   enter_create_instruction (visited: CREATE_INSTRUCTION): BOOLEAN is
      do
         Result := True
      end

   exit_create_instruction (visited: CREATE_INSTRUCTION) is
      do
      end

feature {RAW_CREATE_INSTRUCTION}
   visit_raw_create_instruction (visited: RAW_CREATE_INSTRUCTION) is
      do
         if enter_raw_create_instruction(visited) then
            if visited.explicit_type /= Void then
               visited.explicit_type.accept(Current)
            end
            if visited.call /= Void then
               visited.call.accept(Current)
            end
            exit_raw_create_instruction(visited)
         end
      end

feature {}
   enter_raw_create_instruction (visited: RAW_CREATE_INSTRUCTION): BOOLEAN is
      do
         Result := True
      end

   exit_raw_create_instruction (visited: RAW_CREATE_INSTRUCTION) is
      do
      end

feature {PRECURSOR_INSTRUCTION}
   visit_precursor_instruction (visited: PRECURSOR_INSTRUCTION) is
      do
         if enter_precursor_instruction(visited) then
            if visited.arguments /= Void then
               visited.arguments.accept(Current)
            end
            exit_precursor_instruction(visited)
         end
      end

feature {}
   enter_precursor_instruction (visited: PRECURSOR_INSTRUCTION): BOOLEAN is
      do
         Result := True
      end

   exit_precursor_instruction (visited: PRECURSOR_INSTRUCTION) is
      do
      end

feature {LOOP_INSTRUCTION}
   visit_loop_instruction (visited: LOOP_INSTRUCTION) is
      do
         if enter_e_loop(visited) then
            if visited.initialize /= Void then
               visited.initialize.accept(Current)
            end
            if visited.loop_invariant /= Void then
               visited.loop_invariant.accept(Current)
            end
            if visited.loop_variant /= Void then
               visited.loop_variant.accept(Current)
            end
            visited.until_expression.accept(Current)
            if visited.loop_body /= Void then
               visited.loop_body.accept(Current)
            end
            exit_e_loop(visited)
         end
      end

feature {}
   enter_e_loop (visited: LOOP_INSTRUCTION): BOOLEAN is
      do
         Result := True
      end

   exit_e_loop (visited: LOOP_INSTRUCTION) is
      do
      end

feature {LOOP_VARIANT}
   visit_loop_variant (visited: LOOP_VARIANT) is
      do
         if enter_loop_variant(visited) then
            visited.expression.accept(Current)
            exit_loop_variant(visited)
         end
      end

feature {}
   enter_loop_variant (visited: LOOP_VARIANT): BOOLEAN is
      do
         Result := True
      end

   exit_loop_variant (visited: LOOP_VARIANT) is
      do
      end

feature {}
   visit_inspect_statement (visited: INSPECT_STATEMENT) is
      local
         clauses: FAST_ARRAY[WHEN_CLAUSE]; i: INTEGER
      do
         if enter_inspect_statement(visited) then
            visited.expression.accept(Current)
            clauses := visited.when_list
            from
               i := clauses.lower
            until
               i > clauses.upper
            loop
               clauses.item(i).accept(Current)
               i := i + 1
            end
            if visited.else_compound /= Void then
               visited.else_compound.accept(Current)
            end
            exit_inspect_statement(visited)
         end
      end

feature {OTHER_INSPECT_STATEMENT}
   visit_other_inspect_statement (visited: OTHER_INSPECT_STATEMENT) is
      do
         visit_inspect_statement(visited)
      end

feature {MANIFEST_STRING_INSPECT_STATEMENT}
   visit_manifest_string_inspect_statement (visited: MANIFEST_STRING_INSPECT_STATEMENT) is
      do
         visit_inspect_statement(visited)
      end

feature {C_INLINE}
   visit_c_inline (visited: C_INLINE) is
      do
      end

feature {}
   enter_inspect_statement (visited: INSPECT_STATEMENT): BOOLEAN is
      do
         Result := True
      end

   exit_inspect_statement (visited: INSPECT_STATEMENT) is
      do
      end

feature {WHEN_CLAUSE}
   visit_when_clause (visited: WHEN_CLAUSE) is
      local
         i: INTEGER; items: FAST_ARRAY[WHEN_ITEM]
      do
         if enter_when_clause(visited) then
            items := visited.list
            from
               i := visited.list.lower
            until
               i > visited.list.upper
            loop
               visited.list.item(i).accept(Current)
               i := i + 1
            end
            exit_when_clause(visited)
         end
      end

feature {}
   enter_when_clause (visited: WHEN_CLAUSE): BOOLEAN is
      do
         Result := True
      end

   exit_when_clause (visited: WHEN_CLAUSE) is
      do
      end

feature {WHEN_ITEM_1}
   visit_when_item_1 (visited: WHEN_ITEM_1) is
      do
         if enter_when_item_1(visited) then
            visited.expression.accept(Current)
            exit_when_item_1(visited)
         end
      end

feature {}
   enter_when_item_1 (visited: WHEN_ITEM_1): BOOLEAN is
      do
         Result := True
      end

   exit_when_item_1 (visited: WHEN_ITEM_1) is
      do
      end

feature {WHEN_ITEM_2}
   visit_when_item_2 (visited: WHEN_ITEM_2) is
      do
         if enter_when_item_2(visited) then
            visited.lower.accept(Current)
            visited.upper.accept(Current)
            exit_when_item_2(visited)
         end
      end

feature {}
   enter_when_item_2 (visited: WHEN_ITEM_2): BOOLEAN is
      do
         Result := True
      end

   exit_when_item_2 (visited: WHEN_ITEM_2) is
      do
      end

feature {COMPOUND}
   visit_compound (visited: COMPOUND) is
      local
         l: FAST_ARRAY[INSTRUCTION]; i: INTEGER
      do
         if enter_compound(visited) then
            l := visited.list
            from
               i := l.lower
            until
               i > l.upper
            loop
               l.item(i).accept(Current)
               i := i + 1
            end
            exit_compound(visited)
         end
      end

feature {COMPOUND_EXPRESSION}
   visit_compound_expression (visited: COMPOUND_EXPRESSION) is
      local
         i: INTEGER
      do
         from
            i := visited.lower
         until
            i > visited.upper
         loop
            visited.item(i).accept(Current)
            i := i + 1
         end
      end

feature {}
   enter_compound (visited: COMPOUND): BOOLEAN is
      do
         Result := True
      end

   exit_compound (visited: COMPOUND) is
      do
      end

feature {NO_INVARIANT_WRAPPER}
   visit_no_invariant_wrapper (visited: NO_INVARIANT_WRAPPER) is
      do
         if enter_no_invariant_wrapper(visited) then
            visited.compound.accept(Current)
            exit_no_invariant_wrapper(visited)
         end
      end

feature {}
   enter_no_invariant_wrapper (visited: NO_INVARIANT_WRAPPER): BOOLEAN is
      do
         Result := True
      end

   exit_no_invariant_wrapper (visited: NO_INVARIANT_WRAPPER) is
      do
      end

feature {DECLARATION_1}
   visit_declaration_1 (visited: DECLARATION_1) is
      do
         if enter_declaration_1(visited) then
            visited.name.accept(Current)
            exit_declaration_1(visited)
         end
      end

feature {}
   enter_declaration_1 (visited: DECLARATION_1): BOOLEAN is
      do
         Result := True
      end

   exit_declaration_1 (visited: DECLARATION_1) is
      do
      end

feature {DECLARATION_GROUP}
   visit_declaration_group (visited: DECLARATION_GROUP) is
      local
         i: INTEGER
         name_list: COLLECTION[LOCAL_ARGUMENT_DEF]
      do
         if enter_declaration_group(visited) then
            name_list := visited.name_list
            from
               i := name_list.lower
            until
               i > name_list.upper
            loop
               name_list.item(i).accept(Current)
               i := i + 1
            end
            exit_declaration_group(visited)
         end
      end

feature {}
   enter_declaration_group (visited: DECLARATION_GROUP): BOOLEAN is
      do
         Result := True
      end

   exit_declaration_group (visited: DECLARATION_GROUP) is
      do
      end

end -- class IN_OUT_VISITOR
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
-- Copyright(C) 2011-2014: Cyril ADRIAN, Paolo REDAELLI, Raphael MACK
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
