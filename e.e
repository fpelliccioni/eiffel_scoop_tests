note
	description: "Summary description for {E}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E

create
	make_with_c

feature
	c : separate C

feature {NONE} -- Initialization

	make_with_c( c_arg : separate C )
	do
		c := c_arg
	end

feature
	f
	local
		x : INTEGER
	do
		print ("e.f()%N")

		from
       		x := 0
   		invariant
       		x <= 100
	    until
    	    x >= 100
    	loop
        	x := x + 1
        	print_c_val( c ) -- lock on this call
    	end

		print ("%Ne.f() end %N")
	end

	print_c_val( c_arg : separate C )
	do
		print( c_arg.x )
	end

end
