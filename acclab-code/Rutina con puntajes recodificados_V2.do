/******************************************************************************
 * CREACIÓN Y ANÁLISIS DE ÍNDICES DE CAPITAL SOCIAL
 * AccLabPY, PNUD Paraguay, Mayo 2021
 * (accel.labs.pry@undp.org)
 * 
 * Claudia Montanía
 * Cristhian Parra
 * Gustavo Setrinig
 * Mónica Ríos
 *
 ******************************************************************************/

cd "../data"
use "database_final.dta"
// cd "C:\Users\DELL\United Nations Development Programme\AccLab PNUD Paraguay - Documentos\Projects\Capital Social\07 Data Analysis\Databases"
// use "C:\Users\DELL\United Nations Development Programme\AccLab PNUD Paraguay - Documentos\Projects\Capital Social\07 Data Analysis\Databases\database_final"

/****************************************************************************** 
 * PUNTAJES DE CAPITAL SOCIAL   
 ******************************************************************************
 * 1) Puntaje de capital social filial (〖cs〗_filial=[0…30])
 *		a. 	Sumar 1 punto por cada SÍ a las preguntas B1 y B4 ([0…8]).
 *		b. 	Sumar 2 puntos por cada sí de respuesta a la pregunta B2 ([0…14]).
 *		c. 	Sumar puntos en base a la posición de la respuesta a B3 en relación 
 *			a los 3 cuartiles de la distribución de medidas reportadas a esta 
 *			pregunta, siguiendo la siguiente tabla guía ([0…8]): 
 *
 *			Valor = 0  -->	0 puntos
 *			Valor = Q1 -->	1
 *			Valor = Q2 -->	2
 *			Valor = Q3 -->	3
 *			Valor > Q3 -->	4
 * 
 * Todas las preguntas de este bloque se refieren a personas similares al 
 * encuestado
 ******************************************************************************/
 
local var b_1_1 b_1_2 b_1_3 b_1_4 b_1_5 b_1_6 b_1_7 	// Interacciones casuales 
local var b_2_1 b_2_2 b_2_3 b_2_4 b_2_5 b_2_6 b_2_7 	// Interacciones de confianza 
local var b_4											// Apoyo para ayudas 

