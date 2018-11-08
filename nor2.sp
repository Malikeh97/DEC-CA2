******** Digital Electronics, inverter design********


************ Library *************
.inc '32nm_bulk.pm'

************ VectorTest *************
.vec 'VectorTest.txt'

********* Params*******
.param			Lmin=45n
+beta=4
+Wp='Lmin*6'
+Wn='Lmin*1'
+Vdd=1V
+temp=25DEG
+slp=0.1p
+Out_T_DLY=12.95
+PRD=18



****** Sources ******
VSupply			Vs		0		DC		Vdd
*Vina				Va		0		DC		0
*Vinb				Vb		0		DC		0
*Vinc				Vc		0		pulse	Vdd	0	0n	1p	1p	50p 100p

.vec 'VectorTest.txt'

***** NOR Transistor Level ******
Mp6				x		  Vc	 Vs 	 Vs		 pmos		l='Lmin'		w='Wp'
Mp5				y		  Vb	 x		 x		 pmos		l='Lmin'		w='Wp'
Mp4       out		Va	 y		 y		 pmos		l='Lmin'		w='Wp'
Mn1       out   Va   0   0   nmos   l='Lmin'    w='Wn'
Mn2       out   Vb   0   0   nmos   l='Lmin'    w='Wn'
Mn3       out   Vc   0   0   nmos   l='Lmin'    w='Wn'

*********Type of Analysis***
*.measure	tran	AVGpower avg	Power	from=100ps		to=200ps
.measure  tran  average_power avg SRC_PWR from=100ps		to=200ps

.measure tpdr * rising prop delay
+ trig V(Vc) val='Vdd/2' fall=1
+ targ V(out) val='Vdd/2' rise=1

.measure tpdf * falling prop delay
+ trig V(Vc) val='Vdd/2' rise=1
+ targ V(out) val='Vdd/2' fall=1

.measure tpd param='(tpdr+tpdf)/2'
.measure tran   PDP  PARAM = ('average_power*tpd')

.tran  0.1ns  20ns
.op
.end
