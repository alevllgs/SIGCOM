library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)

anio <- "2023"
mes <- "02"
Sheet_censo <- "FEB"
rango_censo <- "B5:O20" #lo tomo de donde comienzan los encabezados de la tabla "Informacion Estadistica"
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2023/"



# Rutas automaticas -------------------------------------------------------
mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes)]
Fecha_filtro <- paste0(anio,"-",mes,"-01")
archivoBS <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/Serie BS/",anio,"/",anio,"-",mes," REM serie BS.xlsx")
Censo <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/CENSO/",anio,"/Censo-hrrio ",anio,".xlsx")
Graba <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio ,"/",mes," ",mes_completo,"/Insumos de Informacion/950_Produccion.xlsx")
directorio <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio,"/",mes," ",mes_completo,"/Complemento Subir")

dir.create(directorio)

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


# A32 ---------------------------------------------------------------------

A32_PERC <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Ambulatorio/A32 BBDD.xlsx")
A32_PERC$Fecha=as.character(A32_PERC$Fecha)
A32_PERC <- A32_PERC %>% mutate(Total = Atenciones_Remotas) %>% select(Fecha, Especialidad, Total) %>% 
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
  summarise("Valor" = sum(Total)) %>% 
  add_column("Unidades de Producción" = "2__Atención", .after = 2)

Produccion_SIGCOM <- rbind(Produccion_SIGCOM, A32_PERC)

# Captura producción de Urgencia ------------------------------------------
A08_PERC <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/Urgencia/A08 BBDD_01.xlsx")
A08_PERC$Fecha=as.character(A08_PERC$Fecha)
A08_PERC <- A08_PERC %>% 
  filter(Fecha == Fecha_filtro & (`Tipo de Atención`=="ATENCIÓN MÉDICA NIÑO Y ADULTO" | `Tipo de Atención`=="ATENCIÓN POR ODONTÓLOGO/A")) %>% 
  group_by(Fecha) %>% 
  summarise("Centro de Producción" = ifelse(`Tipo de Atención`=="ATENCIÓN MÉDICA NIÑO Y ADULTO","216__10501 - EMERGENCIAS PEDIÁTRICAS", "357__15603 - EMERGENCIAS ODONTOLOGICAS" ), "Unidades de Producción" = "1__Atención","Valor" = Total)
  
# Captura de producción del CENSO -----------------------------------------

Censo_hrrio_BBDD <- read_excel(Censo,sheet = Sheet_censo, range = rango_censo)

Censo_hrrio_BBDD$`SALUD MENTAL MEDIANA ESTADÍA` <- 
  as.double(Censo_hrrio_BBDD$`SALUD MENTAL MEDIANA ESTADÍA`)