// Los valores asignados a "No Responde" (99) Y "No" pasan a (6). 
foreach X in `var' {
	capture recode `X'(3=6)
	capture recode `X'(2=6)
	capture recode `X'(1=2)
	capture recode `X'(6=1)
	
}

// Auxiliares para cacular correlaciones entre elementos de este bloque
gen aux_cf1 = b_1_1+ b_1_2+ b_1_3+ b_1_4+ b_1_5+ b_1_6+ b_1_7 
gen aux_cf2 = (b_2_1+ b_2_2+ b_2_3+ b_2_4+ b_2_5+ b_2_6+ b_2_7)* 2
gen aux_cf4= b_4

// We are removing items b_3_1 and b_3_2 from the index given as they need to 
// to be further revised. 
/* 
replace b_3_1=. if b_3_1==0
xtile b3_1= b_3_1, nq(4)
replace b3_1= 0 if b3_1==.
replace b_3_2=. if b_3_2==0
xtile b3_2= b_3_2, nq(4)
replace b3_2= 0 if b3_2==.
replace b_3=. if b_3==0
g aux_cf3=b3_1+b3_2
*/

// Calculando quartiles para la distribución que resulta de las respuestas a B3
// que se trata de estimar el número aproximado de personas en la red, similares
// a uno. 
replace b_3=. if b_3==0
xtile b3_q= b_3, nq(4)
replace b3_q= 0 if b3_q==.

*Índice con sumas
*g cs_filial= aux_cf1+aux_cf2+aux_cf3    // cs Filial
g cs_filial= aux_cf1+aux_cf2+b3_q + aux_cf4		// cs Filial prueba con b_3

// Auxiliares para cacular correlaciones entre elementos de este bloque con PCA
pca b_1_1  b_1_2  b_1_3  b_1_4  b_1_5  b_1_6  b_1_7 
. screeplot
gen aux_cf1_pca= 0.3967*(b_1_1)+0.3684*(b_1_2)+0.4180*(b_1_3)+0.4391*(b_1_4)+0.3895*(b_1_5)+0.3144*(b_1_6)+0.2978*(b_1_7)
pca b_2_1 b_2_2 b_2_3 b_2_4 b_2_5 b_2_6 b_2_7
. screeplot
gen aux_cf2_pca = 0.3762*(b_2_1)+0.3715*(b_2_2)+0.3943*(b_2_3)+0.4013*(b_2_4)+0.4045*(b_2_5)+0.3589*(b_2_6)+0.3338*(b_2_7)

//Alpha de Cronbach//
*Generado a partir de puntajes asignados
*alpha aux_cf1 aux_cf2 aux_cf3, std item generate (cs_filial_alpha)
alpha aux_cf1 aux_cf2 b3_q aux_cf4, std item generate (cs_filial_alpha)
*Generado a partir de PCA
alpha aux_cf1_pca aux_cf1_pca b3_q aux_cf4

// Como el alpha del índice generado a partir de puntajes asignados tiene un valor mayor que el generado con pca, se utiliza el índice original

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
// Auxiliares para cacular correlaciones entre elementos de este bloque
gen aux_cc1 = b_5_1 + b_5_2 + b_5_3 + b_5_4 + b_5_5 + b_5_5_1 + b_5_6 + b_5_7 + b_5_7_1 

gen aux_cc2 = (b_6_1 + b_6_2 + b_6_3 + b_6_4 + b_6_5 + b_6_5_1 + b_6_6 + b_6_7 + b_6_7_1)*2 

gen aux_cc4= b_8        

/*replace b_7_1=. if b_7_1==0

xtile b7_1= b_7_1, nq(4)

replace b7_1= 0 if b7_1==.

replace b_7_2=. if b_7_2==0

xtile b7_2= b_7_2, nq(4)

replace b7_2= 0 if b7_2==.

g aux_cc3 = b7_1+b7_2*/

replace b_7=. if b_7==0

xtile b7_q= b_7, nq(4)

replace b7_q= 0 if b7_q==.

*índice con sumas

g cs_conectivo= aux_cc1+aux_cc2+aux_cc4+b7_q

// Auxiliares para cacular correlaciones entre elementos de este bloque con PCA
pca b_5_1  b_5_2  b_5_3  b_5_4  b_5_5  b_5_5_1 b_5_6  b_5_7  b_5_7_1 
. screeplot
gen aux_cc1_pca= 0.3230*(b_5_1)+0.3310*(b_5_2)+0.3210*(b_5_3)+0.2905*(b_5_4)+0.3475*(b_5_5)+0.3443*(b_5_5_1)+0.3527*(b_5_6)+0.3470*(b_5_7)+0.3384*(b_5_7_1 )

pca b_6_1 b_6_2  b_6_3  b_6_4  b_6_5  b_6_5_1  b_6_6  b_6_7  b_6_7_1
. screeplot
gen aux_cc2_pca = 0.3202*(b_6_1)+0.3234*(b_6_2)+0.3323*(b_6_3)+0.2904*(b_6_4)+ 0.3376*(b_6_5)+0.3371*( b_6_5_1)+0.3586*(b_6_6)+0.3540*(b_6_7)+0.3415*(b_6_7_1)  

//Alpha de Cronbach//
*Generado a partir de puntajes asignados
*alpha aux_cc1 aux_cc2 aux_cc3, std item generate (cs_conectivo_alpha)
alpha aux_cc1 aux_cc2 aux_cc4 b7_q, std item generate (cs_conectivo_alpha)
*Generado a partir de PCA
alpha aux_cc1_pca aux_cc2_pca aux_cc4 b7_q

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
// Auxiliares para cacular correlaciones entre elementos de este bloque
gen aux_cv1 = b_9

gen aux_cv2 = b_10 * 2
replace aux_cv2=0 if aux_cv2==.

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

gen aux_cv3 = b12_1+b12_2+b12_3+b12_4

gen aux_cv4 = b11_1+b11_2+b11_3+b11_4

*Índice con sumas

gen cs_vinculante = aux_cv1+aux_cv2+aux_cv3+aux_cv4

// Auxiliares para cacular correlaciones entre elementos de PCA
pca b12_1 b12_2 b12_3 b12_4
. screeplot
gen aux_cv3_pca= 0.5052*(b12_1)+0.5110*(b12_2)+0.5064*(b12_3)+0.4767*(b12_4)
pca  b11_1 b11_2 b11_3 b11_4
. screeplot
gen aux_cv4_pca= 0.5101*(b11_1)+0.5062*(b11_2)+0.5266*(b11_3)+0.4542*(b11_4)

*Alpha de Cronbach

*Alpha de Cronbach
*Generado a partir de puntajes asignados
alpha aux_cv1 aux_cv2 aux_cv3 aux_cv4, std item generate (cs_vinculante_alpha)
*Generado a partir de PCA
alpha aux_cv1 aux_cv2 aux_cv3_pca aux_cv4_pca

/*========================================================================================
 ÍNDICES DE CONFIANZA
   
==========================================================================================*/

//Recodificación de 99 (la escala es siempre positiva) La escala es de 1 a 5

local negativo c_1 c_2 c_4 c_5 c_8 c_11 c_12

foreach a in `negativo' { 
	replace `a' = 3 if `a'==99 
	
