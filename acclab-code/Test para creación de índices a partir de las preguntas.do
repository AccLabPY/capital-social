**************Creación de índices agregados Capital Social**************

use "C:\Users\DELL\Dropbox\Claudia y Alberto\PNUD\Social ties\database_final.dta"

/*========================================================================================
 ÍNDICES DE CAPITAL SOCIAL
   
==========================================================================================*/


/* 1) Puntaje de capital social filial (〖cs〗_filial=[0…30])

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

gen aux_cf1 = b_1_1+ b_1_2+ b_1_3+ b_1_4+ b_1_5+ b_1_6+ b_1_7 + b_4

gen aux_cf2 = (b_2_1+ b_2_2+ b_2_3+ b_2_4+ b_2_5+ b_2_6+ b_2_7)
replace b_3_1=. if b_3_1==0

xtile b3_1= b_3_1, nq(4)

replace b3_1= 0 if b3_1==.

replace b_3_2=. if b_3_2==0

xtile b3_2= b_3_2, nq(4)

replace b3_2= 0 if b3_2==.

g aux_cf3 = b3_1+b3_2

g cs_filial= aux_cf1+aux_cf2+aux_cf3    // cs Filial

*Estandarizar

egen zaux_cf1= std (aux_cf1)
egen zaux_cf2= std (aux_cf2)
egen zaux_cf3= std (aux_cf3)


/* Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: aux_cf1, aux_cf2, aux_cf3 (construido a partir del árbol de variables)*/

pwcorr zaux_cf1 zaux_cf2 zaux_cf3, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_cf1 zaux_cf2 zaux_cf3, std item generate (cs_filial_alpha)


/* 2) Puntaje de capital social conectivo (〖cs〗_conectivo=[0…36]) 

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

gen aux_cc1 = b_5_1 + b_5_2 + b_5_3 + b_5_4 + b_5_5 + b_5_5_1 + b_5_6 + b_5_7 + b_5_7_1 + b_8

gen aux_cc2 = (b_6_1 + b_6_2 + b_6_3 + b_6_4 + b_6_5 + b_6_5_1 + b_6_6 + b_6_7 + b_6_7_1) 

replace b_7_1=. if b_7_1==0

xtile b7_1= b_7_1, nq(4)

replace b7_1= 0 if b7_1==.

replace b_7_2=. if b_7_2==0

xtile b7_2= b_7_2, nq(4)

replace b7_2= 0 if b7_2==.

g aux_cc3 = b7_1+b7_2

g cs_conectivo= aux_cc1+aux_cc2+aux_cc3

*Estandarizar

egen zaux_cc1= std (aux_cc1)
egen zaux_cc2= std (aux_cc2)
egen zaux_cc3= std (aux_cc3)


/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

*Preguntas a considerar: aux_cc1, aux_cc2, aux_cc3 (construido a partir del árbol de variables)*/

pwcorr zaux_cc1 zaux_cc2 zaux_cc3, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_cc1 zaux_cc2 zaux_cc3, std item generate (cs_conectivo_alpha)

/* 3) 	Puntaje de capital social vinculante (〖cs〗_vinculante=[0…27]) 

Observación: El rango debe ser (〖cs〗_vinculante=[0…51])

a) 	Sumar 1 punto por cada sí de respuesta a las preguntas B9 ([0,1]). 

b) 	Sumar 2 puntos por cada sí de respuesta a la pregunta B10 ([0,2]).

c) 	Sumar puntos en base a la posición de las respuestas a las opciones de la pregunta B12 (B12.1, B12.2, B12.3, B12.3) en relación con los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, siguiendo la siguiente tabla guía ([0…16]): 

Observación: El rango debe ser ([0…32]): 

d) 	Sumar puntos en base a la posición de las respuestas a las opciones de la pregunta B11 (B11.1, B11.2, B11.3, B11.3) en relación con los 3 cuartiles de la distribución de medidas reportadas a esta pregunta, siguiendo la siguiente tabla guía ([0…8]): 



*/

local var b_9 b_10

