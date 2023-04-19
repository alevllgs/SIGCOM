library(readxl)
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)

anio <- "2023"
mes <- "02"
ruta_base <- "C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/"
resto <- "Cubos 9/Cubo_9 "

costo_día_cama_ocupado <- data.frame("año" = 0, "mes" = 0, "RRHH" = 0, "GG" = 0, "Ins" = 0,"Indirectos" = 0,"DCO" = 0, "Deflactor" = 0, "costo_día_cama_ocupado" = 0)


anio_ant <- "2022"
meses_ant <- c("01","02","03","04","05","06","07","08","09","10","11","12")

for (i in meses_ant){
  DCO <- read_excel(paste0(ruta_base,resto,anio_ant,"-",i,".xlsx"))
  DCO <- DCO %>% 
    select("Insumos / Centro Costos", "87-HOSPITALIZACIÓN ONCOLOGÍA",
           "90-HOSPITALIZACIÓN QUIRÚRGICA",	"116-HOSPITALIZACIÓN PEDIATRÍA") %>% 
    filter(`Insumos / Centro Costos` == "Recursos Humanos" | 
             `Insumos / Centro Costos` == "Gastos Generales" | 
             `Insumos / Centro Costos` == "Insumos" | 
             `Insumos / Centro Costos` == "Total Indirectos" | 
             `Insumos / Centro Costos` == "Total Produccion 2") 

  DCO$sumatoria <- DCO$`87-HOSPITALIZACIÓN ONCOLOGÍA`+DCO$`90-HOSPITALIZACIÓN QUIRÚRGICA`+DCO$`116-HOSPITALIZACIÓN PEDIATRÍA`
  DCO <- DCO %>% select(`Insumos / Centro Costos`, sumatoria)
  RRHH <- DCO %>% filter(`Insumos / Centro Costos` == "Recursos Humanos")
  GG <- DCO %>% filter(`Insumos / Centro Costos` == "Gastos Generales")
  Ins <- DCO %>% filter(`Insumos / Centro Costos` == "Insumos")
  Ind <- DCO %>% filter(`Insumos / Centro Costos` == "Total Indirectos")
  Prod <- DCO %>% filter(`Insumos / Centro Costos` == "Total Produccion 2")
  porc_RRHH <- RRHH$sumatoria/(RRHH$sumatoria+GG$sumatoria+Ins$sumatoria)
  Deflactor <-  (0.1*porc_RRHH+0.128*(1-porc_RRHH))
  
  tabla <- data.frame("año" = anio_ant, 
                      "mes" = i, 
                      "RRHH" = RRHH$sumatoria, 
                      "GG" = GG$sumatoria, 
                      "Ins" = Ins$sumatoria, 
                      "Indirectos" = Ind$sumatoria, 
                      "DCO" = Prod$sumatoria, 
                      "Deflactor" = Deflactor,
                      "costo_día_cama_ocupado" = (RRHH$sumatoria+GG$sumatoria+Ins$sumatoria+Ind$sumatoria)/((Prod$sumatoria)))
  costo_día_cama_ocupado <- rbind(costo_día_cama_ocupado,tabla)
  }

costo_día_cama_ocupado <- costo_día_cama_ocupado %>% filter(mes != 0)


meses_ant <- meses_ant[1:as.numeric(mes)]

for (i in meses_ant){
  DCO <- read_excel(paste0(ruta_base,resto,anio,"-",i,".xlsx"))
  DCO <- DCO %>% 
    select("Insumos / Centro Costos", "87-HOSPITALIZACIÓN ONCOLOGÍA",
           "90-HOSPITALIZACIÓN QUIRÚRGICA",	"116-HOSPITALIZACIÓN PEDIATRÍA") %>% 
    filter(`Insumos / Centro Costos` == "Recursos Humanos" | 
             `Insumos / Centro Costos` == "Gastos Generales" | 
             `Insumos / Centro Costos` == "Insumos" | 
             `Insumos / Centro Costos` == "Total Indirectos" | 
             `Insumos / Centro Costos` == "Total Produccion 2") 
  
  DCO$sumatoria <- DCO$`87-HOSPITALIZACIÓN ONCOLOGÍA`+DCO$`90-HOSPITALIZACIÓN QUIRÚRGICA`+DCO$`116-HOSPITALIZACIÓN PEDIATRÍA`
  DCO <- DCO %>% select(`Insumos / Centro Costos`, sumatoria)
  RRHH <- DCO %>% filter(`Insumos / Centro Costos` == "Recursos Humanos")
  GG <- DCO %>% filter(`Insumos / Centro Costos` == "Gastos Generales")
  Ins <- DCO %>% filter(`Insumos / Centro Costos` == "Insumos")
  Ind <- DCO %>% filter(`Insumos / Centro Costos` == "Total Indirectos")
  Prod <- DCO %>% filter(`Insumos / Centro Costos` == "Total Produccion 2")
  
  tabla <- data.frame("año" = anio,
                      "mes" = i,
                      "RRHH" = RRHH$sumatoria,
                      "GG" = GG$sumatoria,
                      "Ins" = Ins$sumatoria,
                      "Indirectos" = Ind$sumatoria,
                      "DCO" = Prod$sumatoria,
                      "Deflactor" = 0,
                      "costo_día_cama_ocupado" = (RRHH$sumatoria+GG$sumatoria+Ins$sumatoria+Ind$sumatoria)/Prod$sumatoria)
  
  
  
  costo_día_cama_ocupado <- rbind(costo_día_cama_ocupado,tabla)
}

openxlsx::write.xlsx(costo_día_cama_ocupado, paste0(ruta_base,"Cubos 9/VEEOS_info.xlsx"), colNames = TRUE, sheetName = "VEEOS", overwrite = TRUE)