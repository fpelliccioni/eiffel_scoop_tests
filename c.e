note
	description: "Summary description for {C}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	C

feature
	x : INTEGER

	inc
	do
		x := x + 1
	end


	val : INTEGER
	do
		Result := x
	end

end