label drop `a'
	}

//Preguntas positivas

local positivo c_3 c_6 c_7 c_9 c_10

foreach a in `positivo' {
	replace `a' = 3 if `a'==99 
	
label drop `a'
	}

**índice de confianza interpersonal con suma directa [3,..15]**

gen conf_interpersonal= c_1+c_2+c_3

*Alpha de Cronbach

alpha c_1 c_2 c_3, std item generate (conf_interpersonal_alpha1)
alpha c_1 c_2 c_3, std asis item generate (conf_interpersonal_alpha2)

**Índice de confianza institucional sumas [9,..45]**

gen conf_institucional= c_4+c_5+c_6+c_7+c_8+c_9+c_10+c_11+c_12

*Alpha de Cronbach

alpha c_4 c_5 c_6 c_7 c_8 c_9 c_10 c_11 c_12, std item generate (conf_inst_alpha1)
alpha c_4 c_5 c_6 c_7 c_8 c_9 c_10 c_11 c_12, std asis item generate (conf_inst_alpha2)

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

*gen aux1_v= d_1_1+d_1_2+d_1_3+d_1_4+d_1_5
pca d_1_1 d_1_2 d_1_3 d_1_4 d_1_5
. screeplot
gen aux_pca= 0.4291*(d_1_1)+0.3105*(d_1_2)+0.4649*(d_1_3)+0.4951*(d_1_4)+0.5081*(d_1_5)

*D2
replace d_2 = 0 if d_2 ==1
replace d_2 = 0 if d_2 ==2
replace d_2 = 1 if d_2 ==3
replace d_2 = 1 if d_2 ==4
replace d_2 = 2 if d_2 ==5
replace d_2 = 3 if d_2 ==6
replace d_2 = 4 if d_2 ==7
replace d_2 = 4 if d_2 ==8
replace d_2 = 5 if d_2 ==9
replace d_2 = 6 if d_2 ==10
replace d_2 = 6 if d_2 ==11
replace d_2 = 0 if d_2 ==12
label drop d_2

*D3
replace d_3 =0 if d_3==1
replace d_3 =2 if d_3==2
replace d_3 =2 if d_3==3
replace d_3 =3 if d_3==4
replace d_3 =2 if d_3==5
replace d_3 =1 if d_3==6
replace d_3 =2 if d_3==7
label drop d_3


*A7
replace a_7=0 if a_7==1
replace a_7=3 if a_7==2
replace a_7=2 if a_7==3
replace a_7=1 if a_7==4
replace a_7=4 if a_7==5
replace a_7=5 if a_7==6
replace a_7=2 if a_7==7
replace a_7=2 if a_7==8
replace a_7=0 if a_7==9
label drop a_7

*indice con suma directa
gen vulnerabilidad1= aux_pca+d_2+d_3+a_7
gen vulnerabilidad_galeano_monti=aux_pca+d_2+d_3

*Alpha de Cronbach

alpha aux_pca d_2 d_3 a_7, std item generate (vulnerabilidad1_alpha)

*Alpha de Cronbach

alpha aux_pca d_2 d_3, std item generate (galeano_monti_alpha)


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

*indice con suma directa
gen ac_comunitaria = e_1 + aux_colect1

*Alpha de Cronbach

alpha aux_colect1 e_1, std item generate (ac_comunitaria_alpha)


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

*indice con suma directa
gen ac_activos = aux_acc_activos1 + aux_acc_activos2

*Alpha de Cronbach

alpha f_2 f_3 f_4 f_5 f_6 f_9 f_13 f_14 f_15, std item generate (ac_activos_alpha)

/*		Puntaje de acción colectiva para demandas cívicas (〖ac〗_demanda=[0…3])

a)	Sumar 1 punto por cada sí de respuesta a las preguntas E3 ([0,1])

b)	Sumar 2 puntos por cada sí de respuesta a las preguntas E4 ([0,2])

c)	En el caso de las respuestas bajo E5 y E6, codificar y presentar su frecuencia unificada. */


capture recode e_3 (3=0)
capture recode e_3 (2=0)

capture recode e_4 (3=0)
capture recode e_4 (2=0)

g aux_demanda1 = e_4 *2

*indice con suma directa
gen ac_demanda= e_3 + aux_demanda1

*Alpha de Cronbach

alpha aux_demanda1 e_3, std item generate (ac_demanda_alpha)

	
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

*indice con suma directa
g commons= aux_activos1+aux_activos2+aux_activos3


/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)*/ 


pwcorr aux_activos1 aux_activos2 aux_activos3, sig star(.05) obs

*Alpha de Cronbach

alpha f_1 f_7_1 f_7_2 f_7_3 f_7_4 f_7_5 f_8 f_10 f_12_r f_16 f_17 f_18 f_11 f_19, std item generate (commons_alpha)

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


*Índices con sumas directas
g R_publica= e_7+e_7_1+e_8

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: e_7 e_7_1 e_8 (construido a partir del árbol de variables)*/

pwcorr e_7 e_7_1 e_8, sig star(.05) obs

*Alpha de Cronbach

alpha e_7 e_7_1 e_8, std item generate (r_publica_alpha)

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


/*========================================================================================
 ÍNDICE DE VULNERABILIDAD PRODUCIDA POR LA PANDEMIA
==========================================================================================*/
*Este índice es la diferencia entre A7 y A4
*A4
replace a_4=0 if a_4==1
replace a_4=3 if a_4==2
replace a_4=2 if a_4==3
replace a_4=1 if a_4==4
replace a_4=4 if a_4==5
replace a_4=5 if a_4==6
replace a_4=2 if a_4==7
replace a_4=2 if a_4==8
replace a_4=0 if a_4==9
label drop a_4

*Índice
gen vulnerabilizados= a_4-a_7

/*========================================================================================
 CORRELACIONES
==========================================================================================*/
*asdoc pwcorr cs_filial cs_conectivo cs_vinculante conf_interpersonal conf_institucional vulnerabilidad1 ac_comunitaria ac_activos ac_demanda commons R_publica R_privada R_civil vulnerabilizados [w=fex], sig star(.05) obs

*asdoc pwcorr cs_filial_alpha cs_conectivo_alpha cs_vinculante_alpha conf_interpersonal_alpha2 conf_inst_alpha2 vulnerabilidad1_alpha ac_comunitaria_alpha ac_activos_alpha ac_demanda_alpha commons_alpha r_publica_alpha R_privada R_civil vulnerabilizados [w=fex], sig star(.05) obs

*asdoc pwcorr cs_filial cs_conectivo cs_vinculante conf_interpersonal conf_institucional vulnerabilidad1 ac_comunitaria ac_activos ac_demanda commons R_publica R_privada R_civil [w=fex], sig star(.05) obs

*asdoc pwcorr cs_filial_alpha cs_conectivo_alpha cs_vinculante_alpha conf_interpersonal_alpha2 conf_inst_alpha2 vulnerabilidad1_alpha ac_comunitaria_alpha ac_activos_alpha ac_demanda_alpha commons_alpha r_publica_alpha R_privada R_civil [w=fex], sig star(.05) obs


/*========================================================================================
 ESTADÍSTICAS DESCRIPTIVAS
==========================================================================================*/
*Sexo
tab a_1 [w=fex]

*Edad por sexo
sum a_2 if a_1==1 [w=fex]
sum a_2 if a_1==2 [w=fex]

*Capital social (índice sumas)
sum cs_filial cs_conectivo cs_vinculante [w=fex]
sum cs_filial cs_conectivo cs_vinculante if zona==1 [w=fex]
sum cs_filial cs_conectivo cs_vinculante if zona==2 [w=fex]

*Confianza (índice sumas)
sum conf_interpersonal conf_institucional [w=fex]
sum conf_interpersonal conf_institucional if zona==1 [w=fex]
sum conf_interpersonal conf_institucional if zona==2 [w=fex]


*Vulnerabilidad Galeano Monti (índice sumas)
sum vulnerabilidad_galeano_monti [w=fex]
sum vulnerabilidad_galeano_monti if zona==1 [w=fex]
sum vulnerabilidad_galeano_monti if zona==2 [w=fex]


*Vulnerabilidad socioeconómica 
sum a_7 [w=fex]
sum a_7 if zona==1 [w=fex]
sum a_7 if zona==2 [w=fex]
sum a_7 if a_1==1 [w=fex]
sum a_7 if a_1==2 [w=fex]

*Vulnerabilidad total (índice sumas)
sum vulnerabilidad1 [w=fex]
sum vulnerabilidad1 if zona==1 [w=fex]
sum vulnerabilidad1  if zona==2 [w=fex]


*Índice de vulnerabilizados por la pandemia: si es negativo empeoró la situación (a4-a7)
sum vulnerabilizados [w=fex]
sum vulnerabilizados if zona==1 [w=fex]
sum vulnerabilizados if zona==2 [w=fex]


*Respuesta pública (índice sumas)
sum R_publica [w=fex]
sum R_publica if zona==1 [w=fex]
sum R_publica if zona==2 [w=fex]

*Respuesta privada 
sum R_privada [w=fex]
sum R_privada if zona==1 [w=fex]
sum R_privada if zona==2 [w=fex]

*Respuesta civil 
sum R_civil [w=fex]
sum R_civil if zona==1 [w=fex]
sum R_civil if zona==2 [w=fex]

*Commons (índice sumas)
sum commons [w=fex]
sum commons if zona==1 [w=fex]
sum commons if zona==2 [w=fex]

*Acción comunitaria (índice sumas)
sum ac_comunitaria ac_demanda ac_activos [w=fex]
sum ac_comunitaria ac_demanda ac_activos if zona==1 [w=fex]
sum ac_comunitaria ac_demanda ac_activos if zona==2 [w=fex]


/*========================================================================================
 Ttest para saber si son significativas las diferencias
==========================================================================================*/
ttest cs_filial, by(zona)
ttest cs_conectivo, by(zona)
ttest cs_vinculante, by(zona)
ttest conf_interpersonal, by(zona)
ttest conf_institucional, by(zona)
ttest ac_comunitaria, by(zona)
ttest ac_activos, by(zona)
ttest ac_demanda, by(zona)
ttest commons, by(zona)
ttest R_publica, by(zona)
ttest R_civil, by(zona)
ttest R_privada, by(zona)
ttest vulnerabilidad1, by(zona)

/*========================================================================================
							Generación de logaritmos de x+1 
==========================================================================================*/
*Se realiza esto debido a que los índices van de [0...x], lo cual dificulta la logaritmización

gen ac_demandalog = log(ac_demanda+1)
gen ac_comunitarialog= log(ac_comunitaria+1)
gen ac_activoslog= log(ac_activos+1)
gen cs_filialog= log(cs_filial+1)
gen cs_conectivolog= log(cs_conectivo+1)
gen cs_vinculantelog= log(cs_vinculante+1)
gen conf_interpersonalog = log(conf_interpersonal+1)
gen conf_institucionalog = log(conf_institucional+1)
gen R_publicalog = log(R_publica+1)
gen vulnerabilidadlog= log(vulnerabilidad1+1)
gen commonslog= log(commons+1)

*Las variables de control no están logaritmizadas
gen rural= zona
replace rural=0 if zona==1
replace rural=1 if zona==2
gen mujeres=a_1
replace mujeres=0 if a_1==1
replace mujeres=1 if a_1==2
rename a_2 edad
rename a_3 educ
rename a_7 situ_ocup

cd "../results"

/*========================================================================================
				Determinantes de la acción colectiva para demandas cívicas
==========================================================================================*/
*Demandas cívicas y capital social
reg ac_demandalog cs_filialog cs_conectivolog cs_vinculantelog educ situ_ocup rural mujeres edad, robust
outreg2 using demandas_cs.doc, replace ctitle(Demandas cívicas)

*Demandas cívicas y confianza
reg ac_demandalog conf_interpersonalog conf_institucionalog educ situ_ocup rural mujeres edad, robust
outreg2 using demandas_confianza.doc, replace ctitle(Demandas cívicas)

/*========================================================================================
			Determinantes de la acción colectiva para acción comunitaria (autoayuda)
==========================================================================================*/
*Autoayuda y capital social
reg ac_comunitarialog cs_filialog cs_conectivolog cs_vinculantelog educ situ_ocup rural mujeres edad, robust
outreg2 using autoayuda_cs.doc, replace ctitle(Autoayuda)

*Autoayuda y confianza
reg ac_comunitarialog conf_interpersonalog conf_institucionalog educ situ_ocup rural mujeres edad, robust
outreg2 using autoayuda_confianza.doc, replace ctitle(Autoayuda)

/*========================================================================================
			Determinantes de la respuesta institucional pública
==========================================================================================*/
*Aquí no se incluye situación ocupacional porque está correlacionado con vulnerabilidad por construcción del índice de vulnerabilidad
reg R_publica vulnerabilidadlog ac_demandalog cs_vinculantelog educ rural mujeres edad, robust
outreg2 using rpublica_vulnerabilidad.doc, replace ctitle(R publica)

/*========================================================================================
			Determinantes de la vulnerabilidad
==========================================================================================*/
*Vulnerabilidad y autoayuda
reg vulnerabilidadlog ac_comunitarialog educ rural mujeres edad, robust
outreg2 using vulnerabilidad_autoayuda.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y demandas cívicas
reg vulnerabilidadlog ac_demandalog educ rural mujeres edad, robust
outreg2 using vulnerabilidad_demandas.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y acceso a activos colectivos
reg vulnerabilidadlog commonslog educ rural mujeres edad, robust
outreg2 using vulerabilidad_commons.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y participación comunitaria relacionada a activos colectivos
reg vulnerabilidadlog ac_activoslog educ rural mujeres edad, robust
outreg2 using vulnerabilidad_accommons.doc, replace ctitle(Vulnerabilidad)


/*========================================================================================
			Determinantes del acceso a activos colectivos
==========================================================================================*/
*Commons y capital social
reg commons cs_filial cs_conectivo cs_vinculante educ situ_ocup rural mujeres edad, robust
outreg2 using commons_cs.doc, replace ctitle(Commons)

*Commons y confianza
reg commons conf_interpersonal conf_institucional educ situ_ocup rural mujeres edad, robust
outreg2 using commons_confianza.doc, replace ctitle(Commons)


/*========================================================================================
			Determinantes de la participación comunitaria asociada a activos colectivos
==========================================================================================*/
*Participación y capital social
reg ac_activos cs_filial cs_conectivo cs_vinculante educ situ_ocup rural mujeres edad, robust
outreg2 using participacion_cs.doc, replace ctitle(Participación asociada a activos colectivos)

*Participación y confianza
reg ac_activos conf_interpersonal conf_institucional educ situ_ocup rural mujeres edad, robust
outreg2 using participacion_confianza.doc, replace ctitle(Participación asociada a activos colectivos)

/*========================================================================================
			Otros modelos
==========================================================================================*/
*Acceso a activos colectivos en función a la vulnerabilidad
reg commons vulnerabilidad1 educ rural mujeres edad, robust
outreg2 using commons_vulnerabilidad.doc, replace ctitle(Commons)

*Capital social en función a la vunerabilidad
reg cs_filial vulnerabilidad1 educ rural mujeres edad, robust
outreg2 using commons_filial.doc, replace ctitle(Cs_filial)

reg cs_conectivo vulnerabilidad1 educ rural mujeres edad, robust
outreg2 using commons_conectivo.doc, replace ctitle(Cs_conectivo)

reg cs_vinculante vulnerabilidad1 educ rural mujeres edad, robust
outreg2 using commons_vinculante.doc, replace ctitle(Cs_vinculante)

cd "../results-ama"

/*========================================================================================
						PRUEBA 1: con AMA, urbano fuera de AMA y rural
==========================================================================================*/
gen region= departamento
replace region=0 
replace region=1 if departamento==0  & zona==1
replace region=1 if departamento==11  & zona==1
replace region=2 if departamento==1 & zona==1
replace region=2 if departamento==2 & zona==1
replace region=2 if departamento==3 & zona==1
replace region=2 if departamento==6 & zona==1
replace region=2 if departamento==7 & zona==1
replace region=2 if departamento==10 & zona==1
replace region=2 if departamento==12 & zona==1
replace region=2 if departamento==13 & zona==1

gen ama_urb = departamento
replace ama_urb=0
replace ama_urb=1 if departamento==0  & zona==1
replace ama_urb=1 if departamento==11  & zona==1

gen resto_urb = departamento
replace resto_urb=0
replace resto_urb=1 if departamento==1 & zona==1
replace resto_urb=1 if departamento==2 & zona==1
replace resto_urb=1 if departamento==3 & zona==1
replace resto_urb=1 if departamento==6 & zona==1
replace resto_urb=1 if departamento==7 & zona==1
replace resto_urb=1 if departamento==10 & zona==1
replace resto_urb=1 if departamento==12 & zona==1
replace resto_urb=1 if departamento==13 & zona==1


/*========================================================================================
				Determinantes de la acción colectiva para demandas cívicas
==========================================================================================*/
*Demandas cívicas y capital social
reg ac_demandalog cs_filialog cs_conectivolog cs_vinculantelog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using demandas_cs.doc, replace ctitle(Demandas cívicas)

*Demandas cívicas y confianza
reg ac_demandalog conf_interpersonalog conf_institucionalog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using demandas_confianza.doc, replace ctitle(Demandas cívicas)

/*========================================================================================
			Determinantes de la acción colectiva para acción comunitaria (autoayuda)
==========================================================================================*/
*Autoayuda y capital social
reg ac_comunitarialog cs_filialog cs_conectivolog cs_vinculantelog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using autoayuda_cs.doc, replace ctitle(Autoayuda)

*Autoayuda y confianza
reg ac_comunitarialog conf_interpersonalog conf_institucionalog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using autoayuda_confianza.doc, replace ctitle(Autoayuda)

/*========================================================================================
			Determinantes de la respuesta institucional pública
==========================================================================================*/
*Aquí no se incluye situación ocupacional porque está correlacionado con vulnerabilidad por construcción del índice de vulnerabilidad
reg R_publica vulnerabilidadlog ac_demandalog cs_vinculantelog educ rural resto_urb ama_urb mujeres edad, robust
outreg2 using rpublica_vulnerabilidad.doc, replace ctitle(R publica)

/*========================================================================================
			Determinantes de la vulnerabilidad
==========================================================================================*/
*Vulnerabilidad y autoayuda
reg vulnerabilidadlog ac_comunitarialog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using vulnerabilidad_autoayuda.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y demandas cívicas
reg vulnerabilidadlog ac_demandalog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using vulnerabilidad_demandas.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y acceso a activos colectivos
reg vulnerabilidadlog commonslog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using vulerabilidad_commons.doc, replace ctitle(Vulnerabilidad)

*Vulnerabilidad y participación comunitaria relacionada a activos colectivos
reg vulnerabilidadlog ac_activoslog educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using vulnerabilidad_accommons.doc, replace ctitle(Vulnerabilidad)


/*========================================================================================
			Determinantes del acceso a activos colectivos
==========================================================================================*/
*Commons y capital social
reg commons cs_filial cs_vinculante cs_conectivo educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_cs.doc, replace ctitle(Commons)

reg commons conf_interpersonal conf_institucional educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_confianza.doc, replace ctitle(Commons)

/*========================================================================================
			Determinantes de la participación comunitaria asociada a activos colectivos
==========================================================================================*/
*Participación y capital social
reg ac_activos cs_filial cs_vinculante cs_conectivo educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using participacion_cs.doc, replace ctitle(Participación asociada a activos colectivos)

*Participación y capital social
reg ac_activos conf_interpersonal conf_institucional educ situ_ocup rural resto_urb ama_urb mujeres edad, robust
outreg2 using participacion_confianza.doc, replace ctitle(Participación asociada a activos colectivos)

/*========================================================================================
			Otros modelos
==========================================================================================*/
*Acceso a activos colectivos en función a la vulnerabilidad
reg commons vulnerabilidad1 educ rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_vulnerabilidad.doc, replace ctitle(Commons)

*Capital social en función a la vunerabilidad
reg cs_filial vulnerabilidad1 educ rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_filial.doc, replace ctitle(Cs_filial)

reg cs_conectivo vulnerabilidad1 educ rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_conectivo.doc, replace ctitle(Cs_conectivo)

reg cs_vinculante vulnerabilidad1 educ rural resto_urb ama_urb mujeres edad, robust
outreg2 using commons_vinculante.doc, replace ctitle(Cs_conectivo)




