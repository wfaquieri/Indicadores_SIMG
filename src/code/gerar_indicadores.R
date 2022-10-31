

# Leitura da planilha de controle geral de solicitações'

drt = dir("inputs", full.names = T)

plan1 = 
  read_excel(drt[str_detect(drt, "Controle-Geral")], 
             col_types = c("text", "text", "text", 
                           "text", "text", "text", "text", "text", 
                           "text", "text", "text", "text", "date", 
                           "date", "text", "text", "numeric", 
                           "numeric", "text", "date", "date", 
                           "text", "text")) |>
  janitor::clean_names() |> 
  dplyr::rename(dt_pedido = data_da_solicitacao) |> 
  dplyr::select(dt_pedido,job,descricao_solicitada) |> 
  dplyr::rename(descricao = descricao_solicitada)

# Sempre filtrar o mês anterior:

prev_date = floor_date(today(), "month") - months(1)

plan1 = plan1 |>  
  filter(month(dt_pedido)==month(prev_date) & year(dt_pedido)==year(prev_date))


# Excluir o termo “agendamento/confirmação”:

plan1 = plan1 |> mutate(descricao = descricao |>  toupper()) |>  
  filter(!str_detect(descricao, "AGENDAMENTO|CONFIRMAÇÃO"))



# Quantitativo 1 - Quantidade de itens solicitados: -----------------------

plan1 = plan1 |> mutate(
  job = job |>  toupper(),
  grupos =
    case_when(
      str_detect(job, "SICRO|SCRO") | job == 'DNIT' ~ 'SICRO',
      job == 'SICFER' ~ 'SICFER',
      job == 'ECON_DNIT' ~ 'ECON_DNIT',
      str_detect(job, "INFRAES") ~ 'INFRAES',
      str_detect(job, "DMT") ~ 'DMT',
      str_detect(job, "DER_MG") ~ 'DER_MG',
      str_detect(job, "DMG_") ~ 'DER_MG',
      str_detect(job, "GOINFRA") ~ 'GOINFRA',
      str_detect(job, "SABESP") ~ 'SABESP',
      str_detect(job, "O-GRUPOS|M-OBRA|M-OBRAS|G-SERVIÇO|PORTOBRAS") ~ 'O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS'
    )
)
  
quant1 = plan1 |> group_by(grupos) |> summarise(n_obs = n()) |>  
  filter(grupos != 'NA')

rm(plan1)




# Quantitativo 2 -	Quantidade de empresas mapeadas: -----------------------

plan2 <-
  read_delim(
    drt[str_detect(drt, "mapeamento")],
    delim = ";",
    escape_double = FALSE,
    locale = locale(encoding = "latin1"),
    trim_ws = TRUE
  )




# Sempre filtrar o mês anterior:

plan2 = plan2 |> 
  filter(month(Data)==month(prev_date) & year(Data)==year(prev_date))




# Separando por grupos

plan2 = plan2 |> mutate(
  job = Job |>  toupper(),
  grupos = 
    case_when(
      str_detect(job, "SICRO|SCRO") | job == 'DNIT' ~ 'SICRO',
      job == 'SICFER' ~ 'SICFER',
      job == 'ECON_DNIT' ~ 'ECON_DNIT',
      str_detect(job, "INFRAES") ~ 'INFRAES',
      str_detect(job, "DMT") ~ 'DMT',
      str_detect(job, "DER_MG") ~ 'DER_MG',
      str_detect(job, "DMG_") ~ 'DER_MG',
      str_detect(job, "GOINFRA") ~ 'GOINFRA',
      str_detect(job, "SABESP") ~ 'SABESP',
      str_detect(job, "O-GRUPOS|M-OBRA|M-OBRAS|G-SERVIÇO|PORTOBRAS") ~ 'O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS'
    )
)

quant2 = plan2 |>  group_by(grupos) |>  summarise(n_cnpj = n_distinct(CNPJ)) |>  
  filter(grupos != 'NA')
  





# Quantitativo 3 -	Quantidade de empresas status aguardando: --------------

quant3 = plan2 |>  filter(Status == 'AG') |>  group_by(grupos) |>  
  summarise(n_AG = n()) |>  filter(grupos != 'NA')

rm(plan2)




# Quantitativo 4 - Preços Positivos ---------------------------------------

