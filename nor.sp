******** Digital Electronics, inverter design********


************ Library *************
.inc '32nm_bulk.pm'

********* Params*******
.param			Lmin=45n
+beta=4
+Wp='Lmin*6'
+Wn='Lmin*1'
+Vdd=1V
+temp=25DEG


****** Sources ******
VSupply			Vs		0		DC		Vdd
Vina				Va		0		DC		0
Vinb				Vb		0		DC		0
Vinc				Vc		0		pulse	Vdd	0	0n	1p	1p	50p 100p

.vec 'VectorTest.txt'

***** NOR Transistor Level ******
Mp6				x		  Vc	 Vs 	 Vs		 pmos		l='Lmin'		w='Wp'
Mp5				y		  Vb	 x		 x		 pmos		l='Lmin'		w='Wp'
Mp4       out		Va	 y		 y		 pmos		l='Lmin'		w='Wp'
Mn1       out   Va   0   0   nmos   l='Lmin'    w='Wn'
Mn2       out   Vb   0   0   nmos   l='Lmin'    w='Wn'
Mn3       out   Vc   0   0   nmos   l='Lmin'    w='Wn'

*********Type of Analysis***

.measure tran t_rise
+ trig V(out) val = '0.1*Vdd'  rise = 1
+ targ V(out) val = '0.9*Vdd'  rise = 1

.measure tran t_fall
+ trig V(out) val = '0.9*Vdd'  fall = 1
+ targ V(out) val = '0.1*Vdd'  fall = 1


.measure tpdr * rising prop delay
+ trig V(Vc) val='Vdd/2' fall=1
+ targ V(out) val='Vdd/2' rise=1

.measure tpdf * falling prop delay
+ trig V(Vc) val='Vdd/2' rise=1
+ targ V(out) val='Vdd/2' fall=1

.measure tpd param='(tpdr+tpdf)/2' * average prop delay
.measure tran   fmax  PARAM = ('(1/(t_rise+t_fall))')

.tran  0.1ns  20ns
.op
.end
