---
output:
  html_document:
    css: css/style.css
---





<div align="center">
<br>
  <a href="https://portalibre.fgv.br/">
    <img src="https://portalibre.fgv.br/sites/default/themes/custom/portalibre/logo.png" alt="fgv-ibre">
  </a>
</div>
<br><div align="center">
  <strong>
  <font size="+1">
  <span style="color:MidnightBlue">
  PROJETO: INDICADORES SIMG
  </span>
  </font>
  </strong>
</div>

![](www/images/capa.png)

Esse **README** tem por objetivo documentar o trabalho de automatização da geração dos indicadores SIMG.



---

### Sumário
1. [Introdução](#intro)
2. [Estrutura do diretório](#dir)
3. [Guia do usuário](#guia)
4. [Informações da Sessão](#sessionInfo)

<br>

### [Introdução](#intro)

O objetivo do presente projeto foi delegar para o computador tarefas que se repetiam a cada nova referência. Essa transferência permite aos analistas dispor de mais tempo para a realização de tarefas mais complexas. Anteriormente, os indicadores SIMG eram gerados manualmente para cada job, com frequência mensal. Após o projeto, o fluxo de trabalho foi otimizado, mitigando erros de manipulação (comuns em arquivos de Excel) e os mesmos outputs são gerados em apenas alguns segundos. 

**Lista de Jobs**: SICRO, SABESP, SICFER, ECON_DNIT, INFRAES, DMT, O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS, DER_MG e GOINFRA.

<br>

### [Estrutura do diretório](#dir)

Veja a seguir como a pasta está organizada e sua descrição. **Na pasta de 'inputs' atenção para o nome do arquivo e o formato (.xlsx, .csv)**:

```
.
├─ Projeto.Rproj                                 (Arquivo para abrir e organizar o projeto)        
├─ main.R                                        (Script principal)            
├─ src                                           (Pasta com as dependências do projeto)
│   └─ code/gerar_indicadores.R                  (Script que gera os indicadores)
│   └─ Template.xlsx                             (Template em Excel do arquivo final)
├─ inputs                                        (Pasta para armazenar os dados de entrada do projeto)
│   └─ 1-TODAS AS SOLICITAÇÕES...xlsx            (Deve conter a expressão 'TODAS AS SOLICITAÇÕES' + .xlsx)    
│   └─ AAAA-MM-DD_mapeamento.csv                 (Deve conter a expressão 'mapeamento' + .csv) 
│   └─ Planilha Carga 26 - SIS.xlsx              (Deve conter a expressão 'SIS' + .xlsx)   
│   └─ AAAA-MM-DD_CARGA_SIMG_JOB.xlsx            (Deve conter a expressão '_CARGA_SIMG_' + .xlsx) 
└─ README.html                                   (Este manual)
```
<br>

### [Guia do usuário - Como utilizar a ferramenta?](#guia)


A seguir a sequência de etapas que devem ser realizadas pelo usuário a cada nova referência:

1. Atualizar a pasta 'inputs'

2. Abrir o projeto no RStudio: 'Projeto.Rproj'

3. Executar o script: 'main.R'

4. Fechar o Rstudio (não é necessário salvar).

5. A planilha de indicadores SIMG gerada se encontra na pasta 'outputs': "AAAA-MM-DD_INDICADORES_SIMG.xlsx"

<br>

Assista o gif:

<img src="www/images/demo.gif" alt="this slowpoke moves"  width="3000" />

<br>

### [Informações da Sessão](#sessionInfo)

Informações de versão sobre R, o Sistema Operacional e pacotes anexados ou carregados.


```{r}
R version 4.2.0 (2022-04-22 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 19043)

Matrix products: default

locale:
[1] LC_COLLATE=Portuguese_Brazil.utf8  LC_CTYPE=Portuguese_Brazil.utf8   
[3] LC_MONETARY=Portuguese_Brazil.utf8 LC_NUMERIC=C                      
[5] LC_TIME=Portuguese_Brazil.utf8    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] tictoc_1.0.1    lubridate_1.8.0 openxlsx_4.2.5  janitor_2.1.0   readr_2.1.2     readxl_1.4.0   
[7] stringr_1.4.0   tidyr_1.2.0     dplyr_1.0.9     magrittr_2.0.3  purrr_0.3.4    

loaded via a namespace (and not attached):
[1] zip_2.2.0        Rcpp_1.0.8.3     cellranger_1.1.0 pillar_1.7.0     compiler_4.2.0  
[6] tools_4.2.0      bit_4.0.4        lifecycle_1.0.1  tibble_3.1.7     pkgconfig_2.0.3 
[11] rlang_1.0.2      DBI_1.1.2        cli_3.3.0        rstudioapi_0.13  parallel_4.2.0  
[16] withr_2.5.0      generics_0.1.2   vctrs_0.4.1      hms_1.1.1        bit64_4.0.5     
[21] tidyselect_1.1.2 glue_1.6.2       snakecase_0.11.0 R6_2.5.1         fansi_1.0.3     
[26] vroom_1.5.7      tzdb_0.3.0       ellipsis_0.3.2   assertthat_0.2.1 archive_1.1.5   
[31] utf8_1.2.2       stringi_1.7.6    crayon_1.5.1  
```



