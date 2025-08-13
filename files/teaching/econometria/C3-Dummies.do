* Pavel Solís
* Econometría I

* ==============================================================================
* Variables Dummy
* ==============================================================================
cd "~\Documentos\eco3404"
use hsb2, clear
tabulate female
tabulate race
tabulate ses
tabulate schtyp
tabulate prog
summarize read write math science socst

/* Objetivo: Tras explicar la puntuación en pruebas de escritura con información sobre 
pruebas de lectura y matemáticas, y el tipo de programa del estudiante (general, académico, 
vocacional), queremos saber si el tipo de programa es estadísticamente significativo. */

* Creación de variables dummy para una categoría
* ------------------------------------------------------------------------------
generate prog1 = 0
replace prog1 = 1 if prog == 1
replace prog1 = . if missing(prog)
generate prog2 = prog == 2
generate prog3 = prog == 3 if !missing(prog)
browse prog*
drop prog1 prog2 prog3

* Creación de variables dummy para varias categorías
* ------------------------------------------------------------------------------
tabulate prog, generate(prog)
describe
browse prog*

* Análisis
* ------------------------------------------------------------------------------
regress write read math prog
regress write read math prog2 prog3
regress write read math
display ((9938.81034-9708.28876)/9708.28876)*(195/2)
display Ftail(2,195,2.3151201)
regress write read math prog2 prog3
test prog2 prog3

regress write read math prog1 prog3

regress write read math prog1 prog2 prog3
regress write read math prog1 prog2 prog3, nocons

* Notación de variable factorial (usa prefijos, evita crear dummies explícitamente)
* ------------------------------------------------------------------------------
regress write read math prog2 prog3
drop prog1 prog2 prog3
list prog i.prog in 1/10
regress write read math i.prog
test 2.prog 3.prog

regress write read math ib2.prog
dis _b[_cons] + _b[1.prog]
dis _b[3.prog] - _b[1.prog]

regress write read math 3.prog

* ==============================================================================
* Interacciones
* ==============================================================================
/* Operadores para variables factoriales:
- i. Operador unitario para especificar variables dummy
- c. Operador unitario para tratar variable como continua
- #  Operador binario para especificar interacciones
- ## Operador binario para especificar interacciones factoriales */

use hsb2, clear
generate prog2 = prog == 2
generate highmath = math > 50
generate byte hghmthprog2 = prog2*highmath
browse prog math prog2 highmath hghmthprog2

regress write read highmath prog2 hghmthprog2
regress write read highmath##2.prog

regress write read c.math##i.prog

* regress write read highmath#prog2
* regress write read c.math#i.prog