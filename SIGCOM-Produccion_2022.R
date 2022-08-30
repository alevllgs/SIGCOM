library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)

anio <- "2022"
mes <- "07"
Sheet_remota <- "Teleconsultas"
Sheet_censo <- "JUL"
rango_censo <- "B5:R20" #lo tomo de donde comienzan los encabezados de la tabla "Informacion Estadistica"



mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes)]
Fecha_filtro <- paste0(anio,"-",mes,"-01")
archivoBS <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/Serie BS/",anio,"/",anio,"-",mes," REM serie BS.xlsx")
remota <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Ambulatorio/Atenciones Remotas/",anio,"/",mes," REMOTA.xlsx")
Censo <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/CENSO/",anio,"/Censo-hrrio ",anio,".xlsx")
Graba <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio ,"/",mes," ",mes_completo,"/Insumos de Informacion/950_Produccion.xlsx")

# Captura de producción ambulatoria ---------------------------------------


A07_PERC <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Ambulatorio/A07 BBDD.xlsx")
A07_PERC$Fecha=as.character(A07_PERC$Fecha)
A07_PERC <- A07_PERC %>% select(Fecha, Especialidad, Total) %>% 
  filter(Fecha == Fecha_filtro) %>%
  mutate("Centro de Producción" = case_when(
  Especialidad == "PEDIATRÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "ENFERMEDAD RESPIRATORIA PEDIÁTRICA (BRONCOPULMONAR INFANTIL)" ~ "15111__15111 - CONSULTA NEUMOLOGÍA",
  Especialidad == "ENFERMEDAD RESPIRATORIA DE ADULTO (BRONCOPULMONAR)" ~ "15111__15111 - CONSULTA NEUMOLOGÍA",
  Especialidad == "CARDIOLOGÍA PEDIÁTRICA" ~ "15105__15105 - CONSULTA CARDIOLOGÍA",
  Especialidad == "CARDIOLOGÍA ADULTO" ~ "15105__15105 - CONSULTA CARDIOLOGÍA",
  Especialidad == "ENDOCRINOLOGÍA PEDIÁTRICA" ~ "15110__15110 - CONSULTA ENDOCRINOLOGÍA",
  Especialidad == "ENDOCRINOLOGÍA ADULTO" ~ "15110__15110 - CONSULTA ENDOCRINOLOGÍA",
  Especialidad == "GASTROENTEROLOGÍA PEDIÁTRICA" ~ "15119__15119 - CONSULTA GASTROENTEROLOGÍA",
  Especialidad == "GASTROENTEROLOGÍA ADULTO" ~ "15119__15119 - CONSULTA GASTROENTEROLOGÍA",
  Especialidad == "GENÉTICA CLÍNICA" ~ "15115__15115 - CONSULTA GENÉTICA",
  Especialidad == "HEMATO-ONCOLOGÍA INFANTIL" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
  Especialidad == "HEMATOLOGÍA ADULTO" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
  Especialidad == "ONCOLOGÍA MÉDICA" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
  Especialidad == "NEFROLOGÍA PEDIÁTRICA" ~ "15114__15114 - CONSULTA NEFROLOGÍA",
  Especialidad == "NEFROLOGÍA ADULTO" ~ "15114__15114 - CONSULTA NEFROLOGÍA",
  Especialidad == "NUTRIÓLOGO PEDIÁTRICO" ~ "15008__15008 - CONSULTA NUTRICIÓN",
  Especialidad == "NUTRIÓLOGO ADULTO" ~ "15008__15008 - CONSULTA NUTRICIÓN",
  Especialidad == "REUMATOLOGÍA PEDIÁTRICA" ~ "15104__15104 - CONSULTA REUMATOLOGÍA",
  Especialidad == "REUMATOLOGÍA ADULTO" ~ "15104__15104 - CONSULTA REUMATOLOGÍA",
  Especialidad == "DERMATOLOGÍA" ~ "15106__15106 - CONSULTA DERMATOLOGÍA",
  Especialidad == "INFECTOLOGÍA PEDIÁTRICA" ~ "15113__15113 - CONSULTA INFECTOLOGÍA",
  Especialidad == "INFECTOLOGÍA ADULTO" ~ "15113__15113 - CONSULTA INFECTOLOGÍA",
  Especialidad == "MEDICINA FÍSICA Y REHABILITACIÓN PEDIÁTRICA (FISIATRÍA PEDIÁTRICA)" ~ "15118__15118 - CONSULTA FISIATRÍA",
  Especialidad == "MEDICINA FÍSICA Y REHABILITACIÓN ADULTO (FISIATRÍA ADULTO)" ~ "15118__15118 - CONSULTA FISIATRÍA",
  Especialidad == "NEUROLOGÍA PEDIÁTRICA" ~ "15305__15305 - CONSULTA NEUROLOGÍA PEDIÁTRICA",
  Especialidad == "NEUROLOGÍA ADULTO" ~ "15305__15305 - CONSULTA NEUROLOGÍA PEDIÁTRICA",
  Especialidad == "PSIQUIATRÍA PEDIÁTRICA Y DE LA ADOLESCENCIA" ~ "15109__15109 - CONSULTA PSIQUIATRÍA",
  Especialidad == "PSIQUIATRÍA ADULTO" ~ "15109__15109 - CONSULTA PSIQUIATRÍA",
  Especialidad == "CIRUGÍA PEDIÁTRICA" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA GENERAL ADULTO" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA DIGESTIVA (ALTA)" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA DE CABEZA, CUELLO Y MAXILOFACIAL" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "COLOPROCTOLOGÍA (CIRUGIA DIGESTIVA BAJA)" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA TÓRAX" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA VASCULAR PERIFÉRICA" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
  Especialidad == "CIRUGÍA PLÁSTICA Y REPARADORA PEDIÁTRICA" ~ "15208__15208 - CONSULTA CIRUGÍA PLÁSTICA",
  Especialidad == "CIRUGÍA PLÁSTICA Y REPARADORA ADULTO" ~ "15208__15208 - CONSULTA CIRUGÍA PLÁSTICA",
  Especialidad == "NEUROCIRUGÍA" ~ "15121__15121 - CONSULTA NEUROCIRUGÍA",
  Especialidad == "ANESTESIOLOGÍA" ~ "15125__15125 - CONSULTA ANESTESIOLOGIA",
  Especialidad == "UROLOGÍA PEDIÁTRICA" ~ "15203__15203 - CONSULTA UROLOGÍA",
  Especialidad == "UROLOGÍA ADULTO" ~ "15203__15203 - CONSULTA UROLOGÍA",
  Especialidad == "OFTALMOLOGÍA" ~ "15209__15209 - CONSULTA OFTALMOLOGÍA",
  Especialidad == "OTORRINOLARINGOLOGÍA" ~ "15211__15211 - CONSULTA OTORRINOLARINGOLOGÍA",
  Especialidad == "TRAUMATOLOGÍA Y ORTOPEDIA PEDIÁTRICA" ~ "15316__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
  Especialidad == "TRAUMATOLOGÍA Y ORTOPEDIA ADULTO" ~ "15316__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
  Especialidad == "MEDICINA INTERNA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "NEONATOLOGÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "INMUNOLOGÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "GERIATRÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "CIRUGÍA CARDIOVASCULAR" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "OBSTETRICIA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "GINECOLOGÍA PEDIÁTRICA Y DE LA ADOLESCENCIA" ~ "15502__15502 - CONSULTA GINECOLOGICA",
  Especialidad == "GINECOLOGÍA ADULTO" ~ "15502__15502 - CONSULTA GINECOLOGICA",
  Especialidad == "MEDICINA FAMILIAR DEL NIÑO" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "MEDICINA FAMILIAR" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "MEDICINA FAMILIAR ADULTO" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "DIABETOLOGÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "MEDICINA NUCLEAR (EXCLUYE INFORMES)" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "IMAGENOLOGÍA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  Especialidad == "RADIOTERAPIA ONCOLÓGICA" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
  TRUE ~ "Asignar Centro de Costo")) %>% 
  group_by(Fecha, `Centro de Producción`) %>% 
  summarise("Valor" = sum(Total))
  

