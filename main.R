#' .-----------------------------------------------------.
#' | FGV  - Fundacao Getulio Vargas                      |
#' | IBRE - Instituto Brasileiro de Economia             |
#' | Ibre-Sci-Sapr-Equipe de Mineração de Dados          |
#' | Data inicial: 12/2021                               | 
#' | Atualizado  : 06/2022                               |  
#' | Responsável : winicius.faquieri                     |
#' '-----------------------------------------------------' 
#'
#'         
#'
#' (i) Atalho para executar script "Crtl + Alt + R"   
#' 
#' 
#' 
#' Version information about R, the OS and attached or loaded packages:
#'  
#' R version 4.2.0 (2022-04-22 ucrt)
#' Platform: x86_64-w64-mingw32/x64 (64-bit)
#' Running under: Windows 10 x64 (build 19043)
#' 
#' Matrix products: default
#' 
#' locale:
#' [1] LC_COLLATE=Portuguese_Brazil.utf8  LC_CTYPE=Portuguese_Brazil.utf8   
#' [3] LC_MONETARY=Portuguese_Brazil.utf8 LC_NUMERIC=C                      
#' [5] LC_TIME=Portuguese_Brazil.utf8    
#' 
#' attached base packages:
#' [1] stats     graphics  grDevices utils     datasets  methods   base     
#' 
#' other attached packages:
#' [1] tictoc_1.0.1    lubridate_1.8.0 openxlsx_4.2.5  janitor_2.1.0   readr_2.1.2     readxl_1.4.0   
#' [7] stringr_1.4.0   tidyr_1.2.0     dplyr_1.0.9     magrittr_2.0.3  purrr_0.3.4    
#' 
#' loaded via a namespace (and not attached):
#' [1] zip_2.2.0        Rcpp_1.0.8.3     cellranger_1.1.0 pillar_1.7.0     compiler_4.2.0  
#' [6] tools_4.2.0      bit_4.0.4        lifecycle_1.0.1  tibble_3.1.7     pkgconfig_2.0.3 
#' [11] rlang_1.0.2      DBI_1.1.2        cli_3.3.0        rstudioapi_0.13  parallel_4.2.0  
#' [16] withr_2.5.0      generics_0.1.2   vctrs_0.4.1      hms_1.1.1        bit64_4.0.5     
#' [21] tidyselect_1.1.2 glue_1.6.2       snakecase_0.11.0 R6_2.5.1         fansi_1.0.3     
#' [26] vroom_1.5.7      tzdb_0.3.0       ellipsis_0.3.2   assertthat_0.2.1 archive_1.1.5   
#' [31] utf8_1.2.2       stringi_1.7.6    crayon_1.5.1  





# Limpando o ambiente 

rm(list=ls()) 
gc()


# Bibliotecas:

library(purrr)
library(magrittr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(readxl)
library(readr)
library(janitor)
library(openxlsx)


# Read R Code:

source('src/code/gerar_indicadores.R')
