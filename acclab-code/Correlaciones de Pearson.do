use "../data/database_final_normalizada.dta"
*La confianza interpersonal es condicionante de la confianza institucional
pwcorr zconf_institucional zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zconf_institucional_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zconf_institucional_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs


*La confianza interpersonal es condicionante del capital social filial
pwcorr zcs_filial zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zcs_filial_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zcs_filial_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs

*La confianza interpersonal es condicionante del capital social conectivo
pwcorr zcs_conectivo zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zcs_conectivo_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zcs_conectivo_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs

*La confianza interpersonal es condicionante del capital social vinculante
pwcorr zcs_vinculante zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs

*La confianza institucional es condicionante del capital social vinculante
pwcorr zcs_vinculante zconf_institucional [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_urb zconf_institucional_urb [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_rur zconf_institucional_rur [w=fex], sig star(.05) obs

*El capital social filial es condicionante del capital social conectivo
pwcorr zcs_conectivo zcs_filial [w=fex], sig star(.05) obs
pwcorr zcs_conectivo_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zcs_conectivo_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social filial es condicionante del capital social vinculante
pwcorr zcs_vinculante zcs_filial [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo es condicionante del capital social vinculante
pwcorr zcs_vinculante zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zcs_vinculante_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la acción colectiva para acción comunitaria
pwcorr zac_comunitaria zcs_filial [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la acción colectiva para acción comunitaria
pwcorr zac_comunitaria zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la acción colectiva para demandas cívicas
pwcorr zac_demanda zcs_filial [w=fex], sig star(.05) obs
pwcorr zac_demanda_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zac_demanda_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la acción colectiva para demandas cívicas
pwcorr zac_demanda zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zac_demanda_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zac_demanda_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social vinculante condiciona la acción colectiva para demandas cívicas
pwcorr zac_demanda zcs_vinculante [w=fex], sig star(.05) obs
pwcorr zac_demanda_urb zcs_vinculante_urb [w=fex], sig star(.05) obs
pwcorr zac_demanda_rur zcs_vinculante_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la acción colectiva asociada a activos colectivos
pwcorr zac_comunitaria_colectiva zcs_filial [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_colectiva_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_colectiva_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la acción colectiva asociada a activos colectivos
pwcorr zac_comunitaria_colectiva zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_colectiva_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zac_comunitaria_colectiva_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la respuesta pública
pwcorr zR_publica zcs_filial [w=fex], sig star(.05) obs
pwcorr zR_publica_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zR_publica_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la respuesta pública
pwcorr zR_publica zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zR_publica_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zR_publica_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social vinculante condiciona la respuesta pública
pwcorr zR_publica zcs_vinculante [w=fex], sig star(.05) obs
pwcorr zR_publica_urb zcs_vinculante_urb [w=fex], sig star(.05) obs
pwcorr zR_publica_rur zcs_vinculante_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la respuesta civil
pwcorr zR_civil zcs_filial [w=fex], sig star(.05) obs
pwcorr zR_civil_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zR_civil_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la respuesta civil
pwcorr zR_civil zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zR_civil_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zR_civil_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social vinculante condiciona la respuesta civil
pwcorr zR_civil zcs_vinculante [w=fex], sig star(.05) obs
pwcorr zR_civil_urb zcs_vinculante_urb [w=fex], sig star(.05) obs
pwcorr zR_civil_rur zcs_vinculante_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la respuesta privada
pwcorr zR_privada zcs_filial [w=fex], sig star(.05) obs
pwcorr zR_privada_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zR_privada_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la respuesta privada
pwcorr zR_privada zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zR_privada_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zR_privada_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social vinculante condiciona la respuesta privada
pwcorr zR_privada zcs_vinculante [w=fex], sig star(.05) obs
pwcorr zR_privada_urb zcs_vinculante_urb [w=fex], sig star(.05) obs
pwcorr zR_privada_rur zcs_vinculante_rur [w=fex], sig star(.05) obs

*La respuesta pública condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zR_publica [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zR_publica_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zR_publica_rur [w=fex], sig star(.05) obs

*La respuesta civil condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zR_civil [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zR_civil_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zR_civil_rur [w=fex], sig star(.05) obs


*La respuesta privada condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zR_privada [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zR_privada_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zR_privada_rur [w=fex], sig star(.05) obs

*El capital social filial condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zcs_filial [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zcs_filial_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zcs_filial_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*El capital social vinculante condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zcs_vinculante [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zcs_vinculante_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*La confianza interpersonal condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs

*La confianza institucional condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zconf_institucional [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zconf_institucional_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zconf_institucional_rur [w=fex], sig star(.05) obs

*El acceso a activos colectivos condiciona la vulnerabilidad
pwcorr zvulnerabilidad1 zcommons [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_urb zcommons_urb [w=fex], sig star(.05) obs
pwcorr zvulnerabilidad1_rur zcommons_rur [w=fex], sig star(.05) obs

*El capital social conectivo condiciona el acceso a activos colectivos
pwcorr zcommons zcs_conectivo [w=fex], sig star(.05) obs
pwcorr zcommons_urb zcs_conectivo_urb [w=fex], sig star(.05) obs
pwcorr zcommons_rur zcs_conectivo_rur [w=fex], sig star(.05) obs

*La confianza interpersonal condiciona el acceso a los activos colectivos
pwcorr zcommons zconf_interpersonal [w=fex], sig star(.05) obs
pwcorr zcommons_urb zconf_interpersonal_urb [w=fex], sig star(.05) obs
pwcorr zcommons_rur zconf_interpersonal_rur [w=fex], sig star(.05) obs

*La acción colectiva para acción comunitaria condiciona el acceso a los activos colectivos 
pwcorr zcommons zac_comunitaria [w=fex], sig star(.05) obs
pwcorr zcommons_urb zac_comunitaria_urb [w=fex], sig star(.05) obs
pwcorr zcommons_rur zac_comunitaria_rur [w=fex], sig star(.05) obs

*La acción colectiva para acción comunitaria condiciona la respuesta pública
pwcorr zR_publica zac_comunitaria [w=fex], sig star(.05) obs
pwcorr zR_publica_urb zac_comunitaria_urb [w=fex], sig star(.05) obs
pwcorr zR_publica_rur zac_comunitaria_rur [w=fex], sig star(.05) obs

*La acción colectiva para acción comunitaria condiciona la respuesta civil
pwcorr zR_civil zac_comunitaria [w=fex], sig star(.05) obs
pwcorr zR_civil_urb zac_comunitaria_urb [w=fex], sig star(.05) obs
pwcorr zR_civil_rur zac_comunitaria_rur [w=fex], sig star(.05) obs

*La acción colectiva para demandas cívicas condiciona la respuesta pública
pwcorr zR_publica zac_demanda [w=fex], sig star(.05) obs
pwcorr zR_publica_urb zac_demanda_urb [w=fex], sig star(.05) obs
pwcorr zR_publica_rur zac_demanda_rur [w=fex], sig star(.05) obs

*La acción colectiva para demandas cívicas condiciona la respuesta civil
pwcorr zR_civil zac_demanda [w=fex], sig star(.05) obs
pwcorr zR_civil_urb zac_demanda_urb [w=fex], sig star(.05) obs
pwcorr zR_civil_rur zac_demanda_rur [w=fex], sig star(.05) obs

