**************Creación de índices agregados Capital Social**************

use "C:\Users\DELL\Dropbox\Claudia y Alberto\PNUD\Social ties\database_final_normalizada.dta"

***Índice de capital social***

*Primer paso: estandarizar las las variables que conformarían el índice: en el caso de social ties ya normalizamos

*Segundo paso: hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

*En este caso, el índice de capital social lo conforman el índice de capital social filial (cs_filial), el índice de capital social conectivo (cs_conectivo) y el índice de capital social vinculante (cs_vinculante)

*Estandarizado
pwcorr zcs_filial zcs_conectivo zcs_vinculante, sig star(.05) obs

*Se puede detectar que todas las variables están correlacionadas entre sí dos a dos, además de que estas correlaciones son significativas (coeficiente y p-value)

*Tercer paso: Dado que existe correlación significativa, se procede a calcular el Alpha de Cronbach para  índices que formarían el índice de capital social. Usamos la opción de estandarizar para obtener una escala estandarizada.

*Estandarizado
alpha zcs_filial zcs_conectivo zcs_vinculante, std item generate (z_csocial)

*El alpha de Crombach obtenido es 0.6320, hay que decidir

**índice de confianza**

*Primer paso: estandarizar las las variables que conformarían el índice: en el caso de social ties ya normalizamos

*Segundo paso: hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

*En este caso, el índice de confianza lo conforman el índice de confianza interpersonal (i_conf), el índice de confianza institucional (conf_inst) 

*Estandarizado

pwcorr zconf_interpersonal zconf_institucional, sig star(.05) obs

*Se puede detectar que todas las variables están correlacionadas entre sí dos a dos, además de que estas correlaciones son significativas (coeficiente y p-value)

*Tercer paso: Dado que existe correlación significativa, se procede a calcular el Alpha de Cronbach para los índices que formarían el índice de confianza. Usamos la opción de estandarizar para obtener una escala estandarizada

*Estandarizado

alpha zconf_interpersonal zconf_institucional, std item generate (z_conf)

*El alpha de Crombach obtenido es bajo, por lo tanto no podemos usar este índice generado

**índice de acción colectiva**

*Primer paso: estandarizar las las variables que conformarían el índice: en el caso de social ties ya normalizamos

*Segundo paso: hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

*En este caso, el índice de acción colectiva conforman: acción colectiva para acción comunitaria, acción comunitaria asociada a activos colectivos y acción colectiva para demandas cívicas

*Estandarizado
pwcorr zac_comunitaria zac_comunitaria_colectiva zac_demanda, sig star(.05) obs

*Se puede detectar un nivel medio de correlación bivariada  

*Tercer paso: Ahora veremos el cálculo del Alpha de Cronbach

*Estandarizado
alpha zac_comunitaria zac_comunitaria_colectiva zac_demanda, std item generate (z_acolectiva)

*El alpha de Crombach obtenido es bajo, por lo tanto no podemos usar este índice generado

**índice de respuesta institucional**
*Primer paso: estandarizar las las variables que conformarían el índice: en el caso de social ties ya normalizamos

*Segundo paso: hacer una matriz de correlación entre todas las variables que conforman dicho índice (Pearson Chi-square test)

*En este caso, el índice de confianza lo conforman el índice de respuesta civil, pública y privada

*Estandarizado

pwcorr zR_civil zR_publica zR_privada, sig star(.05) obs

*Se puede detectar bajo nivel de correlación (coeficiente y p-value)

*Tercer paso:Probar igual el Alpha de Cronbach

*Estandarizado

alpha zR_civil zR_publica zR_privada, std item generate (zR_inst)

*El alpha de Crombach obtenido es muy bajo, por lo tanto no podemos usar este índice generado
