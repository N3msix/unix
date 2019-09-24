#!/bin/sed -Enf

: cycle
/.*\+.*/ {
	h
	#Samotne scitavanie budeme robit substituciam

	 s/([0-9]+) *[+] *([0-9]+)/@###\1 \2###@/
	 s/.*@###//
	 s/###@.*//

	 s/^/,/
	 
	 : last_digit
	#Z oboch cisel vezmem posledne dve cifry a dam ich pred ciarku
	 s/(.*),(.*)([0-9]) (.*)([0-9])/\1\3\5,\2 \4/
	 t last_digit
	 : last_digit_left
	 
	#Ak jednemu cislu dosli cifry, pridavam implicitne nuly, kym nedojdu cifry
	 s/(.*), (.*)([0-9])/\10\3, \2/
	 t last_digit_left
	 : last_digit_right
	 
	#Ak jednemu cislu dosli cifry, pridavam implicitne nuly, kym nedojdu cifry
	 s/(.*),(.*)([0-9]) /\10\3,\2 /
	 t last_digit_right
	 
	#Z konca odstranim ciarku a medzeru za nou
	 s/,.*//
	 
	#Urobim teda substituciu, ktora mi predchadzajuci tvar
	#3726150403
	#prevedie na
	#,037:26150403
	s/([0-9])([0-9])/,0\1\2:/
	
	#,: cislo na hodnotu
	: sum
		 : value_to_x
		 s/,0([^:]*):/,\1:/
		 s/,1([^:]*):/,\1X:/
		 s/,2([^:]*):/,\1XX:/
		 s/,3([^:]*):/,\1XXX:/
		 s/,4([^:]*):/,\1XXXX:/
		 s/,5([^:]*):/,\1XXXXX:/
		 s/,6([^:]*):/,\1XXXXXX:/
		 s/,7([^:]*):/,\1XXXXXXX:/
		 s/,8([^:]*):/,\1XXXXXXXX:/
		 s/,9([^:]*):/,\1XXXXXXXXX:/
		 t value_to_x
		 
		 # 10 x to carry
		 s/XXXXXXXXXX:/1:/
		 
		 # 0 at the end for shorter
		 s/,(X*):/,\10:/
			
		 s/XXXXXXXXX/9/
		 s/XXXXXXXX/8/
		 s/XXXXXXX/7/
		 s/XXXXXX/6/
		 s/XXXXX/5/
		 s/XXXX/4/
		 s/XXX/3/
		 s/XX/2/
		 s/X/1/
		 s/,0:/,00:/
		 s/,1:/,01:/
		##      Teraz mam dve moznosti:
		#	     b) za dvojbodkou uz nie su dalsie cifry:
		#             nnn,61:
		#             nnn,80:
		#           Substituciou prevediem na:
		#             16nnn
		#             8nnn
		s/([^,]*),([0-9])1:$/1\2\1/
		s/([^,]*),([0-9])0:$/\2\1/
		#        a) za dvojbodkou su dalsie cifry:
		#             nnn,61:ddee
		#             6nnn,1dd:ee
		 s/([^,]*),([0-9])([0-9]):([0-9][0-9])(.*)/\2\1,\3\4:\5/
	 t sum
	 # 5. Teraz mam v hlavnom priestore sucet cisel A a B, a v uloznom priestore mam
	 s/$/,/
	  
	 #    Vhodnym regularnym vyrazom urobim substituciu, ktora dosadi cislo pred ciarkou za prvy vyskyt A + B:
	 x
	 s/([0-9]+ *[+] *[0-9]+)/@###\1###@/
	 x
	 
	 #    Appendujem obsah ulozneho priestoru k obsahu hlavneho priestoru (prikaz G):
	 G
	 s/\n//
	 
	 #    Vhodnym regularnym vyrazom urobim substituciu, ktora dosadi cislo pred ciarkou za prvy vyskyt A + B:
	 s/(.*),(.*)@###.*###@(.*)/\2\1\3/

	 t cycle
}

p


