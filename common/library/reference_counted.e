deferred class REFERENCE_COUNTED
	-- A wrapper for a C object whose memory is handled throught
	-- reference counting, i.e. GObject

inherit
   WRAPPER
      undefine
         from_external_pointer
      end

feature {WRAPPER, WRAPPER_HANDLER}
	ref is 
			-- Increase the reference count 
		deferred 
		end

	unref is
			-- Decrease the reference count
		deferred
		end

	dispose is
			-- 
		do 
			unref 
			handle := default_pointer
		end
end