foreach X in `var' {
	capture recode `X'(3=0)
	capture recode `X'(2=0)
}

gen aux_cv1 = b_9

gen aux_cv2 = b_10 
replace aux_cv2=0 if aux_cv2==.


replace b_12_1= . if b_12_1==0
xtile b12_1= b_12_1, nq(4)
replace b12_1= 0 if b12_1==.
replace b12_1=b12_1


replace b_12_2= . if b_12_2==0
xtile b12_2= b_12_2, nq(4)
replace b12_2= 0 if b12_2==.
replace b12_2=b12_2

replace b_12_3= . if b_12_3==0
xtile b12_3= b_12_3, nq(4)
replace b12_3= 0 if b12_3==.
replace b12_3=b12_3

replace b_12_4= . if b_12_4==0
xtile b12_4= b_12_4, nq(4)
replace b12_4= 0 if b12_4==.
replace b12_4=b12_4


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

gen aux_cv3 = b12_1+b12_2+b12_3+b12_4

gen aux_cv4 = b11_1+b11_2+b11_3+b11_4

gen cs_vinculante = aux_cv1+aux_cv2+aux_cv3+aux_cv4

*Estandarizar

egen zaux_cv1= std (aux_cv1)
egen zaux_cv2= std (aux_cv2)
egen zaux_cv3= std (aux_cv3)


/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: aux_cv1, aux_cv2, aux_cv3 (construido a partir del árbol de variables)*/

pwcorr zaux_cv1 zaux_cv2 zaux_cv3, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_cv1 zaux_cv2 zaux_cv3, std item generate (cs_vinculante_alpha)

/*========================================================================================
 ÍNDICES DE CONFIANZA
   
==========================================================================================*/

/* 	Para las preguntas de confianza, se traduce la escala en una de las siguientes opciones, dependiendo de si la pregunta está en sentido negativo o positivo

	Puntaje confianza interpersonal (〖conf〗_interpersonal=[-6…6]) 

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

**Confianza interpersonal**

gen conf_interpersonal= c_1+c_2+c_3

*Estandarizar

egen zc_1= std (c_1)
egen zc_2= std (c_1)
egen zc_3= std (c_3)


/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: c_1 c_2 c_3 (construido a partir del árbol de variables)*/

pwcorr zc_1 zc_2 zc_3, sig star(.05) obs

*Alpha de Cronbach

alpha zc_1 zc_2 zc_3, std item generate (conf_interpersonal_alpha)

**Confianza institucional**

gen conf_institucional= c_4+c_5+c_6+c_7+c_8+c_9+c_10+c_11+c_12

*Estandarizar

egen zc_4= std (c_4)
egen zc_5= std (c_5)
egen zc_6= std (c_6)
egen zc_7= std (c_7)
egen zc_8= std (c_8)
egen zc_9= std (c_9)
egen zc_10= std (c_10)
egen zc_11= std (c_11)
egen zc_12= std (c_12)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: c_4, c_5, c_6, c_7, c_8, c_9, c_10, c_11, c_12 (construido a partir del árbol de variables)*/

pwcorr zc_4 zc_5 zc_6 zc_7 zc_8 zc_9 zc_10 zc_11 zc_12, sig star(.05) obs

*Alpha de Cronbach

alpha zc_4 zc_5 zc_6 zc_7 zc_8 zc_9 zc_10 zc_11 zc_12, std item generate (conf_inst_alpha)

/*========================================================================================
 ÍNDICES DE VULNERABILIDAD
==========================================================================================*/

/*Puntajes de Vulnerabilidad Económica  l (SON 2 VARIABLES)

a) 	Puntaje parcial de vulnerabilidad económica según Galeano (〖vulnerabilidad〗_1=[0…13]): agregar las preguntas D1, D2 y D3 según los siguientes criterios, para calcular parcialmente la vulnerabilidad económica según parte del cuestionario propuesta por Galeano en su libro Territorios de Exclusión Social. 

b)	Sumar 1 punto por cada respuesta Sí a la pregunta D1 ([0…5]).

c)	Sumar puntos por cada opción marcada en las preguntas D2 ([0…5]) y D3 ([0…3]). según la siguiente escala de puntos para cada etiqueta. 

 */

local vulnerabilidad d_1_1 d_1_2 d_1_3 d_1_4 d_1_5

foreach b in `vulnerabilidad' {

	capture recode `b'(3=0)
	capture recode `b'(2=0)
}

*Comentario Claudia: Creo que está mal generada la variable aux1. aux 1 tiene 273 valores únicamente que son diferentes de 0, y para los 273 existentes tiene valor 1


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

gen vulnerabilidad1= aux1+d_2+d_3

*Estandarizar

egen zaux1= std (aux1)
egen zd2= std (d_2)
egen zd3= std (d_3)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: aux1 d_2 d_3 (construido a partir del árbol de variables)*/

pwcorr aux1 d_2 d_3, sig star(.05) obs

*Alpha de Cronbach

alpha aux1 d_2 d_3, std item generate (vulnerabilidad1_alpha)


/*========================================================================================
 ÍNDICES DE ACCION COLECTIVA
==========================================================================================*/