A09I_PERC <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Ambulatorio/A09 BBDD_03.xlsx")
A09I_PERC$Fecha=as.character(A09I_PERC$Fecha)
A09I_PERC <- A09I_PERC %>% filter(Fecha == Fecha_filtro) %>% 
  filter(`TIPO DE INGRESO O EGRESO`=="CONSULTA NUEVA" | `TIPO DE INGRESO O EGRESO`=="CONTROL") %>% 
  summarise(Valor=sum(Total)) %>% 
  mutate(Fecha=Fecha_filtro, "Centro de Producción" = "15602__15602 - CONSULTA ODONTOLOGÍA") %>% 
  select(Fecha, `Centro de Producción`, Valor)

Produccion_SIGCOM <- rbind(A07_PERC, A09I_PERC) %>% 
  add_column("Unidades de Producción" = "1__Consulta", .after = 2)

  
# Captura producción de Urgencia ------------------------------------------
A08_PERC <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Urgencia/A08 BBDD_01.xlsx")
A08_PERC$Fecha=as.character(A08_PERC$Fecha)
A08_PERC <- A08_PERC %>% 
  filter(Fecha == Fecha_filtro & (`Tipo de Atención`=="ATENCIÓN MÉDICA NIÑO Y ADULTO" | `Tipo de Atención`=="ATENCIÓN POR ODONTÓLOGO")) %>% 
  group_by(Fecha) %>% 
  summarise("Centro de Producción" = ifelse(`Tipo de Atención`=="ATENCIÓN MÉDICA NIÑO Y ADULTO","216__10501 - EMERGENCIAS PEDIÁTRICAS", "357__15603 - EMERGENCIAS ODONTOLOGICAS" ), "Unidades de Producción" = "1__Atención","Valor" = Total)
  
