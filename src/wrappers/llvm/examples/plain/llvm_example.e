class LLVM_EXAMPLE
	-- A plain example of LLVM that outputs bytecode of a module. Pass it to llvm-dis

	-- Currently we must use Makefile becuase even if we used C bindings we
	-- must use C++ linker. This could be achieved changind compile modes; it
	-- is more easily approached using make. See
	-- http://npcontemplation.blogspot.com/2008/06/secret-of-llvm-c-bindings.html 

insert 
	SHARED_LLVM
	LLVM_INTEGER_TYPES
	CORE_EXTERNALS
creation make

feature {} -- Creation
	make is

		do
			create module.with_name("llvm-example")				
			use_plugin
			make_muladd
			make_main

			module.write_bitcode_to(std_output)
			std_error.put_string(once "End of example reached.%N")
			-- verifyModule(*Mod, PrintMessageAction);

			-- create pass_manager
			-- pass_manager.add(createPrintModulePass(&outs()));
			-- pass_manager.run(module)
		end
	
	make_muladd is
		local x,y,z, tmp,tmp2,ret: LLVM_VALUE; param_iter: ITERATOR[LLVM_VALUE]
		do
			create muladd_type.make(int_32, <<int_32,int_32,int_32>>,False)
			-- `muladd' is a function that takes three 32-bit integers, returns a 32bit integer and is not variadic.
			muladd := module.new_function("mul_add",muladd_type)
			calling_convention.set_ccall_conv
			muladd.set_calling_convention(calling_convention)
			-- set parameters name
			check 
				muladd.parameters_count=3
			end
			-- Set parameters' names, keeping a reference to the value for further usage
			param_iter := muladd.new_parameter_iterator
			param_iter.start; x:=param_iter.item; x.set_name("x")
			param_iter.next;  y:=param_iter.item; y.set_name("y")
			param_iter.next;  z:=param_iter.item; z.set_name("z")
			print("[
			muladd.do_all_parameters (agent {LLVM_VALUE}.print_on(std_error))
			violates the not_locked precondition in ANY.print_on
			]")

			check 
				muladd.parameter(0).name.is_equal("x")
				muladd.parameter(1).name.is_equal("y")
				muladd.parameter(2).name.is_equal("z")
				muladd.for_all_parameters(agent name_not_void)
				muladd.exists_parameter(agent name_is(?,"y"))
			end
			-- Add function body
			create block.appended_in_context(global_context,muladd,"entry-block")
			create builder
			builder.position_at_end_of(block)
			tmp := builder.mul(x,y,"tmp")
			tmp2 := builder.add(tmp,z,"tmp2")
			ret := builder.return(tmp2)
	end

	make_struct is
		do
			-- struct will contain an int, a bool and a 8bit integer.
			create struct_type.make(<<int_32,bool,int_8>>,False)      
		end

	make_main is
		-- Emit the usual entry point function of a C program: "int main (int argc, char *argv[]);"
		local tmp: LLVM_VALUE; arg_type, argv_type: LLVM_POINTER_TYPE;
		do
			-- main will be the usual entry point of a C program: "int main (int argc, char *argv[]);"
			create arg_type.make(int_8) -- An argument is a pointer to 8 bit numbers, aka char
			create argv_type.make(arg_type) -- argv is a "pointer to/an array of" arguments
			create main_type.make(int_32,<<int_32, argv_type>>, False)
			main := module.new_function("main",main_type)
			calling_convention.set_ccall_conv
			main.set_calling_convention(calling_convention)
			create block.appended_in_context(global_context,main,"main-first-block")
			create builder.at_end_of(block)
			tmp := builder.call(putc,<<hello_string>>,"invoking-putc")
			-- Always return 1
			tmp := builder.return (create {LLVM_CONSTANT_INT}.integer_32(1))
		end

	use_plugin is
		-- dummy feature to trigger plugin usage
	local p: POINTER
	do
		p:=llvmint_32type
	end
feature {} -- tests agents
	name_not_void (a_value: LLVM_VALUE): BOOLEAN is
		require a_value/=Void
		do
			Result := a_value.name/=Void
		end

	name_is (a_value: LLVM_VALUE; a_name: ABSTRACT_STRING): BOOLEAN is
		require
			a_value/=Void
			a_name/=Void
		do
			Result := a_value.name.is_equal(a_name)
		end
feature {ANY} -- data
	calling_convention: LLVMCALL_CONV_ENUM
	module: LLVM_MODULE 
	builder: LLVM_BUILDER  
	block: LLVM_BASIC_BLOCK 
	-- pass_manager: LLVM_PASS_MANAGER

feature {} -- Functions
	muladd: LLVM_FUNCTION 
		-- A function computes Result=x*y+z.
	main: LLVM_FUNCTION
		-- The famous main function of C language
		putc: LLVM_FUNCTION
feature {} -- Types
	main_type: LLVM_FUNCTION_TYPE 
	struct_type: LLVM_STRUCT_TYPE 
	muladd_type: LLVM_FUNCTION_TYPE 
feature {ANY} -- Constants
	hello_string: STRING is "Hello Liberty!\n"

end -- class LLVM_EXAMPLE

-- Copyright 2009 Paolo Redaelli