plan_cargas = drt[str_detect(drt, "_CARGA_SIMG_")]

n = length(plan_cargas)

plan3 = 
  map_df(1:n,
      ~read_xlsx(plan_cargas[.x],
                 sheet =1,
                 skip = 2,
                 col_types = 'text',
                 col_names = T,
                 trim_ws = T)) |>  clean_names() |>  rename(job = 24)


plan3 = plan3 |> mutate(
  grupos =
    case_when(
      str_detect(job, "SICRO") ~ 'SICRO',
      job == 'SICFER' ~ 'SICFER',
      job == 'ECON_DNIT' ~ 'ECON_DNIT',
      str_detect(job, "INFRAES") ~ 'INFRAES',
      str_detect(job, "DMT") ~ 'DMT',
      str_detect(job, "DER_MG") ~ 'DER_MG',
      str_detect(job, "DMG_") ~ 'DER_MG',
      str_detect(job, "GOINFRA") ~ 'GOINFRA',
      str_detect(job, "SABESP") ~ 'SABESP',
      str_detect(job, "O-GRUPOS|M-OBRA|M-OBRAS|G-SERVIÇO|PORTOBRAS") ~ 'O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS'
    )
)


# Parte 1
quant4a = plan3 |>  group_by(grupos) |>  summarise(n_pos = n()) |>  na.omit()


plan4 <- 
  read_xlsx(drt[str_detect(drt, "SIS")],
            sheet =1,
            skip = 5,
            col_names = T,
            trim_ws = T) |> janitor::clean_names() |>  
  mutate(grupos = 'O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS')

quant4b = plan4 |> group_by(grupos) |> summarise(n_pos = n())

quant4 = bind_rows(quant4a,quant4b)
rm(quant4a,quant4b)


# Criar a Tabela de Indicadores (vide: 'src/Template.xlsx'):

tab_ind = tibble(
  Jobs = c(
    'SICRO',
    'SABESP',
    'SICFER',
    'ECON_DNIT',
    'INFRAES',
    'DMT',
    'O-GRUPOS/M-OBRA/G-SERVIÇO/PORTOBRAS',
    'DER_MG',
    'GOINFRA'
  )
) |> 
  left_join(quant1, by = c('Jobs' = 'grupos')) |> 
  left_join(quant4, by = c('Jobs' = 'grupos')) |> 
  mutate(col3 = '') |> 
  left_join(quant2, by = c('Jobs' = 'grupos')) |> 
  mutate(col4 = '', col5 = '') |> 
  left_join(quant3, by = c('Jobs' = 'grupos')) |> 
  mutate(col7 = '', col8 = '') |> 
  adorn_totals("row") |> 
  as_tibble()




# Workbook (Excel) --------------------------------------------------------

hs <- createStyle(fontName = "Calibri", 
                  fontSize = 8, 
                  fontColour = "#262626", 
                  fgFill = "#ffffff",
                  textDecoration = "bold", 
                  borderStyle = "none",
                  valign = "center",
                  halign = "center")

prev_date = floor_date(today(), "month") - months(1)

dataref = paste0(
  "Referência: ",
  substring(prev_date, 9, 10),
  "/",
  substring(prev_date, 6, 7),
  "/",
  substring(prev_date, 1, 4),
  " à ",
  days_in_month(prev_date),
  "/",
  substring(prev_date, 6, 7),
  "/",
  substring(prev_date, 1, 4)
) 

# rm(wb)
wb <- loadWorkbook("src/Template.xlsx")
wb |>  writeData(
  sheet = 1,
  dataref,
  startCol = 1,
  startRow = 1,
  colNames = F
)
wb |>  writeData(
  sheet = 1,
  tab_ind,
  startCol = 1,
  startRow = 5,
  colNames = F
)
addStyle(
  wb,
  sheet = 1,
  style = hs,
  rows = 1,
  cols = 1
)
mergeCells(wb,
           sheet = 1,
           cols = 1:10,
           rows = 1)
wb |>  saveWorkbook(paste0("outputs/", Sys.Date(), "_INDICADORES_SIMG.xlsx"),
                    overwrite = T)

rm(list=ls())
gc()
cat("\014")


cat('\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n
    Planilha de Indicadores SIMG gerada com sucesso! \n \n \n \n \n \n \n
    ')
