#!/usr/bin/awk -f
BEGIN {
        RS="<"
        FS="[hH][rR][eE][fF]"
}

/^[Aa][ \n]*/ {
        if ($2 ~ /[ \n]*=[ \n]*[\"\']/) {
                gsub("'", "\"")   
                split($2, a, "\"")
                l = a[2]
        }

        if ($2 ~ /[ \n]*=[^' "\n]/) {
                l=index($2, "=")+1
                g=index($2, ">")
                z=g-l
                l = substr($2, l, z)
        }
        gsub("&quot;", "\"", l)
        gsub("&lt;", "<", l)
        gsub("&gt;", ">", l)
        gsub("&amp;", "#", l)
        print l
}