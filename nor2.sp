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
+Out_T_DLY=21.95
+PRD=22
+tpd=18.613

****** Sources ******
VSupply			Vs		0		DC		Vdd

.vec 'VectorTest.txt'

***** NOR Transistor Level ******
Mp6				x		  Vc	 Vs 	 Vs		 pmos		l='Lmin'		w='Wp'
Mp5				y		  Vb	 x		 x		 pmos		l='Lmin'		w='Wp'
Mp4       out		Va	 y		 y		 pmos		l='Lmin'		w='Wp'
Mn1       out   Va   0     0     nmos   l='Lmin'    w='Wn'
Mn2       out   Vb   0     0     nmos   l='Lmin'    w='Wn'
Mn3       out   Vc   0     0     nmos   l='Lmin'    w='Wn'

*********Type of Analysis***
.meas tran AVGpower avg  Power
.measure  tran   PDP  PARAM = ('AVGpower*tpd')

.tran  0.1ns  20ns
.op
.end
