/*====================================================================
Project:       Encuesta sobre capital social, confianza y acción colectiva
Author:        E+E ECONOMÍA Y ESTADÍSTICAS PARA EL DESARROLLO
Description:   Generacion de indices e indicadores
----------------------------------------------------------------------
Creation Date:    17 Enero 2021 
====================================================================*/

/* Intrucciones: 

Para evaluar las hipótesis preliminares y algunas relaciones adicionales, proponemos 
calcular índices agregados de 5 variables diferentes a nivel de los tres estratos, 
dejando lugar para luego recalcular los índices a distintos niveles. Para cada índice, 
proponemos calcular una suma ponderada de puntajes individuales para cada variable de 
interés en la encuesta.

  */

/*====================================================================
                        0: Program set up
====================================================================*/
clear all
set more off

unicode encoding set ISO-8859-1
capture unicode translate *

clear
set more off 
*cd "" //Cargar link dónde se encuentran los datos

use "../data/database_final"

/*========================================================================================
   1:Puntajes de Capital Social (redes interpersonales y confianza) l (SON 5 VARIABLES)
   
==========================================================================================

1) Puntaje de capital social filial (〖cs〗_filial=[0…30])

a. Sumar 1 punto por cada sí de respuesta a las preguntas B1 y B4 ([0…8]).

b. Sumar 2 puntos por cada sí de respuesta a la pregunta B2 ([0…14]).

c. Sumar puntos en base a la posición de las respuestas B3.1 y B3.2 en relación
a los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, 
siguiendo la siguiente tabla guía ([0…8]): 

Valor = 0  -->	0 puntos
Valor = Q1 -->	1
Valor = Q2 -->	2
Valor = Q3 -->	3
Valor > Q3 -->	4

*/
 
// NOTA: Los valores asignados a "No Responde" (99) Y "No" pasan a (0). 

local var b_1_1 b_1_2 b_1_3 b_1_4 b_1_5 b_1_6 b_1_7 b_2_1 b_2_2 b_2_3 b_2_4 b_2_5 b_2_6 b_2_7 b_4

foreach X in `var' {
	capture recode `X'(3=0)
	capture recode `X'(2=0)
}

gen aux1 = b_1_1+ b_1_2+ b_1_3+ b_1_4+ b_1_5+ b_1_6+ b_1_7 + b_4

gen aux2 = (b_2_1+ b_2_2+ b_2_3+ b_2_4+ b_2_5+ b_2_6+ b_2_7) * 2

replace b_3_1=. if b_3_1==0

xtile b3_1= b_3_1, nq(4)

replace b3_1= 0 if b3_1==.

replace b_3_2=. if b_3_2==0

xtile b3_2= b_3_2, nq(4)

replace b3_2= 0 if b3_2==.

g aux3 = b3_1+b3_2

g cs_filial= aux1+aux2+aux3    // cs Filial

drop aux1 aux2 aux3


/*  Puntaje de capital social conectivo (〖cs〗_conectivo=[0…36]) 

a) 	Sumar 1 punto por cada sí de respuesta a las preguntas B5 y B8 ([0…10]). 

b) 	Sumar 2 puntos por cada sí de respuesta a la pregunta B6 ([0…18]).

c) 	Sumar puntos en base a la posición de las respuestas B7.1 y B7.2 en relación a los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, siguiendo la siguiente tabla guía ([0…8]): 

Valor = 0  -->	0 puntos
Valor = Q1 -->	1
Valor = Q2 -->	2
Valor = Q3 -->	3
Valor > Q3 -->	4
*/

local var b_5_1 b_5_2 b_5_3 b_5_4 b_5_5 b_5_5_1 b_5_6 b_5_7 b_5_7_1 b_6_1 b_6_2 b_6_3 b_6_4 b_6_5 b_6_5_1 b_6_6 b_6_7 b_6_7_1 b_8

foreach X in `var' {
	capture recode `X'(3=0)
	capture recode `X'(2=0)
}

gen aux1 = b_5_1 + b_5_2 + b_5_3 + b_5_4 + b_5_5 + b_5_5_1 + b_5_6 + b_5_7 + b_5_7_1 + b_8

gen aux2 = (b_6_1 + b_6_2 + b_6_3 + b_6_4 + b_6_5 + b_6_5_1 + b_6_6 + b_6_7 + b_6_7_1) * 2

replace b_7_1=. if b_7_1==0

xtile b7_1= b_7_1, nq(4)

replace b7_1= 0 if b7_1==.

replace b_7_2=. if b_7_2==0

xtile b7_2= b_7_2, nq(4)

replace b7_2= 0 if b7_2==.

g aux3 = b7_1+b7_2

g cs_conectivo= aux1+aux2+aux3
drop aux1 aux2 aux3

