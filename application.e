-- http://docs.eiffel.com/book/solutions/concurrent-eiffel-scoop

note
	description : "ScoopTest1 application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature

feature {NONE} -- Initialization
	make
		do
			test_with_d
			print("---------------------------------------------------------------%N")
			test_with_e
		end

	test_with_d
		local
			d_sep : separate D
			c : C
			x : INTEGER
		do
			create c
			create d_sep.make_with_c( c )

			exec_df( d_sep )

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
	    		print ( x.out + " " )
	    	end

	    	print( "test_with_d end" )
		end

	test_with_e
		local
			e_sep : separate E
			c : C
			x : INTEGER
		do
			create c
			create e_sep.make_with_c( c )

			exec_ef( e_sep )

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
	    		print ( x.out + " " )
	    	end

	    	print( "test_with_e end" )
		end

	exec_df( d_arg : separate D )
		do
			d_arg.f
		end

	exec_ef( e_arg : separate E )
		do
			e_arg.f
		end

end
