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
		local
--			env: EXECUTION_ENVIRONMENT
		do
----			create env
----			env.sleep (nanoseconds: INTEGER_64)

--			test1
--			test2
--			test3
			test4
--			test5

		end



	test1
		local
			a : A
			b : B
			a_sep : separate A
			b_sep : separate B
			d_sep : separate D

			c : C
		--	d : D

			x : INTEGER

		do
			create a
			create b
			create a_sep
			create b_sep

			a.f(1)
			b.f(2)
			exec1( a_sep, 3 )    -- wrapper for a_sep.f(), needed because the "Separate argument Rule"
								 -- Async call. How I can figure out that this is a Asyncronous call ????????? I have to see the funcion declaration
			b.f(4)
			exec1( a_sep, 5 )    -- a_sep.f()
			exec2( b_sep, 6 )    -- b_sep.f()

		end




	test2
		local
			a_sep : A
			x : INTEGER
		do
			create a_sep

			exec1( a_sep, 9 )

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
				print( x )
				print( " " )
	    	end

		end

	test3
		local
			a_sep : separate A
			x : INTEGER
		do
			create a_sep

			exec1( a_sep, 9 )
			-- inside exec1 there is a separate call a_sep.f( INTEGER )
			-- the argument ( INTEGER ) is a value type, this is not the S2.2 rule
			-- this is the A1 rule

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
				print( x.out + " " )
	    	end

		end





	inc_c( c_arg : separate C )
		do
			c_arg.inc
		end

	test4
		local
			d_sep : separate D
			c : C
			x : INTEGER
		do
			create c
			-- inc_c( c ) -- c.inc
			create d_sep.make_with_c( c )

			print( " before exec_and_nonsep2%N" )
			exec_and_nonsep2( d_sep )   -- d_sep locks on this call, c locks too ( inside d.f() )

			-- inside exec_and_nonsep2 there is a separate call d_sep.f()
			--  d_sep.f() has no arguments, this is not the S2.2 rule
			-- this is the A1 rule

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
	    		print ( x.out + " " )
				-- c.inc
	    	end

	    	print( "test4 end" )
		end



	test5
		local
			d_sep : separate D
			c : C
			x : INTEGER
		do
			create c
			c.inc
			create d_sep.make

			exec_and_nonsep2( d_sep )   -- d_sep locks on this call, c locks too ( inside d.f() )

			-- inside exec_and_nonsep2 there is a separate call d_sep.f()
			--  d_sep.f() has no arguments, this is not the S2.2 rule
			-- this is the A1 rule

			from
	       		x := 0
	   		invariant
	       		x <= 100
		    until
	    	    x >= 100
	    	loop
	    		x := x + 1
	    		print (x)
				c.inc
	    	end

		end


	exec1( a_arg : separate A; x_arg : INTEGER )
		do
			a_arg.f( x_arg )
			--async
		end

	exec2( b_arg : separate B; x_arg : INTEGER )
		do
			b_arg.f(  x_arg )
		end

	exec_and_nonsep2( d_arg : separate D ) --; x : INTEGER; c_arg : C )
		do
			d_arg.f
			--async
		end
end