/* 	Puntaje de capital social vinculante (〖cs〗_vinculante=[0…27]) 

Observación: El rango debe ser (〖cs〗_vinculante=[0…51])


a) 	Sumar 1 punto por cada sí de respuesta a las preguntas B9 ([0,1]). 

b) 	Sumar 2 puntos por cada sí de respuesta a la pregunta B10 ([0,2]).

c) 	Sumar puntos en base a la posición de las respuestas a las opciones de la pregunta B12 (B12.1, B12.2, B12.3, B12.3) en relación con los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, siguiendo la siguiente tabla guía ([0…16]): 

Observación: El rango debe ser ([0…32]): 

d) 	Sumar puntos en base a la posición de las respuestas a las opciones de la pregunta B11 (B11.1, B11.2, B11.3, B11.3) en relación con los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, siguiendo la siguiente tabla guía ([0…8]): 

e) Para las preguntas de confianza, se traduce la escala en una de las siguientes opciones, dependiendo de si la pregunta está en sentido negativo o positivo

*/

local var b_9 b_10

foreach X in `var' {
	capture recode `X'(3=0)
	capture recode `X'(2=0)
}

gen aux1 = b_9

gen aux2 = b_10 * 2
replace aux2=0 if aux2==.


replace b_12_1= . if b_12_1==0
xtile b12_1= b_12_1, nq(4)
replace b12_1= 0 if b12_1==.
replace b12_1=b12_1*2




replace b_12_2= . if b_12_2==0
xtile b12_2= b_12_2, nq(4)
replace b12_2= 0 if b12_2==.
replace b12_2=b12_2*2

replace b_12_3= . if b_12_3==0
xtile b12_3= b_12_3, nq(4)
replace b12_3= 0 if b12_3==.
replace b12_3=b12_3*2

replace b_12_4= . if b_12_4==0
xtile b12_4= b_12_4, nq(4)
replace b12_4= 0 if b12_4==.
replace b12_4=b12_4*2



replace b_11_1= . if b_11_1==0
xtile b11_1= b_11_1, nq(4)
replace b11_1 =0 if b11_1==.

replace b_11_2= . if b_11_2==0
xtile b11_2= b_11_2, nq(4)
replace b11_2 =0 if b11_2==.

replace b_11_3= . if b_11_3==0
xtile b11_3= b_11_3, nq(4)
replace b11_3 =0 if b11_3==.

replace b_11_4= . if b_11_4==0
xtile b11_4= b_11_4, nq(4)
replace b11_4 =0 if b11_4==.

gen aux3 = b12_1+b12_2+b12_3+b12_4

gen aux4 = b11_1+b11_2+b11_3+b11_4

gen cs_vinculante = aux1+aux2+aux3+aux4
drop aux1 aux2 aux3 aux4

/* 	Puntaje confianza interpersonal (〖conf〗_interpersonal=[-6…6]) 

a)	Sumar los puntos correspondientes a las respuestas de las preguntas C1, C2 y C3, usando la escala positiva o negativa según se indica en la siguiente tabla.

	Puntaje confianza institucional (〖conf〗_institucional=[-18…18])
	
a) Sumar los puntos correspondientes a las respuestas de las preguntas C4, C5, C6, C7, C8, C9, C10, C11, C12, usando la escala positiva o negativa según se indica en la siguiente tabla.


*/

//Preguntas negativas

local negativo c_1 c_2 c_4 c_5 c_8 c_11 c_12

foreach a in `negativo' {
	
	replace `a' = -2 if `a'==1 
	replace `a' = -1 if `a'==2 
	replace `a' = 0 if `a'==3
	replace `a' = 1 if `a'==4 
	replace `a' = 2 if `a'==5 
	replace `a' = 0 if `a'==99 
	
label drop `a'
	}

//Preguntas positivas

local positivo c_3 c_6 c_7 c_9 c_10

foreach a in `positivo' {
	
	replace `a' = 2 if `a'==1 
	replace `a' = 1 if `a'==2 
	replace `a' = 0 if `a'==3
	replace `a' = -1 if `a'==4 
	replace `a' = -2 if `a'==5 
	replace `a' = 0 if `a'==99 
	
label drop `a'
	}

	
gen conf_interpersonal= c_1+c_2+c_3

gen conf_institucional= c_4+c_5+c_6+c_7+c_8+c_9+c_10+c_11+c_12

/* 2.Puntajes de Vulnerabilidad Económica  l (SON 2 VARIABLES)

a) 	Puntaje parcial de vulnerabilidad económica según Galeano (〖vulnerabilidad〗_1=[0…13]): agregar las preguntas D1, D2 y D3 según los siguientes criterios, para calcular parcialmente la vulnerabilidad económica según parte del cuestionario propuesta por Galeano en su libro Territorios de Exclusión Social. 

b)	Sumar 1 punto por cada respuesta Sí a la pregunta D1 ([0…5]).

c)	Sumar puntos por cada opción marcada en las preguntas D2 ([0…5]) y D3 ([0…3]). según la siguiente escala de puntos para cada etiqueta. 

 */

local vulnerabilidad d_1_1 d_1_2 d_1_3 d_1_4 d_1_5

foreach b in `vulnerabilidad' {

	capture recode `b'(3=0)
	capture recode `b'(2=0)
}

