-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class TARGET_EXTERNALS


insert ANY undefine is_equal, copy end

		STANDARD_C_LIBRARY_TYPES
feature {} -- External calls

	llvmabialignment_of_type (an_argument_l620_c7: POINTER; an_argument_l621_c7: POINTER): NATURAL
 		-- LLVMABIAlignmentOfType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMABIAlignmentOfType"
		}"
		end

	llvmabisize_of_type (an_argument_l2166_c7: POINTER; an_argument_l2167_c7: POINTER): NATURAL_64
 		-- LLVMABISizeOfType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMABISizeOfType"
		}"
		end

	llvmadd_target_data (an_argument_l988_c7: POINTER; an_argument_l989_c7: POINTER)
 		-- LLVMAddTargetData
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMAddTargetData"
		}"
		end

	llvmadd_target_library_info (an_argument_l7114_c7: POINTER; an_argument_l7115_c7: POINTER)
 		-- LLVMAddTargetLibraryInfo
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMAddTargetLibraryInfo"
		}"
		end

	llvmbyte_order (an_argument_l2716_c7: POINTER): INTEGER
 		-- LLVMByteOrder
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMByteOrder"
		}"
		end

	llvmcall_frame_alignment_of_type (an_argument_l7255_c7: POINTER; an_argument_l7256_c7: POINTER): NATURAL
 		-- LLVMCallFrameAlignmentOfType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMCallFrameAlignmentOfType"
		}"
		end

	llvmcopy_string_rep_of_target_data (an_argument_l6170_c7: POINTER): POINTER
 		-- LLVMCopyStringRepOfTargetData
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMCopyStringRepOfTargetData"
		}"
		end

	llvmcreate_target_data (a_string_rep: POINTER): POINTER
 		-- LLVMCreateTargetData
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMCreateTargetData"
		}"
		end

	llvmdispose_target_data (an_argument_l3508_c7: POINTER)
 		-- LLVMDisposeTargetData
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMDisposeTargetData"
		}"
		end

	llvmelement_at_offset (an_argument_l1062_c7: POINTER; a_struct_ty: POINTER; an_offset: NATURAL_64): NATURAL
 		-- LLVMElementAtOffset
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMElementAtOffset"
		}"
		end

	llvminitialize_all_asm_parsers
 		-- LLVMInitializeAllAsmParsers
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllAsmParsers()"
		}"
		end

	llvminitialize_all_asm_printers
 		-- LLVMInitializeAllAsmPrinters
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllAsmPrinters()"
		}"
		end

	llvminitialize_all_disassemblers
 		-- LLVMInitializeAllDisassemblers
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllDisassemblers()"
		}"
		end

	llvminitialize_all_target_infos
 		-- LLVMInitializeAllTargetInfos
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllTargetInfos()"
		}"
		end

	llvminitialize_all_target_mcs
 		-- LLVMInitializeAllTargetMCs
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllTargetMCs()"
		}"
		end

	llvminitialize_all_targets
 		-- LLVMInitializeAllTargets
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeAllTargets()"
		}"
		end

	llvminitialize_native_target: INTEGER
 		-- LLVMInitializeNativeTarget
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMInitializeNativeTarget()"
		}"
		end

	llvmint_ptr_type (an_argument_l4983_c7: POINTER): POINTER
 		-- LLVMIntPtrType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMIntPtrType"
		}"
		end

	llvmoffset_of_element (an_argument_l4978_c7: POINTER; a_struct_ty: POINTER; an_element: NATURAL): NATURAL_64
 		-- LLVMOffsetOfElement
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMOffsetOfElement"
		}"
		end

	llvmpointer_size (an_argument_l4170_c7: POINTER): NATURAL
 		-- LLVMPointerSize
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMPointerSize"
		}"
		end

	llvmpreferred_alignment_of_global (an_argument_l767_c7: POINTER; a_global_var: POINTER): NATURAL
 		-- LLVMPreferredAlignmentOfGlobal
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMPreferredAlignmentOfGlobal"
		}"
		end

	llvmpreferred_alignment_of_type (an_argument_l2635_c7: POINTER; an_argument_l2636_c7: POINTER): NATURAL
 		-- LLVMPreferredAlignmentOfType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMPreferredAlignmentOfType"
		}"
		end

	llvmsize_of_type_in_bits (an_argument_l513_c7: POINTER; an_argument_l514_c7: POINTER): NATURAL_64
 		-- LLVMSizeOfTypeInBits
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMSizeOfTypeInBits"
		}"
		end

	llvmstore_size_of_type (an_argument_l5609_c7: POINTER; an_argument_l5610_c7: POINTER): NATURAL_64
 		-- LLVMStoreSizeOfType
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "LLVMStoreSizeOfType"
		}"
		end

	-- function unwrap in unwrapped namespace llvm skipped.
	-- function unwrap in unwrapped namespace llvm skipped.
	-- function wrap in unwrapped namespace llvm skipped.
	-- function wrap in unwrapped namespace llvm skipped.

end -- class TARGET_EXTERNALS
