#! /usr/bin/awk -f

# This script convert an tab separated adjacency matrix to .adj file like the generated from ARACNe suitable for ssmarina
# original idea from Joshua Haase https://github.com/xihh87

BEGIN{
	FS = "\t"}
NR==1{
	split($0,head,FS) # Using tab, separeted first line and save like head.
	} 


# from the second line find greater than zero and prints name and mi value in front his header name
NR>1{
	printf("%s\t", $1);
	for (i = 2; i <= NF; i++) if($i > 0 ) printf("%s\t%s\t", head[i],$i);
	printf(RS) # Salto de linea por default
	}