# Captura de producción del CENSO -----------------------------------------

Censo_hrrio_BBDD <- read_excel(Censo,sheet = Sheet_censo, range = rango_censo)
Censo_hrrio_BBDD$`SALUD MENTAL MEDIANA ESTADÍA` <- 
  as.double(Censo_hrrio_BBDD$`SALUD MENTAL MEDIANA ESTADÍA`)


Censo_hrrio_BBDD$"116__01401 - HOSPITALIZACIÓN PEDIATRÍA" <- 
  Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGA Y UPGB`+
  Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPG C` +
  as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPG D`) +
  Censo_hrrio_BBDD$`UNIDAD DE EMERGENCIA`


Censo_hrrio_BBDD$"87__01122 - HOSPITALIZACIÓN ONCOLOGÍA" <- 
  Censo_hrrio_BBDD$`UNIDAD DE ONCOLOGÍA`

Censo_hrrio_BBDD$"90__01201 - HOSPITALIZACIÓN QUIRÚRGICA" <- 
  Censo_hrrio_BBDD$`UNIDAD DE TRAUMATOLOGIA`+
  Censo_hrrio_BBDD$`UNIDAD DE CIRUGIA GENERAL`+
  Censo_hrrio_BBDD$`UNIDAD DE PLASTICA Y QUEMADO`

Censo_hrrio_BBDD$"149__01610 - HOSPITALIZACIÓN PSIQUIATRÍA" <- 
  Censo_hrrio_BBDD$`SALUD MENTAL CORTA ESTADÍA`+
  Censo_hrrio_BBDD$`SALUD MENTAL MEDIANA ESTADÍA`


Censo_hrrio_BBDD$"170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" <- 
  Censo_hrrio_BBDD$`UNIDAD DE CUIDADO INTENSIVO PEDIATRICO`

Censo_hrrio_BBDD$"196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA" <- 
  Censo_hrrio_BBDD$`UNIDAD DE CUIDADO INTERMEDIO PEDIATRICO`

Censo_hrrio_BBDD$"198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" <- 
  Censo_hrrio_BBDD$`UNIDAD DE CUIDADO INTENSIVO CARDIOVASCULAR`

Censo_hrrio_BBDD$"177__05012 - UNIDAD DE CUIDADOS CORONARIOS" <- 
  Censo_hrrio_BBDD$`UNIDAD DE CUIDADO INTERMEDIO CARDIOVASCULAR`



Censo_hrrio_BBDD <- Censo_hrrio_BBDD %>% 
  select(`Información Estadística`,`116__01401 - HOSPITALIZACIÓN PEDIATRÍA`,
         `90__01201 - HOSPITALIZACIÓN QUIRÚRGICA`,
         `87__01122 - HOSPITALIZACIÓN ONCOLOGÍA`, 
         `149__01610 - HOSPITALIZACIÓN PSIQUIATRÍA`,
         `170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA`,
         `196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA`,
         `198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS`,
         `177__05012 - UNIDAD DE CUIDADOS CORONARIOS`) 

Censo_hrrio_BBDD <- Censo_hrrio_BBDD %>% 
  pivot_longer(-`Información Estadística`,
               names_to = "Unidad", 
               values_to = "Total")

Censo_hrrio_BBDD$Fecha <- Fecha_filtro
Censo_hrrio_BBDD$Fecha=as.character(Censo_hrrio_BBDD$Fecha)
  
Censo_No_Critico <- Censo_hrrio_BBDD %>% filter(Fecha == Fecha_filtro) %>% 
  mutate("Centro de Producción" = case_when(
    Unidad == "116__01401 - HOSPITALIZACIÓN PEDIATRÍA" ~  "116__01401 - HOSPITALIZACIÓN PEDIATRÍA",
    Unidad == "87__01122 - HOSPITALIZACIÓN ONCOLOGÍA" ~  "87__01122 - HOSPITALIZACIÓN ONCOLOGÍA",
    Unidad == "90__01201 - HOSPITALIZACIÓN QUIRÚRGICA" ~ "90__01201 - HOSPITALIZACIÓN QUIRÚRGICA",
    Unidad == "149__01610 - HOSPITALIZACIÓN PSIQUIATRÍA" ~ "149__01610 - HOSPITALIZACIÓN PSIQUIATRÍA",
    TRUE ~ "No")) %>% 
  mutate("Unidades de Producción" = case_when(
    `Información Estadística` == "Egresos- Alta" ~ "1__Egreso",
    `Información Estadística` == "Egresos-Fallecidos" ~ "1__Egreso",
    `Información Estadística` == "Ocupada" ~ "2__DCO",
    `Información Estadística` == "N° camas dotación" ~ "6__N. Camas",
    TRUE ~ "No")) %>% 
  filter(`Unidades de Producción` != "No" & `Centro de Producción` != "No") %>% 
  group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Total))


Censo_Critico <- Censo_hrrio_BBDD %>% filter(Fecha == Fecha_filtro) %>% 
  mutate("Centro de Producción" = case_when(
    Unidad == "170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" ~  "170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
    Unidad == "198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" ~  "198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
    Unidad == "196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA" ~  "196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
    Unidad == "177__05012 - UNIDAD DE CUIDADOS CORONARIOS" ~  "177__05012 - UNIDAD DE CUIDADOS CORONARIOS",
    TRUE ~ "No")) %>% 
  mutate("Unidades de Producción" = case_when(
    `Información Estadística` == "Egresos- Alta" ~ "1__Transferencia",
    `Información Estadística` == "Egresos-Fallecidos" ~ "1__Transferencia",
    `Información Estadística` == "Egresos-Traslados" ~ "1__Transferencia",
    `Información Estadística` == "Ocupada" ~ "2__DCO",
    `Información Estadística` == "N° camas dotación" ~ "6__N. Camas",
    TRUE ~ "No")) %>% 
  filter(`Unidades de Producción` != "No" & `Centro de Producción` != "No") %>% 
  group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Total))

Egreso <- Censo_hrrio_BBDD %>% filter(Fecha == Fecha_filtro) %>% 
  mutate("Centro de Producción" = case_when(
    Unidad == "170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" ~  "170__05005 - UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
    Unidad == "198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" ~  "198__05305 - UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
    Unidad == "196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA" ~  "196__05303 - UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
    Unidad == "177__05012 - UNIDAD DE CUIDADOS CORONARIOS" ~  "177__05012 - UNIDAD DE CUIDADOS CORONARIOS",
    TRUE ~ "No")) %>% 
  mutate("Unidades de Producción" = case_when(
    `Información Estadística` == "Egresos- Alta" ~ "3__Egreso",
    `Información Estadística` == "Egresos-Fallecidos" ~ "3__Egreso",
    TRUE ~ "No")) %>% 
  filter(`Unidades de Producción` != "No" & `Centro de Producción` != "No") %>% 
  group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Total))

Censo_Critico <- rbind(Censo_Critico, Egreso)


# TELEMEDICINA ------------------------------------------------------------

telemedicina <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Ambulatorio/A30 BBDD.xlsx")
telemedicina$Fecha=as.character(telemedicina$Fecha)

telemedicina <- telemedicina %>% 
  filter(Fecha == Fecha_filtro) %>% 
  group_by(Fecha) %>% 
  summarise("Valor" = sum(Telemedicina_Nueva)+ sum(Telemedicina_Control) +sum(Telemedicina_Hospitalizados)) %>% 
  add_column("Centro de Producción" = "359__15701 - TELEMEDICINA", .after = 1) %>% 
  add_column("Unidades de Producción" = "1__Atención", .after = 2)

Produccion_SIGCOM <- rbind(Produccion_SIGCOM,telemedicina, A08_PERC, Censo_Critico, Censo_No_Critico) 
rm(A07_PERC, A09I_PERC, A08_PERC, Censo_Critico, Censo_No_Critico, Censo_hrrio_BBDD, telemedicina)

# REM B -------------------------------------------------------------------

B_qx1 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                     range = "B!O1380:X1380") 
B_qx1 <- B_qx1 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "475__33016 - QUIRÓFANOS NEUROCIRUGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...1 + B_qx1$...10, .after = 13) 


B_qx2 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1514:X1514") 
B_qx2 <- B_qx2 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx2$...1 + B_qx2$...10, .after = 13) 

B_qx3 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1696:X1696")  
B_qx3 <- B_qx3 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx3$...1 + B_qx3$...10, .after = 13)

B_qx4 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1760:X1760")  
B_qx4 <- B_qx4 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx4$...1 + B_qx4$...10, .after = 13) 

B_qx5 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1834:X1834")  
B_qx5 <- B_qx5 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "493__33034 - QUIRÓFANOS CIRUGÍA PLÁSTICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx5$...1 + B_qx5$...10, .after = 13) 

B_qx6 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1877:X1877")  
B_qx6 <- B_qx6 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx6$...1 + B_qx6$...10, .after = 13) 

B_qx7 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2104:X2104")  
B_qx7 <- B_qx7 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "464__33005 - QUIRÓFANOS CARDIOVASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx7$...1 + B_qx7$...10, .after = 13)

B_qx8 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2190:X2190")  
B_qx8 <- B_qx8 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx8$...1 + B_qx8$...10, .after = 13)

B_qx9 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2379:X2379")  
B_qx9 <- B_qx9 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "467__33008 - QUIRÓFANOS DIGESTIVA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx9$...1 + B_qx9$...10, .after = 13)

B_qx10 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2419:X2419")  
B_qx10 <- B_qx10 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx10$...1 + B_qx10$...10, .after = 13)

B_qx11 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2541:X2541")  
B_qx11 <- B_qx11 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx11$...1 + B_qx11$...10, .after = 13)

B_qx12 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2575:X2575")  
B_qx12 <- B_qx12 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx12$...1 + B_qx12$...10, .after = 13)

B_qx13 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2615:X2615")  
B_qx13 <- B_qx13 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx13$...1 + B_qx13$...10, .after = 13)

B_qx14 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2631:X2631")  
B_qx14 <- B_qx14 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx14$...1 + B_qx14$...10, .after = 13)

B_qx15 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2865:X2865")  
B_qx15 <- B_qx15 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx15$...1 + B_qx15$...10, .after = 13)

B_qx16 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2870:X2870")  
B_qx16 <- B_qx16 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx16$...1 + B_qx16$...10, .after = 13)

B_qxCMA <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2870:X2870")  #lee cualquier rango solo para darle la forma
B_qxCMA <- B_qxCMA %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...4 + B_qx2$...4 + B_qx3$...4 + B_qx4$...4 + B_qx5$...4 + B_qx6$...4 +
               B_qx7$...4 + B_qx8$...4 + B_qx9$...4 + B_qx10$...4 + B_qx11$...4 + B_qx12$...4 + 
               B_qx13$...4 + B_qx14$...4 + B_qx15$...4 + B_qx16$...4, .after = 13)

B_qx <- rbind(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
      B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16,B_qxCMA)

rm(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
   B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16, B_qxCMA)

B_qx <- B_qx %>% group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Valor))

Produccion_SIGCOM <- rbind( Produccion_SIGCOM, B_qx)


# Procedimientos -----------------------------------------------------------

# P1 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                      range = "B!C1145:C1145")
# P1 <- P1 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15305__15305 - CONSULTA NEUROLOGÍA PEDIÁTRICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P1$...1,  .after = 4)
# 
# P2 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1271:C1271")
# P2 <- P2 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15209__15209 - CONSULTA OFTALMOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P2$...1,  .after = 4)
# 
# P3 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1424:C1424")
# P3 <- P3 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15211__15211 - CONSULTA OTORRINOLARINGOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P3$...1,  .after = 4)
# 
# P4 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1653:C1653")
# P4 <- P4 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15106__15106 - CONSULTA DERMATOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P4$...1,  .after = 4)
# 
# P5 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C2246:C2246")
# P5 <- P5 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15203__15203 - CONSULTA UROLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P5$...1,  .after = 4)
# 
# P6 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1812:C1812")
# P6 <- P6 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15105__15105 - CONSULTA CARDIOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P6$...1,  .after = 4)
# 
# P7 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1682:C1701")
# P7 <- P7 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15105__15105 - CONSULTA CARDIOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P7$...1,  .after = 4)
# 
# P8 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C1712:C1785")
# P8 <- P8 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15111__15111 - CONSULTA NEUMOLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P8$...1,  .after = 4)
# 
# P9 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C2056:C2056")
# P9 <- P9 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15119__15119 - CONSULTA GASTROENTEROLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P9$...1,  .after = 4)
# 
# P10 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                 range = "B!C2062:C2062")
# P10 <- P10 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15119__15119 - CONSULTA GASTROENTEROLOGÍA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P10$...1,  .after = 4)
# 
# P11 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B!C2453:C2453")
# P11 <- P11 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15316__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P11$...1,  .after = 4)
# 
# P12 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B!C2684:C2684")
# P12 <- P12 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15316__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P12$...1,  .after = 4)
# 
# P13 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B!C2363:C2363")
# P13 <- P13 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15502__15502 - CONSULTA GINECOLOGICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P13$...1,  .after = 4)
# 
# P14 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B!C2416:C2416")
# P14 <- P14 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15502__15502 - CONSULTA GINECOLOGICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P14$...1,  .after = 4)
# 
# P15 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B17!C102:C102")
# P15 <- P15 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P15$...1,  .after = 4)
# 
# P16 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
#                  range = "B!C1011:C1011")
# P16 <- P16 %>%  add_column("Fecha" = Fecha_filtro, .after = 1) %>% 
#   add_column("Centro de Producción" = "15302__15302 - CONSULTA PEDIATRÍA GENERAL", .after = 2) %>% 
#   add_column("Unidades de Producción" = "2__Procedimiento", .after = 3) %>% 
#   add_column("Valor" = P16$...1,  .after = 4)
# 
# P <- rbind(P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16)
# 
# P <- P %>% group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
#   summarise("Valor" = sum(Valor))
# 
# Produccion_SIGCOM <- rbind( Produccion_SIGCOM, P, B_qx)

# Remotas -----------------------------------------------------------------

At_remota <- read_excel(remota, sheet = Sheet_remota)
  At_remota <- At_remota %>% filter(ESTADO=="Asistente" & MES_ATENCION==as.numeric(mes)) %>%
    # At_remota <- At_remota %>% filter(ESTADO=="Asistente" & TIPO_INGRESO!="Control Abreviado") %>%
  group_by(UNIDAD_ATENCION_DESC) %>% 
  count(UNIDAD_ATENCION_DESC) %>%  mutate(Fecha=Fecha_filtro,"Centro de Producción" = case_when(
    UNIDAD_ATENCION_DESC == "Pediatria" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Broncopulmonar Infantil" ~ "15111__15111 - CONSULTA NEUMOLOGÍA",
    UNIDAD_ATENCION_DESC == "Anestesiologia Infantil" ~ "15125__15125 - CONSULTA ANESTESIOLOGIA",
    UNIDAD_ATENCION_DESC == "Cardiologia Infantil" ~ "15105__15105 - CONSULTA CARDIOLOGÍA",
    UNIDAD_ATENCION_DESC == "Cirugia Plastica" ~ "15208__15208 - CONSULTA CIRUGÍA PLÁSTICA",
    UNIDAD_ATENCION_DESC == "Cirugia Infantil" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
    UNIDAD_ATENCION_DESC == "Endocrinologia Infantil" ~ "15110__15110 - CONSULTA ENDOCRINOLOGÍA",
    UNIDAD_ATENCION_DESC == "Endocrinologia Infantil " ~ "15110__15110 - CONSULTA ENDOCRINOLOGÍA",
    UNIDAD_ATENCION_DESC == "Dermatologia Infantil" ~ "15106__15106 - CONSULTA DERMATOLOGÍA",
    UNIDAD_ATENCION_DESC == "Gastroenterologia Infantil" ~ "15119__15119 - CONSULTA GASTROENTEROLOGÍA",
    UNIDAD_ATENCION_DESC == "Ginecologia Infantil" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Ginecologia pediatrica y de la adolescencia" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Genetica Infantil" ~ "15115__15115 - CONSULTA GENÉTICA",
    UNIDAD_ATENCION_DESC == "Hemato-Oncologia" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
    UNIDAD_ATENCION_DESC == "Hemofilia Adulto" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
    UNIDAD_ATENCION_DESC == "Infectologia Infantil" ~ "15113__15113 - CONSULTA INFECTOLOGÍA",
    UNIDAD_ATENCION_DESC == "Nefrologia Infantil" ~ "15114__15114 - CONSULTA NEFROLOGÍA",
    UNIDAD_ATENCION_DESC == "Neurologia Infantil" ~ "15305__15305 - CONSULTA NEUROLOGÍA PEDIÁTRICA",
    UNIDAD_ATENCION_DESC == "Nutriologia Infantil" ~ "15008__15008 - CONSULTA NUTRICIÓN",
    UNIDAD_ATENCION_DESC == "Otorrinolaringologia" ~ "15211__15211 - CONSULTA OTORRINOLARINGOLOGÍA",
    UNIDAD_ATENCION_DESC == "Quemados *" ~ "15208__15208 - CONSULTA CIRUGÍA PLÁSTICA",
    UNIDAD_ATENCION_DESC == "Salud Mental" ~ "15109__15109 - CONSULTA PSIQUIATRÍA",
    UNIDAD_ATENCION_DESC == "Traumatologia Infantil" ~ "15316__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
    UNIDAD_ATENCION_DESC == "Urologia Infantil" ~ "15203__15203 - CONSULTA UROLOGÍA",
    UNIDAD_ATENCION_DESC == "Reumatologia" ~ "15104__15104 - CONSULTA REUMATOLOGÍA",
    UNIDAD_ATENCION_DESC == "Diabetes" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Hematologia Infantil" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
    UNIDAD_ATENCION_DESC == "Oncologia Infantil" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
    UNIDAD_ATENCION_DESC == "Maxilofacial" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Neurocirugia Infantil" ~ "15121__15121 - CONSULTA NEUROCIRUGÍA",
    UNIDAD_ATENCION_DESC == "Prematuros *" ~ "15302__15302 - CONSULTA PEDIATRÍA GENERAL",
    UNIDAD_ATENCION_DESC == "Cirugia Infantil" ~ "15409__15409 - CONSULTA CIRUGÍA PEDIÁTRICA",
    UNIDAD_ATENCION_DESC == "Medicina fisica y rehabilitacion Infantil" ~ "15118__15118 - CONSULTA FISIATRÍA",
    UNIDAD_ATENCION_DESC == "Hemofilia" ~ "15135__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA",
    TRUE ~ "Asignar Centro de Costo"),"Unidades de Producción" = "2__Atención", Valor=n)
  
No_asignadas_remotas <- At_remota %>% filter(`Centro de Producción`=="Asignar Centro de Costo")

At_remota$n <- NULL
At_remota$UNIDAD_ATENCION_DESC <- NULL

Produccion_SIGCOM<- rbind(Produccion_SIGCOM, At_remota)

Produccion_SIGCOM$Fecha <- NULL

openxlsx::write.xlsx(Produccion_SIGCOM,Graba, 
                     colNames = TRUE, sheetName = "5", overwrite = TRUE)

rm(P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, B_qx, P,At_remota, 
   archivoBS, Fecha_filtro, remota, Sheet_remota, Egreso, Censo, Graba, rango_censo, Sheet_remota, Sheet_censo)

#Ojo debo crear el CC de Procedimientos de Oftalmologia.
# Debo eliminar la produccion de los CC de procedimientos de Uro y Gine


