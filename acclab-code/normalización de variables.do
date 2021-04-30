use "../data/database_final_variables.dta"
*Normalizar cs_filial
sum cs_filial
egen zcs_filial= std(cs_filial)
gen cs_filial_urb= cs_filial if zona==1
sum cs_filial_urb
gen cs_filial_rur= cs_filial if zona==2
sum cs_filial_rur
egen zcs_filial_urb= std(cs_filial_urb)
egen zcs_filial_rur= std(cs_filial_rur)
sum zcs_filial zcs_filial_urb zcs_filial_rur

*Normalizar cs_conectivo
egen zcs_conectivo= std(cs_conectivo)
gen cs_conectivo_urb= cs_conectivo if zona==1
sum cs_conectivo_urb
gen cs_conectivo_rur= cs_conectivo if zona==2
sum cs_conectivo_rur
egen zcs_conectivo_urb= std(cs_conectivo_urb)
egen zcs_conectivo_rur= std(cs_conectivo_rur)
sum zcs_conectivo zcs_conectivo_urb zcs_conectivo_rur

*Normalizar cs_vinculante
egen zcs_vinculante= std(cs_vinculante)
gen cs_vinculante_urb= cs_vinculante if zona==1
sum cs_vinculante_urb
gen cs_vinculante_rur= cs_vinculante if zona==2
sum cs_vinculante_rur
egen zcs_vinculante_urb= std(cs_vinculante_urb)
egen zcs_vinculante_rur= std(cs_vinculante_rur)
sum zcs_vinculante zcs_vinculante_urb zcs_vinculante_rur

*Normalizar conf_interpersonal
egen zconf_interpersonal= std(conf_interpersonal)
gen conf_interpersonal_urb= conf_interpersonal if zona==1
sum conf_interpersonal_urb
gen conf_interpersonal_rur= conf_interpersonal if zona==2
sum conf_interpersonal_rur
egen zconf_interpersonal_urb= std(conf_interpersonal_urb)
egen zconf_interpersonal_rur= std(conf_interpersonal_rur)
sum zconf_interpersonal zconf_interpersonal_urb zconf_interpersonal_rur

*Normalizar conf_institucional
egen zconf_institucional= std(conf_institucional)
gen conf_institucional_urb= conf_institucional if zona==1
sum conf_institucional_urb
gen conf_institucional_rur= conf_institucional if zona==2
sum conf_institucional_rur
egen zconf_institucional_urb= std(conf_institucional_urb)
egen zconf_institucional_rur= std(conf_institucional_rur)
sum zconf_institucional zconf_institucional_urb zconf_institucional_rur


*Normalizar vulnerabilidad
egen zvulnerabilidad1= std(vulnerabilidad1)
gen vulnerabilidad1_urb= vulnerabilidad1 if zona==1
sum vulnerabilidad1_urb
gen vulnerabilidad1_rur= vulnerabilidad1 if zona==2
sum vulnerabilidad1_rur
egen zvulnerabilidad1_urb= std(vulnerabilidad1_urb)
egen zvulnerabilidad1_rur= std(vulnerabilidad1_rur)
sum  zvulnerabilidad1 zvulnerabilidad1_urb zvulnerabilidad1_rur

*Normalizar ac_comunitaria
egen zac_comunitaria= std(ac_comunitaria)
gen ac_comunitaria_urb= ac_comunitaria if zona==1
sum ac_comunitaria_urb
gen ac_comunitaria_rur= ac_comunitaria if zona==2
sum ac_comunitaria_rur
egen zac_comunitaria_urb= std(ac_comunitaria_urb)
egen zac_comunitaria_rur= std(ac_comunitaria_rur)
sum zac_comunitaria zac_comunitaria_urb zac_comunitaria_rur

*Normalizar ac_comunitaria_colectiva
egen zac_comunitaria_colectiva= std(ac_comunitaria_colectiva)
gen ac_comunitaria_colectiva_urb= ac_comunitaria_colectiva if zona==1
sum ac_comunitaria_colectiva_urb
gen ac_comunitaria_colectiva_rur= ac_comunitaria_colectiva if zona==2
sum ac_comunitaria_colectiva_rur
egen zac_comunitaria_colectiva_urb= std(ac_comunitaria_colectiva_urb)
egen zac_comunitaria_colectiva_rur= std(ac_comunitaria_colectiva_rur)
sum zac_comunitaria_colectiva zac_comunitaria_colectiva_urb zac_comunitaria_colectiva_rur

*Normalizar ac_demanda
egen zac_demanda= std(ac_demanda)
gen ac_demanda_urb= ac_demanda if zona==1
sum ac_demanda_urb
gen ac_demanda_rur= ac_demanda if zona==2
sum ac_demanda_rur
egen zac_demanda_urb= std(ac_demanda_urb)
egen zac_demanda_rur= std(ac_demanda_rur)
sum zac_demanda zac_demanda_urb zac_demanda_rur

*Normalizar commons
egen zcommons= std(commons)
gen commons_urb= commons if zona==1
sum commons_urb
gen commons_rur= commons if zona==2
sum commons_rur
egen zcommons_urb= std(commons_urb)
egen zcommons_rur= std(commons_rur)
sum zcommons zcommons_urb zcommons_rur

*Normalizar R_publica
egen zR_publica= std(R_publica)
gen R_publica_urb= R_publica if zona==1
sum R_publica_urb
gen R_publica_rur= R_publica if zona==2
sum R_publica_rur
egen zR_publica_urb= std(R_publica_urb)
egen zR_publica_rur= std(R_publica_rur)
sum zR_publica zR_publica_urb zR_publica_rur

*Normalizar R_privada
egen zR_privada= std(R_privada)
gen R_privada_urb= R_privada if zona==1
sum R_privada_urb
gen R_privada_rur= R_privada if zona==2
sum R_privada_rur
egen zR_privada_urb= std(R_privada_urb)
egen zR_privada_rur= std(R_privada_rur)
sum zR_privada zR_privada_urb zR_privada_rur

*Normalizar R_civil
egen zR_civil= std(R_civil)
gen R_civil_urb= R_civil if zona==1
sum R_civil_urb
gen R_civil_rur= R_civil if zona==2
sum R_civil_rur
egen zR_civil_urb= std(R_civil_urb)
egen zR_civil_rur= std(R_civil_rur)
sum zR_civil zR_civil_urb zR_civil_rur

save "../data/database_final_normalizada.dta"
