/***********************************************
*PRIMERA ENCUESTA DE CAPITAL SOCIAL 
*ANÁLISIS DE DATOS 
*AccLabPY, 2021
*
*This ado file contains all the data analysis 
*procedures created by the AccLabPY to study 
*the relationship between social capital, 
*vulnerability, collective action and commons
***********************************************/

// 01. Load inversed weighted index by Cyrus Samii
do make_index_gr

// 02. Load data
use "../data/database_ama"
import excel using codes_and_simulated_data 
describe
//
