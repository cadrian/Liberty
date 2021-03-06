-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class OP_STATUS_ENUM

insert ENUM

creation {ANY} default_create
feature {ANY} -- Validity
    is_valid_value (a_value: INTEGER): BOOLEAN
        do
            Result := ((a_value = div_by_zero_low_level)  or else
				(a_value = inexact_low_level)  or else
				(a_value = invalid_op_low_level)  or else
				(a_value = ok_low_level)  or else
				(a_value = overflow_low_level)  or else
				(a_value = underflow_low_level) )
		end

feature {ANY} -- Setters
	default_create,
	set_div_by_zero
		do
			value := div_by_zero_low_level
		end

	set_inexact
		do
			value := inexact_low_level
		end

	set_invalid_op
		do
			value := invalid_op_low_level
		end

	set_ok
		do
			value := ok_low_level
		end

	set_overflow
		do
			value := overflow_low_level
		end

	set_underflow
		do
			value := underflow_low_level
		end

feature {ANY} -- Queries
	is_div_by_zero: BOOLEAN
		do
			Result := (value=div_by_zero_low_level)
		end

	is_inexact: BOOLEAN
		do
			Result := (value=inexact_low_level)
		end

	is_invalid_op: BOOLEAN
		do
			Result := (value=invalid_op_low_level)
		end

	is_ok: BOOLEAN
		do
			Result := (value=ok_low_level)
		end

	is_overflow: BOOLEAN
		do
			Result := (value=overflow_low_level)
		end

	is_underflow: BOOLEAN
		do
			Result := (value=underflow_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	div_by_zero_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opDivByZero"
 			}"
 		end

	inexact_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opInexact"
 			}"
 		end

	invalid_op_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opInvalidOp"
 			}"
 		end

	ok_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opOK"
 			}"
 		end

	overflow_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opOverflow"
 			}"
 		end

	underflow_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "opUnderflow"
 			}"
 		end


end -- class OP_STATUS_ENUM
