*Instalar complemento para exportar a word
ssc install asdoc

*Abrir archivo con datos normalizados porque esta versión contiene los datos diferenciados por zona urbana y rural
use "../data/database_final_normalizada.dta"

*Declarar ubicación del archivo que se creará
cd "results"

*Matriz de correlación total, con factor de expansión
asdoc pwcorr cs_filial cs_conectivo cs_vinculante conf_interpersonal conf_institucional vulnerabilidad1 ac_comunitaria ac_comunitaria_colectiva ac_demanda commons R_publica R_privada R_civil [w=fex], sig star(.05) obs

*Matriz de correlación urbana, con factor de expansión
asdoc pwcorr cs_filial_urb cs_conectivo_urb cs_vinculante_urb conf_interpersonal_urb conf_institucional_urb vulnerabilidad1_urb ac_comunitaria_urb ac_comunitaria_colectiva_urb ac_demanda_urb commons_urb R_publica_urb R_privada_urb R_civil_urb [w=fex], sig star(.05) obs


*Matriz de correlación rural, con factor de expansión
asdoc pwcorr cs_filial_rur cs_conectivo_rur cs_vinculante_rur conf_interpersonal_rur conf_institucional_rur vulnerabilidad1_rur ac_comunitaria_rur ac_comunitaria_colectiva_rur ac_demanda_rur commons_rur R_publica_rur R_privada_rur R_civil_rur [w=fex], sig star(.05) obs