gen aux1= d_1_1+d_1_2+d_1_3+d_1_4+d_1_5

replace d_2 = 0 if d_2 ==1
replace d_2 = 0 if d_2 ==2
replace d_2 = 0 if d_2 ==3
replace d_2 = 0 if d_2 ==4
replace d_2 = 1 if d_2 ==5
replace d_2 = 1 if d_2 ==6
replace d_2 = 2 if d_2 ==7
replace d_2 = 3 if d_2 ==8
replace d_2 = 4 if d_2 ==9
replace d_2 = 5 if d_2 ==10
replace d_2 = 5 if d_2 ==11
replace d_2 = 0 if d_2 ==12
label drop d_2

replace d_3 =0 if d_3==1
replace d_3 =2 if d_3==2
replace d_3 =2 if d_3==3
replace d_3 =3 if d_3==4
replace d_3 =2 if d_3==5
replace d_3 =1 if d_3==6
replace d_3 =0 if d_3==7
label drop d_3

g vulnerabilidad1= aux1+d_2+d_3
drop aux1

/* Puntaje de vulnerabilidad económicas según datos sociodemográficos (〖vulnerabilidad〗_2): 

 si existen criterios estándar, aplicarlos para agregar los números de esta sección en un único puntaje que represente un nivel de vulnerabilidad. 

 En el caso de las respuestas bajo D2.12 y D3.7, codificar y presentar su frecuencia unificada. 

*/

/***************************************************************************************************************************

												PNUD

****************************************************************************************************************************/

/* 3.Puntajes de Acción Colectiva l (SON 3 VARIABLES)

a) Puntaje de acción colectiva para acción comunitaria (〖ac〗_comunitaria=[0…3])

	1- Sumar 1 punto por cada sí de respuesta a las preguntas E1 ([0,1])

	2- Sumar 2 puntos por cada sí de respuesta a las preguntas E2 ([0,2]) */
	

	capture recode e_1 (3=0)
	capture recode e_1 (2=0)

	capture recode e_2 (3=0)
	capture recode e_2 (2=0)

gen aux1 = e_2 * 2

gen ac_comunitaria = e_1 + aux1
drop aux1

/*	Puntaje de acción colectiva para acción comunitaria asociada a activos colectivos (〖ac〗_(comunitaria_colectiva)=[0…18])

a)	Sumar 1 punto por cada sí de respuesta a las preguntas F2, F4, F5, F9, F13, F14 ([0…6]).  

b)	Sumar puntos según la siguiente tabla de valores para las respuestas a las preguntas F3, F6, F15 ([0…12]) */

local colectiva f_2 f_4 f_5 f_9 f_13 f_14

foreach c in `colectiva' {

	capture recode `c'(3=0)
	capture recode `c'(2=0)
	capture recode `c'(.=0)
}

gen aux1 = f_2 +f_4+f_5 +f_9 +f_13 +f_14

local tiempo f_3 f_6 f_15

