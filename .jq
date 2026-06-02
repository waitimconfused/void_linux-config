def truncate(string; size):
	if (string | length) <= size
		then string
		else string[0:size]+"..."
	end
;
