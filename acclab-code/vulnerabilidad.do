use "C:\Users\DELL\Dropbox\Claudia y Alberto\PNUD\Social ties\database_final.dta"

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

/*Hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

Preguntas a considerar: aux1 d_2 d_3 (construido a partir del árbol de variables)*/

pwcorr aux_pca d_2 d_3 a_7, sig star(.05) obs

*Alpha de Cronbach

alpha aux_pca d_2 d_3 a_7, std item generate (vulnerabilidad1_alpha)