/* 3.Puntajes de Acción Comunitaria para acción colectiva l (SON 3 VARIABLES)

a) Puntaje de acción colectiva para acción comunitaria (〖ac〗_comunitaria=[0…3])

	1- Sumar 1 punto por cada sí de respuesta a las preguntas E1 ([0,1])

	2- Sumar 2 puntos por cada sí de respuesta a las preguntas E2 ([0,2]) */
	

	capture recode e_1 (3=0)
	capture recode e_1 (2=0)

	capture recode e_2 (3=0)
	capture recode e_2 (2=0)

gen aux_colect1 = e_2 * 2

gen ac_comunitaria = e_1 + aux_colect1

*Estandarizar

egen zaux_colect1= std (aux_colect1)
egen ze1= std (e_1)


/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: aux_colect1 e_1 (construido a partir del árbol de variables)*/

pwcorr zaux_colect1 e_1, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_colect1 e_1, std item generate (ac_comunitaria_colectiva_alpha)



/*	Puntaje de acción colectiva para acción comunitaria asociada a activos colectivos (〖ac〗_(comunitaria_colectiva)=[0…18])

a)	Sumar 1 punto por cada sí de respuesta a las preguntas F2, F4, F5, F9, F13, F14 ([0…6]).  

b)	Sumar puntos según la siguiente tabla de valores para las respuestas a las preguntas F3, F6, F15 ([0…12]) */

local colectiva f_2 f_4 f_5 f_9 f_13 f_14

foreach c in `colectiva' {

	capture recode `c'(3=0)
	capture recode `c'(2=0)
	capture recode `c'(.=0)
}

gen aux_acc_activos1 = f_2 +f_4+f_5 +f_9 +f_13 +f_14

local tiempo f_3 f_6 f_15

foreach d in `tiempo' {
	
	replace `d' = 0 if `d'==99 
	replace `d' = 0 if `d'==.
	label drop `d'
	}
	
g aux_acc_activos2 = f_3+f_6+ f_15

gen ac_comunitaria_colectiva = aux_acc_activos1 + aux_acc_activos2

*Estandarizar

egen zaux_acc_activos1= std (aux_acc_activos1)
egen zaux_acc_activos2= std (aux_acc_activos2)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: acc_activos_1 acc_activos_2 (construido a partir del árbol de variables)*/

pwcorr zaux_acc_activos1 zaux_acc_activos2, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_acc_activos1 zaux_acc_activos2, std item generate (ac_activos_alpha)

/*		Puntaje de acción colectiva para demandas cívicas (〖ac〗_demanda=[0…3])

a)	Sumar 1 punto por cada sí de respuesta a las preguntas E3 ([0,1])

b)	Sumar 2 puntos por cada sí de respuesta a las preguntas E4 ([0,2])

c)	En el caso de las respuestas bajo E5 y E6, codificar y presentar su frecuencia unificada. */


capture recode e_3 (3=0)
capture recode e_3 (2=0)

capture recode e_4 (3=0)
capture recode e_4 (2=0)

g aux_demanda1 = e_4 *2
	
gen ac_demanda= e_3 + aux_demanda1

*Estandarizar

egen zaux_demanda1= std (aux_demanda1)
egen ze_3= std (e_3)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: demanda_1 demanda_2 (construido a partir del árbol de variables)*/

pwcorr zaux_demanda1 ze_3, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_demanda1 ze_3, std item generate (ac_demanda_alpha)

	
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

gen aux_activos1= f_1+ f_7_1+ f_7_2+ f_7_3+ f_7_4+ f_7_5+ f_8+ f_10+ f_12_r + f_16+f_17 +f_18
replace aux_activos1 = 0 if aux_activos1==.
	
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

gen aux_activos2 = f_11 if f_10==1
replace aux_activos2=0 if aux_activos2==.
gen aux_activos3= f_19 if f_18 ==1
replace aux_activos3=0 if aux_activos3==.

g commons= aux_activos1+aux_activos2+aux_activos3

*Estandarizar

egen zaux_activos1= std (aux_activos1)
egen zaux_activos2= std (aux_activos2)
egen zaux_activos3= std (aux_activos3)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: activos_1 activos_2 (construido a partir del árbol de variables)*/

pwcorr zaux_activos1 zaux_activos2 zaux_activos3, sig star(.05) obs

*Alpha de Cronbach

alpha zaux_activos1 zaux_activos2 zaux_activos3, std item generate (activos_alpha)

/*========================================================================================
 ÍNDICES DE RESPUESTA INSTITUCIONAL
==========================================================================================*/

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

*Estandarizar

egen ze_7= std (e_7)
egen ze_7_1= std (e_7_1)
egen ze_8= std (e_8)

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: e_7 e_7_1 e_8 (construido a partir del árbol de variables)*/

pwcorr ze_7 ze_7_1 ze_8, sig star(.05) obs

*Alpha de Cronbach

alpha ze_7 ze_7_1 ze_8, std item generate (r_publica_alpha)