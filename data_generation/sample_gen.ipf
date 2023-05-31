

///////////////////////////////////////////////////////////////////////////////

// to generate a sample string, similar to list, which is
//	stores as a global string variable, `sample`, containing
//	random values

function construct_sample_str (length, separator)
	variable length    // 100 is a good length
	string separator   // ","

	string str=""

	make /o /d /n=(length) tmp_data = enoise(1)

	variable i
	variable val

	for (i=0 ; i<length ; i=i+1 )
		val = tmp_data[i]

		if (i==0)
			str=num2str(val)
		elseif (i>0)
			sprintf str, "%s%s%s", str,separator, num2str(val)
		endif

	endfor

	string /G sample =  str

end

///////////////////////////////////////////////////////////////////////////////