foreach d in `tiempo' {
	
	replace `d' = 0 if `d'==99 
	replace `d' = 0 if `d'==.
	label drop `d'
	}
	
g aux2 = f_3+f_6+ f_15

gen ac_comunitaria_colectiva = aux1 + aux2
drop aux1 aux2

/*		Puntaje de acción colectiva para demandas cívicas (〖ac〗_demanda=[0…3])

a)	Sumar 1 punto por cada sí de respuesta a las preguntas E3 ([0,1])

b)	Sumar 2 puntos por cada sí de respuesta a las preguntas E4 ([0,2])

c)	En el caso de las respuestas bajo E5 y E6, codificar y presentar su frecuencia unificada. */


capture recode e_3 (3=0)
capture recode e_3 (2=0)

capture recode e_4 (3=0)
capture recode e_4 (2=0)

g aux1 = e_4 *2
	
gen ac_demanda= e_3 + aux1
drop aux1

	
/* 4.Puntaje de Activos Colectivos l ( 1 VARIABLE)

	El puntaje de activos colectivos se calcula según los siguientes criterios (commons=[0…19])
	
a)	Sumar 1 punto por cada Sí de respuesta a las preguntas F1, F7, F8, F10, F12 (solo si F13 es Sí), F16, F17, F18 ([0…13])

	*/
	
local activos f_1 f_7_1 f_7_2 f_7_3 f_7_4 f_7_5 f_8 f_10 f_16 f_17 f_18

foreach e in `activos' {
	
	capture recode `e'(3=0)
	capture recode `e'(2=0)
	capture recode `e'(.=0)
	}

	
	
g f_12_r= 1 if f_13==1
replace f_12_r=0 if f_12_r==.

gen aux1= f_1+ f_7_1+ f_7_2+ f_7_3+ f_7_4+ f_7_5+ f_8+ f_10+ f_12_r + f_16+f_17 +f_18
replace aux1 = 0 if aux1==.
	
replace f_11 =3 if f_11==1
replace f_11 =2 if f_11==2
replace f_11 =1 if f_11==3
replace f_11 =0 if f_11==4
replace f_11 =-1 if f_11==5
replace f_11 =0 if f_11==6
replace f_11 =0 if f_11==99
label drop f_11
replace f_19 =3 if f_19==1
replace f_19 =2 if f_19==2
replace f_19 =1 if f_19==3
replace f_19 =0 if f_19==4
replace f_19 =-1 if f_19==5
replace f_19 =0 if f_19==6
replace f_19 =0 if f_19==99
label drop f_19

gen aux2 = f_11 if f_10==1
replace aux2=0 if aux2==.
gen aux3= f_19 if f_18 ==1
replace aux3=0 if aux3==.

g commons= aux1+aux2+aux3
drop aux1 aux2 aux3


/*	Puntaje de respuesta institucional pública (R_pública=[0…10])

a)	Sumar 1 puntos por cada Sí de respuesta a las preguntas E7 ([0,1])

b)	Sumar 1 punto por cada opción marcada que no sea NS/NR o No en las preguntas E7.1 ([0…5]) y E8 ([0…4]).   */


capture recode e_7 (3=0)
capture recode e_7 (2=0)

replace e_7_1 = 1 if e_7_1 != 99 
replace e_7_1 = 0 if e_7_1 ==. | e_7_1==99

replace e_8 = 1 if e_8 != 99 
replace e_8 = 0 if e_8 ==. | e_8 ==99

g R_publica= e_7+e_7_1+e_8


/*	Puntaje de respuesta institucional civil (R_civil=[0…1])

a)	Sumar 1 puntos por cada Sí de respuesta a las preguntas E9 */

capture recode e_9 (3=0)
capture recode e_9 (2=0)

gen R_civil= e_9

/* 	Puntaje de respuesta institucional privada (R_privada=[0…1]) 

a.	Sumar 1 puntos por cada Sí de respuesta a las preguntas E10 */


capture recode e_10 (3=0)
capture recode e_10 (2=0)

g R_privada= e_10 


label var cs_filial "Puntaje de Capital social filial"

label var cs_conectivo "Puntaje de Capital social conectivo"         

label var cs_vinculante "Puntaje de Capital social vinculante" 

label var conf_interpersonal "Puntaje de Confianza Interpersonal"

label var conf_institucional "Puntaje confianza institucional "

label var vulnerabilidad1 "Puntaje parcial de Vulnerabilidad económica" 

label var ac_comunitaria "Puntaje de acción colectiva para acción comunitaria " 

label var ac_comunitaria_colectiva "Puntaje de acción colectiva para acción comunitaria asociada a activos colectivos"

label var ac_demanda "Puntaje de acción colectiva para demandas cívicas "

label var commons "Puntaje de activos colectivos"

label var R_publica "Puntaje de respuesta institucional pública "

label var R_civil "Puntaje de respuesta institucional civil"

label var R_privada "Puntaje de respuesta institucional privada"


//VULNERABILIZADOS

*antes
gen antes = 1 if a_4 ==1
replace antes = 2 if a_4 ==2
replace antes = 3 if a_4 ==3 | a_4 == 4 | a_4 == 5 | a_4 == 6 | a_4 == 7 | a_4 == 8| a_4 == 9

label var antes "antes de la pandemia"
label define antes 1 "Ocupado" 2 "Desocupado" 3 "Inactivo" 
label values antes antes

*actual o durante la pandemia

gen durante = 1 if a_7 ==1
replace durante = 2 if a_7 ==2
replace durante = 3 if a_7 ==3 | a_7 == 4 | a_7 == 5 | a_7 == 6 | a_7 == 7 | a_7 == 8| a_7 == 9


label var durante "durante la pandemia"
label define durante 1 "Ocupado" 2 "Desocupado" 3 "Inactivo" 
label values durante durante

*vulnerabilizados

gen aux1 = 1 if antes==1 & (durante==2 |  durante==3)
gen aux2 = 1 if antes==2 & (durante==3)
gen aux3 = 1 if antes==3 & (durante==2) 

gen vulnerabilizados = (aux1==1 | aux2==1 | aux3==1)