ifelse(is.null(Censo_hrrio_BBDD$`UNIDAD DE EMERGENCIA`)==TRUE,
       Censo_hrrio_BBDD$"116__01401 - HOSPITALIZACIÓN PEDIATRÍA" <- 
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGA Y UPGB`) +
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGC`) +
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGD`) ,
       
       Censo_hrrio_BBDD$"116__01401 - HOSPITALIZACIÓN PEDIATRÍA" <-
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGA Y UPGB`) +
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGC`) +
         as.double(Censo_hrrio_BBDD$`UNIDAD PEDIATRICA UPGD`) +
         as.double(Censo_hrrio_BBDD$`UNIDAD DE EMERGENCIA`))

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
                     range = "B!O1410:X1410") 
B_qx1 <- B_qx1 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "475__33016 - QUIRÓFANOS NEUROCIRUGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...1 + B_qx1$...10, .after = 13) 


B_qx2 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1545:X1545") 
B_qx2 <- B_qx2 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx2$...1 + B_qx2$...10, .after = 13) 

B_qx3 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1727:X1727")  
B_qx3 <- B_qx3 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx3$...1 + B_qx3$...10, .after = 13)

B_qx4 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1791:X1791")  
B_qx4 <- B_qx4 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx4$...1 + B_qx4$...10, .after = 13) 

B_qx5 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1865:X1865")  
B_qx5 <- B_qx5 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "493__33034 - QUIRÓFANOS CIRUGÍA PLÁSTICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx5$...1 + B_qx5$...10, .after = 13) 

B_qx6 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1908:X1908")  
B_qx6 <- B_qx6 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx6$...1 + B_qx6$...10, .after = 13) 

B_qx7 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2067:X2067")  
B_qx7 <- B_qx7 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "464__33005 - QUIRÓFANOS CARDIOVASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx7$...1 + B_qx7$...10, .after = 13)

B_qx8 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2166:X2166")  
B_qx8 <- B_qx8 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx8$...1 + B_qx8$...10, .after = 13)

B_qx9 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2397:X2397")  
B_qx9 <- B_qx9 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx9$...1 + B_qx9$...10, .after = 13) #Abdominal

B_qx10 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2437:X2437")  
B_qx10 <- B_qx10 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx10$...1 + B_qx10$...10, .after = 13) #Procto

B_qx11 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2560:X2560")  
B_qx11 <- B_qx11 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx11$...1 + B_qx11$...10, .after = 13) #URO

B_qx12 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2596:X2596")  
B_qx12 <- B_qx12 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx12$...1 + B_qx12$...10, .after = 13) #Mama

B_qx13 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2639:X2639")  
B_qx13 <- B_qx13 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx13$...1 + B_qx13$...10, .after = 13) #Gine

B_qx14 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2654:X2654")  
B_qx14 <- B_qx14 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx14$...1 + B_qx14$...10, .after = 13) #Obs

B_qx15 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2888:X2888")  
B_qx15 <- B_qx15 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx15$...1 + B_qx15$...10, .after = 13)

B_qx16 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2893:X2893")  
B_qx16 <- B_qx16 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx16$...1 + B_qx16$...10, .after = 13)

B_qxCMA <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2893:X2893")  #lee cualquier rango solo para darle la forma
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


Produccion_SIGCOM$Fecha <- NULL

openxlsx::write.xlsx(Produccion_SIGCOM,Graba, 
                     colNames = TRUE, sheetName = "5", overwrite = TRUE)

openxlsx::write.xlsx(Produccion_SIGCOM,paste0(directorio,"/05.xlsx"), 
                     colNames = TRUE, sheetName = "5", overwrite = TRUE)




# M2 --------------------------------------------------------------
M2 <- paste0(ruta_base,resto,"/Insumos de info anual/M2.xlsx")
M2Pab <- paste0(ruta_base,resto,mes," ",mes_completo,"/Insumos de Informacion/89_Pabellon.xlsx")
grabaM2 <- paste0(ruta_base,resto,mes," ",mes_completo,"/Insumos de Informacion/03 M2.xlsx")
produccion_cae <- paste0(ruta_base,resto,mes," ",mes_completo,"/Insumos de Informacion/950_Produccion.xlsx")


#Asigna los metros a los pabellones segun el tiempo asignado en la tabla quirurgica
M2Pab <- read_excel(M2Pab) %>% 
  mutate("Area" = "Quirofanos", "CC" = SIGCOM, "M2" = 495*prop_total) %>% 
  select(-SIGCOM, -prop_total)
#Modifica los M2 de los pabellones 
M2 <- read_excel(M2) %>% filter(Area !="Quirofanos")
M2 <- rbind(M2,M2Pab)
M2$prop <- prop.table(M2$M2)
rm(M2Pab) #elimino los M2 de los pabellones

#Asigna metros cuadrados al cae
prod_cae <- read_excel(produccion_cae) %>% filter(`Unidades de Producción` == "1__Consulta")
prod_cae$Valor <- prop.table(ifelse(prod_cae$Valor == 0, 1, prod_cae$Valor))
prod_cae$`Centro de Producción` <- substr(prod_cae$`Centro de Producción`, start = 8, stop = 600)
prod_cae$`Centro de Producción` <- paste0(substr(substr(prod_cae$`Centro de Producción`, start = 1, stop = 7), start = 1, stop = 5),"-",substr(prod_cae$`Centro de Producción`, start = 9, stop = 700))
prod_cae <- prod_cae %>%
  mutate("Area" = "Ambulatorio", "CC" = `Centro de Producción`, "M2" = 1555*Valor, "prop"=Valor) %>% 
  select(Area, CC, M2, prop)

M2 <- M2 %>% filter(Area !="Ambulatorio")
M2 <- rbind(M2,prod_cae)
M2$prop <- prop.table(M2$M2)


openxlsx::write.xlsx(M2, grabaM2, colNames = TRUE, sheetName = "M2_prop", overwrite = TRUE)
























rm(P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, B_qx, P,At_remota, 
   archivoBS, Fecha_filtro, remota, Sheet_remota, Egreso, Censo, Graba, rango_censo, Sheet_remota, Sheet_censo)

#Ojo debo crear el CC de Procedimientos de Oftalmologia.
# Debo eliminar la produccion de los CC de procedimientos de Uro y Gine




