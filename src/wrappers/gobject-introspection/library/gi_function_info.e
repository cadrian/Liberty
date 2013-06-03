class GI_FUNCTION_INFO 
	-- A GObject Introspection metadata structure representing a function, a method or a constructor. 
	
	-- `flags' query To find out what kind of entity a GIFunctionInfo represents, call g_function_info_get_flags().  
   See also GICallableInfo for information on how to retreive arguments and other metadata.

inherit GI_CALLBACK_INFO
insert GIFUNCTIONINFO_EXTERNALS

--   enum GInvokeError
-- 
--  typedef enum {
--    G_INVOKE_ERROR_FAILED,
--    G_INVOKE_ERROR_SYMBOL_NOT_FOUND,
--    G_INVOKE_ERROR_ARGUMENT_MISMATCH
--  } GInvokeError;
-- 
--    An error occuring while invoking a function via g_function_info_invoke().
-- 
--    G_INVOKE_ERROR_FAILED            invokation failed, unknown error.
--    G_INVOKE_ERROR_SYMBOL_NOT_FOUND  symbol couldn't be found in any of the libraries associated with the typelib of the
--                                     function.
--    G_INVOKE_ERROR_ARGUMENT_MISMATCH the arguments provided didn't match the expected arguments for the functions type
--                                     signature.
-- 
--    -----------------------------------------------------------------------------------------------------------------------
-- 
-- 
feature 
	symbol: FIXED_STRING is
		-- The symbol of the function; the symbol is the name of the exported function, suitable to be used as an argument to g_module_symbol().
	do
		create Result.from_external_pointer(g_function_info_get_symbol(handle))
	ensure not_void: Result/=Void
	end
   
  	flags: GIFUNCTION_INFO_FLAGS_ENUM is
		-- The flags of Current function. It may be 
		--    GI_FUNCTION_IS_METHOD      is a method.
		--    GI_FUNCTION_IS_CONSTRUCTOR is a constructor.
		--    GI_FUNCTION_IS_GETTER      is a getter of a GIPropertyInfo.
		--    GI_FUNCTION_IS_SETTER      is a setter of a GIPropertyInfo.
		--    GI_FUNCTION_WRAPS_VFUNC    represents a virtual function.
		--    GI_FUNCTION_THROWS         the function may throw an error.
	do
		Result.set(g_function_info_get_flags(handle))
	end

	property: GI_PROPERTY_INFO is
		-- Obtain the property associated with this GIFunctionInfo. Only
		-- GIFunctionInfo with the flag GI_FUNCTION_IS_GETTER or
		-- GI_FUNCTION_IS_SETTER have a property set. For other cases, NULL
		-- will be returned.
	local res: POINTER
	do
   		-- Returns : the property or NULL if not set. Free it with g_base_info_unref() when done. [transfer full]
		res := g_function_info_get_property(handle)
		if res.is_not_null then
			create Result.from_external_pointer(res)
		end
	end

	vfunc: GI_VFUNC_INFO is
		-- Obtain the virtual function associated with this GIFunctionInfo.
		-- Only GIFunctionInfo with the flag GI_FUNCTION_WRAPS_VFUNC has a
		-- virtual function set. For other cases, NULL will be returned.
	local res: POINTER
	do
		res := g_function_info_get_vfunc(handle)
		-- Returns : the virtual function or NULL if not set. Free it by
		-- calling g_base_info_unref() when done. [transfer full]
		if res.is_not_null then
			create Result.from_external_pointer(res)
		end
	end

	-- TODO: shall this be wrapped? g_function_info_invoke ()
	--
	-- gboolean            g_function_info_invoke              (GIFunctionInfo *info,
	--                                                          const GIArgument *in_args,
	--                                                          int n_in_args,
	--                                                          const GIArgument *out_args,
	--                                                          int n_out_args,
	--                                                          GIArgument *return_value,
	--                                                          GError **error);
	--
	--   Invokes the function described in info with the given arguments. Note that inout parameters must appear in both
	--   argument lists. This function uses dlsym() to obtain a pointer to the function, so the library or shared object
	--   containing the described function must either be linked to the caller, or must have been g_module_symbol()ed before
	--   calling this function.
	--
	--   info :         a GIFunctionInfo describing the function to invoke
	--   in_args :      an array of GIArguments, one for each in parameter of info. If there are no in parameter, in_args can be
	--                  NULL
	--   n_in_args :    the length of the in_args array
	--   out_args :     an array of GIArguments, one for each out parameter of info. If there are no out parameters, out_args
	--                  may be NULL
	--   n_out_args :   the length of the out_args array
	--   return_value : return location for the return value of the function. If the function returns void, return_value may be
	--                  NULL
	--   error :        return location for detailed error information, or NULL
	--   Returns :      TRUE if the function has been invoked, FALSE if an error occurred.
end -- class GI_FUNCTION_INFO
	
