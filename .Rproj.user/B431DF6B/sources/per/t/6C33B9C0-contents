library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)

# SIGFE listas-------------------------------------------------------------------
mes_archivo <- "03 Marzo"
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2022/"

options(scipen=999)
SIGFE <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/01 Ejecucion Presupuestaria.xlsx"), skip = 6)
M2 <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/03 M2.xlsx")
ConsumoxCC <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/02 Consumo x CC del mes.xlsx")
Cant_RRHH <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/902_SIRH_R.xlsx")
Farmacia <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/900_gasto_farmacia.xlsx")
graba <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/920_SIGFE_R.xlsx")
CxCC_H <- paste0(ruta_base,resto,"/Insumos de info anual/CxCC_historico.xlsx")
M2Pab <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/89_Pabellon.xlsx")
EqMed <- paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/99_Equipos_Medicos.xlsx")

SIGFE2 <- str_split_fixed(SIGFE$`Concepto Presupuestario`, " ", n=2)
SIGFE <- cbind(SIGFE, SIGFE2)
SIGFE <- SIGFE %>% mutate("Codigo Base" = `1`, "Subtitulo" = substr(`1`, start = 1, stop = 2))
SIGFE <- SIGFE %>% filter(Subtitulo == "22") %>% 
  select("Codigo Base", Requerimiento, Compromiso, Devengado, Efectivo)


insumos <- c("22",
             "2201",
             "2201001",
             "2201001001",
             "2201001002",
             "2201001003",
             "2201002",
             "2202",
             "2202001",
             "2202002",
             "2202002001",
             "2202002002",
             "2202003",
             "2203",
             "2203001",
             "2203002",
             "2203003",
             "2203999",
             "2204",
             "2204001",
             "2204002",
             "2204003",
             "2204003001",
             "2204003002",
             "2204004",
             "2204004001",
             "220400400101",
             "220400400102",
             "220400400103",
             "2204004002",
             "2204004003",
             "2204004004",
             "2204004005",
             "2204004006",
             "2204005",
             "2204005001",
             "2204005002",
             "2204005003",
             "2204007",
             "2204007002",
             "2204008",
             "2204009",
             "2204010",
             "2204011",
             "2204012",
             "2204013",
             "2204015")


ggenerales <- c("2204006",
                "2204007001",
                "2204014",
                "2204999",
                "2205",
                "2205001",
                "2205002",
                "2205003",
                "2205004",
                "2205005",
                "2205006",
                "2205007",
                "2205999",
                "2206",
                "2206001",
                "2206002",
                "2206003",
                "2206004",
                "2206005",
                "2206006",
                "2206006001",
                "2206006002",
                "2206007",
                "2206999",
                "2207",
                "2207001",
                "2207002",
                "2207003",
                "2207999",
                "2208",
                "2208001",
                "2208002",
                "2208003",
                "2208007",
                "2208008",
                "2208009",
                "2208010",
                "2208999",
                "2209",
                "2209001",
                "2209002",
                "2209003",
                "2209004",
                "2209005",
                "2209005001",
                "2209005002",
                "2209006",
                "2209999",
                "2210",
                "2210001",
                "2210002",
                "2210003",
                "2210004",
                "2210999",
                "2211",
                "2211001",
                "2211002",
                "2211002001",
                "221100200101",
                "221100200102",
                "221100200103",
                "221100200201",
                "221100200202",
                "221100200203",
                "221100200301",
                "221100200302",
                "221100200303",
                "221100200401",
                "221100200402",
                "221100200403",
                "221100200501",
                "221100200502",
                "221100200503",
                "221100200601",
                "221100200602",
                "2211003",
                "2211999",
                "2212",
                "2212002",
                "2212003",
                "2212004",
                "2212005",
                "2212006",
                "2212999",
                "2212999001",
                "2212999002",
                "221299900201",
                "221299900202",
                "2212999003",
                "221299900302",
                "2212999004",
                "2212999005",
                "2212999006",
                "221299900601",
                "221299900602",
                "221299900603",
                "2212999009",
                "221299900901",
                "221299900902",
                "221299900903",
                "2212999010",
                "2212999011",
                "2212999014",
                "221299901401",
                "221299901402",
                "2212999015",
                "2212999017",
                "2212999019",
                "2212999016",
                "2212999018",
                "2212999020",
                "2212999021",
                "2212999022",
                
                "2206002001",
                "2206002002",
                "2206002003",
                "2206002004",
                "2206002005",
                "2206002006",
                
                "2206005001",
                "2206005002",
                
                "2206006001",
                "2206006003",
                
                "2206006002",
                "2206006004"
                )

RRHH_sigfe <- c("221299900301",
                "221299900302",
                "221299901601",
                "221299901602")

# SIGFE Formulas ----------------------------------------------------------

SIGFE$`Codigo Base` <- as.character(SIGFE$`Codigo Base`)
colnames(SIGFE)[1] <- "cod_sigfe"
SIGFE <- SIGFE %>% select(cod_sigfe, Devengado) %>% 
  mutate(Tipo = case_when(cod_sigfe %in% insumos ~ "Insumos",
                          cod_sigfe %in% ggenerales ~ "Gastos Generales",
                          cod_sigfe %in% RRHH_sigfe ~ "RRHH Eliminar",
                          TRUE ~ "Asignar Centro de Costo")) %>% 
  mutate(SIGCOM = case_when(
    #Insumos
    cod_sigfe == "22" ~ "Familia",
    cod_sigfe == "2201"~ "Familia",
    cod_sigfe == "2201001"~ "Familia",
    cod_sigfe == "2201001001"~ "46-VÍVERES",
    cod_sigfe == "2201001002"~ "46-VÍVERES",
    cod_sigfe == "2201001003"~ "46-VÍVERES",
    cod_sigfe == "2201002"~ "46-VÍVERES",
    
    cod_sigfe == "2202"~ "Familia",
    cod_sigfe == "2202001"~ "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
    cod_sigfe == "2202002"~ "Familia",
    cod_sigfe == "2202002001"~ "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
    cod_sigfe == "2202002002"~ "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
    cod_sigfe == "2202003"~ "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
    
    cod_sigfe == "2203"~ "Familia",
    cod_sigfe == "2203001"~ "3-COMBUSTIBLES Y LUBRICANTES",
    cod_sigfe == "2203002"~ "3-COMBUSTIBLES Y LUBRICANTES",
    cod_sigfe == "2203003"~ "3-COMBUSTIBLES Y LUBRICANTES",
    cod_sigfe == "2203999"~ "3-COMBUSTIBLES Y LUBRICANTES",
    
    cod_sigfe == "2204"~ "Familia",
    cod_sigfe == "2204001"~ "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
    cod_sigfe == "2204002"~ "11-LIBROS, TEXTOS, UTILES DE ENSEÑANZA Y PUBLICACIONES",
    cod_sigfe == "2204003"~ "Familia",
    cod_sigfe == "2204003001"~ "9-GASES MEDICINALES",
    cod_sigfe == "2204003002"~ "41-PRODUCTOS QUÍMICOS",
    
    cod_sigfe == "2204004"~ "Familia",
    cod_sigfe == "2204004001"~ "Familia",
    cod_sigfe == "220400400101"~ "30-MEDICAMENTOS",
    cod_sigfe == "220400400102"~ "30-MEDICAMENTOS",
    cod_sigfe == "220400400103"~ "30-MEDICAMENTOS",
    
    cod_sigfe == "2204004002"~ "15-MATERIAL DE ODONTOLOGÍA",
    
    cod_sigfe == "2204004003"~ "21-MATERIALES DE CURACIÓN",
    cod_sigfe == "2204004004"~ "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
    cod_sigfe == "2204004005"~ "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
    cod_sigfe == "2204004006"~ "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
    
    cod_sigfe == "2204005"~ "Familia",
    cod_sigfe == "2204005001"~ "18-MATERIAL MEDICO QUIRURGICO",
    cod_sigfe == "2204005002"~ "18-MATERIAL MEDICO QUIRURGICO",
    cod_sigfe == "2204005003"~ "18-MATERIAL MEDICO QUIRURGICO",
    
    cod_sigfe == "2204007"~ "Familia",
    cod_sigfe == "2204007002"~ "29-MATERIALES Y ELEMENTOS DE ASEO",
    
    cod_sigfe == "2204008"~ "31-MENAJE PARA OFICINA, CASINO Y OTROS",
    cod_sigfe == "2204009"~ "27-MATERIALES INFORMATICOS",
    cod_sigfe == "2204010"~ "28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
    
    cod_sigfe == "2204011"~ "44-REPUESTOS Y ACCESORIOS PARA MANTENIMIENTO Y REPARACIONES DE VEHICULOS",
    cod_sigfe == "2204012"~ "35-OTROS INSUMOS Y MATERIALES",
    cod_sigfe == "2204013"~ "8-EQUIPOS MENORES",
    cod_sigfe == "2204015"~ "25-MATERIALES DE USO O CONSUMO",
    
    #Gastos Generales
    cod_sigfe == "2204006"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2204007001"~ "178-SERVICIO DE LAVANDERÍA",
    cod_sigfe == "2204014"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2204999"~ "145-OTROS GASTOS GENERALES",
    
    cod_sigfe == "2205"~ "Familia",
    cod_sigfe == "2205001"~ "92-SERVICIO DE ENERGÍA",
    cod_sigfe == "2205002"~ "48-SERVICIO DE AGUA",
    cod_sigfe == "2205003"~ "100-GAS PROPANO",
    cod_sigfe == "2205004"~ "179-SERVICIO DE MENSAJERIA Y/O CORREO",
    cod_sigfe == "2205005"~ "192-SERVICIO DE TELECOMUNICACIONES",
    cod_sigfe == "2205006"~ "93-ENLACES DE TELECOMUNICACIONES",
    cod_sigfe == "2205007"~ "93-ENLACES DE TELECOMUNICACIONES",
    cod_sigfe == "2205999"~ "188-SERVICIOS GENERALES",
    
    cod_sigfe == "2206"~ "Familia",
    cod_sigfe == "2206001"~ "133-MANTENIMIENTO PLANTA FÍSICA",
    
    cod_sigfe == "2206002"~ "Familia",
    cod_sigfe == "2206002001"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    cod_sigfe == "2206002002"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    cod_sigfe == "2206002003"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    cod_sigfe == "2206002004"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    cod_sigfe == "2206002005"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    cod_sigfe == "2206002006"~ "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
    
    cod_sigfe == "2206003"~ "132-MANTENIMIENTO MUEBLES Y ENSERES",
    cod_sigfe == "2206004"~ "131-MANTENIMIENTO MAQUINARIA Y EQUIPO",
    
    cod_sigfe == "2206005"~ "Familia",
    cod_sigfe == "2206005001"~ "131-MANTENIMIENTO MAQUINARIA Y EQUIPO",
    cod_sigfe == "2206005002"~ "131-MANTENIMIENTO MAQUINARIA Y EQUIPO",

    cod_sigfe == "2206006"~ "Familia",
    cod_sigfe == "2206006001"~ "138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
    cod_sigfe == "2206006002"~ "137-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO",
    cod_sigfe == "2206006003"~ "138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
    cod_sigfe == "2206006004"~ "137-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO",
    
    cod_sigfe == "2206007"~ "129-MANTENIMIENTO EQUIPO DE CÓMPUTO",
    cod_sigfe == "2206999"~ "147-OTROS MANTENIMIENTOS",
    
    cod_sigfe == "2207"~ "Familia",
    cod_sigfe == "2207001"~ "158-PUBLICIDAD Y PROPAGANDA",
    cod_sigfe == "2207002"~ "158-PUBLICIDAD Y PROPAGANDA",
    cod_sigfe == "2207003"~ "158-PUBLICIDAD Y PROPAGANDA",
    cod_sigfe == "2207999"~ "158-PUBLICIDAD Y PROPAGANDA",
    
    cod_sigfe == "2208"~ "Familia",
    cod_sigfe == "2208001"~ "170-SERVICIO DE ASEO",
    cod_sigfe == "2208002"~ "182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
    cod_sigfe == "2208003"~ "128-MANTENIMIENTO DE PRADOS Y JARDINES",
    
    cod_sigfe == "2208007"~ "151-PASAJES, FLETES Y BODEGAJE",
    cod_sigfe == "2208008"~ "161-SALA CUNAS Y/O SERVICIOS INFANTILES",
    cod_sigfe == "2208009"~ "188-SERVICIOS GENERALES",
    cod_sigfe == "2208010"~ "188-SERVICIOS GENERALES",
    cod_sigfe == "2208999"~ "188-SERVICIOS GENERALES",
    
    cod_sigfe == "2209"~ "Familia",
    cod_sigfe == "2209001"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209002"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209003"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209004"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209005"~ "Familia",
    cod_sigfe == "2209005001"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209005002"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209006"~ "52-ARRENDAMIENTOS",
    cod_sigfe == "2209999"~ "52-ARRENDAMIENTOS",
    
    cod_sigfe == "2210"~ "Familia",
    cod_sigfe == "2210001"~ "168-SEGUROS GENERALES",
    cod_sigfe == "2210002"~ "168-SEGUROS GENERALES",
    cod_sigfe == "2210003"~ "168-SEGUROS GENERALES",
    cod_sigfe == "2210004"~ "168-SEGUROS GENERALES",
    cod_sigfe == "2210999"~ "168-SEGUROS GENERALES",
    
    cod_sigfe == "2211"~ "Familia",
    cod_sigfe == "2211001"~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2211002"~ "Familia",
    cod_sigfe == "2211002001"~ "Familia",
    cod_sigfe == "221100200101"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200102"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200103"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200201"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200202"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200203"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200301"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200302"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200303"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200401"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200402"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200403"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200501"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200502"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200503"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200601"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "221100200602"~ "76-CURSOS DE CAPACITACIÓN",
    cod_sigfe == "2211003"~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2211999"~ "66-COMPRA DE OTROS SERVICIOS",
    
    cod_sigfe == "2212"~ "Familia",
    cod_sigfe == "2212002"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212003"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212004"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212005"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212006"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212999"~ "Familia",
    cod_sigfe == "2212999001"~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2212999002"~ "Familia",
    cod_sigfe == "221299900201"~ "177-SERVICIO DE LABORATORIO",
    cod_sigfe == "221299900202"~ "177-SERVICIO DE LABORATORIO",
    
    cod_sigfe == "2212999003"~ "Familia",
    cod_sigfe == "221299900302"~ "63-COMPRA DE INTERVENCIONES QUIRÚRGICAS CLÍNICAS",
    cod_sigfe == "2212999004"~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2212999005"~ "66-COMPRA DE OTROS SERVICIOS",
    
    cod_sigfe == "2212999006"~ "Familia",
    cod_sigfe == "221299900601"~ "57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA",
    cod_sigfe == "221299900602"~ "57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA",
    cod_sigfe == "221299900603"~ "57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA",
    
    cod_sigfe == "2212999009"~ "Familia",
    cod_sigfe == "221299900901"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "221299900902"~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "221299900903"~ "145-OTROS GASTOS GENERALES",
    
    cod_sigfe == "2212999010"~ "149-PASAJES Y TRASLADOS DE PACIENTES",
    cod_sigfe == "2212999011"~ "145-OTROS GASTOS GENERALES",
    
    cod_sigfe == "2212999014"~ "Familia",
    cod_sigfe == "221299901401"~ "59-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS CRÍTICAS",
    cod_sigfe == "221299901402"~ "60-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS NO CRÍTICAS",
    
    cod_sigfe == "2212999015" ~ "66-COMPRA DE OTROS SERVICIOS",
    
    cod_sigfe == "2212999017" ~ "145-OTROS GASTOS GENERALES",
    cod_sigfe == "2212999019" ~ "176-SERVICIO DE INTERMEDIACIÓN CENABAST",
    
    #RRHH
    cod_sigfe == "221299900301"~ "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO",
    cod_sigfe == "221299900302"~ "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO",
    
    cod_sigfe == "2212999016" ~ "Familia",
    cod_sigfe == "221299901601" ~ "61-COMPRA DE CONSULTAS MÉDICAS",
    cod_sigfe == "221299901602" ~ "62-COMPRA DE CONSULTAS NO MÉDICAS",
    
    cod_sigfe == "2212999018" ~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2212999020" ~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2212999021" ~ "66-COMPRA DE OTROS SERVICIOS",
    cod_sigfe == "2212999022" ~ "66-COMPRA DE OTROS SERVICIOS",
    TRUE ~ "Asignar Centro de Costo")) %>% 
  filter(SIGCOM != "Familia" & Devengado>0)

# M2 --------------------------------------------------------------
M2 <- read_excel(M2)
M2Pab <- read_excel(M2Pab) %>% filter(SIGCOM != "Total")
M2Pab <- mutate_all(M2Pab, ~replace(., is.na(.), 0))
Metros_pabellon <- 11*45

"473-QUIRÓFANOS MENOR AMBULATORIA" <- sum(M2Pab$`473-QUIRÓFANOS MENOR AMBULATORIA`)
"471-QUIRÓFANOS MAYOR AMBULATORIA" <- sum(M2Pab$`471-QUIRÓFANOS MAYOR AMBULATORIA`)

M2Pab <- M2Pab %>% select(SIGCOM, `Distribución cirugias Electivas`) %>% 
  group_by(SIGCOM) %>% 
  summarise("Distribución cirugias Electivas" =sum(`Distribución cirugias Electivas`)) %>% 
  ungroup()

M2Pab$`Distribución cirugias Electivas` <- ifelse(M2Pab$`Distribución cirugias Electivas`==0, M2Pab$`Distribución cirugias Electivas`+0.5, M2Pab$`Distribución cirugias Electivas`) 


df <- tibble(SIGCOM= as.character(c("473-QUIRÓFANOS MENOR AMBULATORIA", "471-QUIRÓFANOS MAYOR AMBULATORIA")), 
"Distribución cirugias Electivas"= c(`473-QUIRÓFANOS MENOR AMBULATORIA`, `471-QUIRÓFANOS MAYOR AMBULATORIA`))

M2Pab <- rbind(M2Pab, df)

M2Pab$Area <- "Quirofanos"

M2Pab <- M2Pab %>% mutate(Area = Area, CC = SIGCOM, 
                          M2=`Distribución cirugias Electivas`/sum(`Distribución cirugias Electivas`)*Metros_pabellon) %>% 
  select(Area, CC, M2)
  
M2 <- M2 %>% filter(Area != "Quirofanos")
M2 <- rbind(M2, M2Pab)

M2$prop <- M2$M2/sum(M2$M2) #asigna proporción a los M2

CAE_prorratear <- M2 %>% filter(Area == "Consultas" | Area == "Procedimientos")
CAE_prorratear$prop <- CAE_prorratear$M2/sum(CAE_prorratear$M2)

M2Pab$prop <- M2Pab$M2/sum(M2Pab$M2)

# Prorrateo Gastos Generales por M2 ---------------------------------------

cuentas <- c("48-SERVICIO DE AGUA",
             "182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
             "170-SERVICIO DE ASEO",
             "92-SERVICIO DE ENERGÍA",
             "179-SERVICIO DE MENSAJERIA Y/O CORREO",
             "100-GAS PROPANO",
             "133-MANTENIMIENTO PLANTA FÍSICA",
             "158-PUBLICIDAD Y PROPAGANDA",
             "93-ENLACES DE TELECOMUNICACIONES",
             "188-SERVICIOS GENERALES",
             "192-SERVICIO DE TELECOMUNICACIONES",
             "128-MANTENIMIENTO DE PRADOS Y JARDINES")

GG1 <- data.frame(
  "Centro de Costo" = "eliminar", 
  "Devengado" = 0, 
  "Cuenta" = "eliminar",
  "Tipo" = 1)
colnames(GG1)[1] <- "Centro de Costo"
GG1_nulo <- GG1
GG44 <- GG1_nulo
GG33 <- GG1_nulo

for (i in cuentas) {
  if(i %in% SIGFE$SIGCOM){
    GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                             Devengado = Devengado*M2$prop, 
                             "Cuenta"=i, "Tipo" = 1) 
    GG1 <- rbind(GG1,GG2) %>% filter(Cuenta!="eliminar")}
    else {GG2 <- GG1_nulo
    GG1 <- rbind(GG1,GG2) %>% filter(Cuenta!="eliminar")}
      
                               
    }

# Gastos Generales con Asignación Directa ---------------------------------

b <- "57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "713-TRABAJO SOCIAL", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

b <- "59-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS CRÍTICAS"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

b <- "145-OTROS GASTOS GENERALES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "670-ADMINISTRACIÓN", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

b <- "168-SEGUROS GENERALES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "670-ADMINISTRACIÓN", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

b <- "177-SERVICIO DE LABORATORIO"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "518-LABORATORIO CLÍNICO", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

b <- "181-SERVICIO DE TRANSPORTE" #No lo captura y tampoco sale en la OOTT
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = "664-TRANSPORTE GENERAL", 
                         Devengado = Devengado, 
                         "Cuenta"=b, "Tipo" = 4)
GG1 <- rbind(GG1,GG2)}

# Prorrateos Especificos --------------------------------------------------
#FARMACIA
Farm <- read_excel(Farmacia)

b <- "30-MEDICAMENTOS"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = Farm$perc, 
                         Devengado = Devengado*Farm$gasto, 
                         "Cuenta"=b, "Tipo" = 3)
GG1 <- rbind(GG1,GG2)}

b <- "176-SERVICIO DE INTERMEDIACIÓN CENABAST"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = Farm$perc, 
                         Devengado = Devengado*Farm$gasto, 
                         "Cuenta"=b, "Tipo" = 2)
GG1 <- rbind(GG1,GG2)}


# EQUIPOS MEDICOS
EqMed <- read_excel(EqMed, na = " ")
EqMed <- mutate_all(EqMed, ~replace(., is.na(.), 0))

EqMedPrev <- EqMed %>%  filter (`PERC ASOCIADO` != 0) %>% 
  select(`PERC ASOCIADO`, `Mantención Preventiva`) %>% 
  group_by (`PERC ASOCIADO`) %>% 
  summarise("Mant_preventiva" = sum(`Mantención Preventiva`)) %>%
    ungroup()

EqMedPrev$prop <- EqMedPrev$Mant_preventiva/sum(EqMedPrev$Mant_preventiva)


EqMedCorrec <- EqMed %>%  filter (`PERC ASOCIADO` != 0) %>% 
  select(`PERC ASOCIADO`, `Mantención Correctiva`) %>% 
  group_by (`PERC ASOCIADO`) %>% 
  summarise("Mant_correctiva" = sum(`Mantención Correctiva`)) %>%
  ungroup()

EqMedCorrec$prop <- EqMedCorrec$Mant_correctiva/sum(EqMedCorrec$Mant_correctiva)

b <- "137-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = EqMedCorrec$`PERC ASOCIADO`, 
                         Devengado = Devengado*EqMedCorrec$prop, 
                         "Cuenta"=b, "Tipo" = 3)
GG1 <- rbind(GG1,GG2)}

b <- "138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = EqMedPrev$`PERC ASOCIADO`, 
                         Devengado = Devengado*EqMedPrev$prop, 
                         "Cuenta"=b, "Tipo" = 3)
GG1 <- rbind(GG1,GG2)}

# CAPACITACION

cant_RRHH <- read_excel(Cant_RRHH)
cant_RRHH <- cant_RRHH %>% select(perc, horas_mensuales) %>% 
  group_by (perc) %>% 
  summarise("horas_mensuales" = sum(horas_mensuales)) %>%
  ungroup()

cant_RRHH$prop <- cant_RRHH$horas_mensuales/sum(cant_RRHH$horas_mensuales)

b <- "76-CURSOS DE CAPACITACIÓN"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = cant_RRHH$perc, 
                           "Devengado" = Devengado*cant_RRHH$prop, 
                           "Cuenta"=b, "Tipo" = 2)
  GG1 <- rbind(GG1,GG2)} 

b <- "161-SALA CUNAS Y/O SERVICIOS INFANTILES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = cant_RRHH$perc, 
                         "Devengado" = Devengado*cant_RRHH$prop, 
                         "Cuenta"=b, "Tipo" = 2)
GG1 <- rbind(GG1,GG2)}

# Consumo x CC ------------------------------------------------------------

CxCC <- read_excel(ConsumoxCC, range = "A3:M5000", na = "eliminar")
CxCC <- CxCC %>%  filter (`ITEM PRESUPUESTARIO` != "eliminar", PRECIO != 0) %>% 
  mutate(item_pres=`ITEM PRESUPUESTARIO`, Total=`CANTIDAD DESPACHADA`*PRECIO, CC=`CENTRO DE COSTO`) %>% 
  mutate(ItemxCC = case_when(item_pres ==	"4001000"	~	"24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
                             item_pres ==	"4007002"	~	"29-MATERIALES Y ELEMENTOS DE ASEO",
                             item_pres ==	"4008000"	~	"31-MENAJE PARA OFICINA, CASINO Y OTROS",
                                 item_pres ==	"4005000"	~	"18-MATERIAL MEDICO QUIRURGICO",
                                 item_pres ==	"4005003"	~	"18-MATERIAL MEDICO QUIRURGICO",
                                 item_pres ==	"2001000"	~	"43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                                 item_pres ==	"4003002"	~	"41-PRODUCTOS QUÍMICOS",
                                 item_pres ==	"12999006"	~	"57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA",
                                 item_pres ==	"29004000"	~	"No considerar",
                                 item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                                 item_pres ==	"2002002"	~	"43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                                 item_pres ==	"2905001001"	~	"No considerar",
                                 item_pres ==	"9005002"	~	"52-ARRENDAMIENTOS",
                                 item_pres ==	"4010000"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                                 item_pres ==	"4009000"	~	"27-MATERIALES INFORMATICOS",
                                 item_pres ==	"4004004"	~	"16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
                             item_pres ==	"4004003"	~	"21-MATERIALES DE CURACIÓN",
                                 item_pres ==	"12999002"	~	"177-SERVICIO DE LABORATORIO",
                                 item_pres ==	"29051000"	~	"No considerar	",
                                 item_pres ==	"4999000"	~	"35-OTROS INSUMOS Y MATERIALES",
                                 item_pres ==	"9005000"	~	"52-ARRENDAMIENTOS",
                                 item_pres ==	"12999003"	~	"65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO",
                                 item_pres ==	"4005002"	~	"18-MATERIAL MEDICO QUIRURGICO",
                                 item_pres ==	"4004001"	~	"30-MEDICAMENTOS",
                                 item_pres ==	"29005002"	~	"No considerar",
                                 item_pres ==	"8007000"	~	"151-PASAJES, FLETES Y BODEGAJE",
                                 item_pres ==	"400400101"	~	"30-MEDICAMENTOS",
                                 item_pres ==	"4004002"	~	"15-MATERIAL DE ODONTOLOGÍA",
                                 item_pres ==	"8001000"	~	"170-SERVICIO DE ASEO",
                                 item_pres ==	"1001000"	~	"46-VÍVERES",
                                 item_pres ==	"04013.00"	~	"8-EQUIPOS MENORES",
                                 item_pres ==	"6006000"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                                 item_pres ==	"5003000"	~	"100-GAS PROPANO",
                                 item_pres ==	"31.02.005"	~	"No considerar",
                                 item_pres ==	"4010000"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                                 item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                                 item_pres ==	"2905001001"	~	"No considerar",
                                 item_pres ==	"9006000"	~	"52-ARRENDAMIENTOS",
                                 item_pres ==	"5002000"	~	"48-SERVICIO DE AGUA",
                                 item_pres ==	"5001000"	~	"92-SERVICIO DE ENERGÍA",
                                 item_pres ==	"31.02.004"	~	"No considerar",
                                 item_pres ==	"12999014"	~	"59-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS CRÍTICAS",
                                 item_pres ==	"4007002"	~	"29-MATERIALES Y ELEMENTOS DE ASEO	",
                                 item_pres ==	"8001000"	~	"170-SERVICIO DE ASEO",
                                 item_pres ==	"11002001.1"	~	"76-CURSOS DE CAPACITACIÓN",
                                 item_pres ==	"9005002"	~	"52-ARRENDAMIENTOS",
                                 item_pres ==	"6006001"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                                 item_pres ==	"14001.00"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                                 item_pres ==	"29004000"	~	"No considerar",
                                 item_pres ==	"5004000"	~	"179-SERVICIO DE MENSAJERIA Y/O CORREO",
                                 item_pres ==	"31.02.005"	~	"No considerar",
                                 item_pres ==	"31.02.006"	~	"No considerar",
                                 item_pres ==	"6001000"	~	"133-MANTENIMIENTO PLANTA FÍSICA",
                                 item_pres ==	"6006002"	~	"137-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO",
                                 item_pres ==	"29005002"	~	"No considerar",
                                 item_pres ==	"31.02.004"	~	"No considerar",
                                 item_pres ==	"31.02.999"	~	"No considerar",
                                 item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                                 item_pres ==	"6006000"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                                 item_pres ==	"2905001001"	~	"No considerar",
                                 item_pres ==	"12999010"	~	"149-PASAJES Y TRASLADOS DE PACIENTES",
                                 item_pres ==	"8002000"	~	"182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
                                 item_pres ==	"6002000"	~	"135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
                                 item_pres ==	"6007000"	~	"147-OTROS MANTENIMIENTOS",
                                 item_pres ==	"29059000"	~	"No considerar",
                                 item_pres ==	"11001000"	~	"76-CURSOS DE CAPACITACIÓN",
                                 item_pres ==	"12999009"	~	"Agrupado",
                                 item_pres ==	"7003000"	~	"Agrupado",
                             item_pres ==	"12999002"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"12.999.002"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"11003000"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"9999000"	~	"66-COMPRA DE OTROS SERVICIOS",
                                 TRUE ~ "Asignar Item Presupuestario"),
         CC=case_when(CC=="DIRECCION HOSP. ROBERTO DEL RI"~"670-ADMINISTRACIÓN",
                      CC=="RELACIONES PUBLICAS"~"670-ADMINISTRACIÓN",
                      CC=="OIRS"~"670-ADMINISTRACIÓN",
                      CC=="SD.GESTION DEL CUIDADO"~"670-ADMINISTRACIÓN",
                      CC=="ANATOMIA PATOLOGICA"~"544-ANATOMÍA PATOLÓGICA",
                      CC=="SERVICIO SOCIAL PACIENTES"~"713-TRABAJO SOCIAL",
                      CC=="ADM PEDIATRIA"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL C (AISLA"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD DE CUIDADOS INTENSIVOS"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                      CC=="UNIDAD TRATAMIENTO INTERMEDIO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
                      CC=="SALA CUIDADO PROLONGADO"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                      CC=="U.C.I. CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
                      CC=="UTI CARDIOVASCULAR"~"198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
                      CC=="UNIDAD ONCOLOGIA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
                      CC=="PABELLON CARDIOLOGIA"~"464-QUIRÓFANOS CARDIOVASCULAR",
                      CC=="CIRUGIA PLASTICA Y QUEMADOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="TRAUMATOLOGIA GENERAL"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                      CC=="CAE CONS. BRONCOPULMONAR"~"282-CONSULTA NEUMOLOGÍA",
                      CC=="CAE LAB. BRONCOPULMONAR"~"244-PROCEDIMIENTO DE NEUMOLOGÍA",
                      CC=="CAE CARDIOLOGIA"~"276-CONSULTA CARDIOLOGÍA",
                      CC=="CAE CIRUGIA GENERAL"~"351-CONSULTA CIRUGÍA PEDIÁTRICA",
                      CC=="CAE DERMATOLOGIA"~"277-CONSULTA DERMATOLOGÍA",
                      CC=="CAE ENDOCRINOLOGIA"~"281-CONSULTA ENDOCRINOLOGÍA",
                      CC=="CAE GASTROENTEROLOGIA"~"290-CONSULTA GASTROENTEROLOGÍA",
                      CC=="CAE ONCOLOGIA"~"306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                      CC=="CAE CONS. NEFROLOGIA"~"285-CONSULTA NEFROLOGÍA",
                      CC=="CAE CONS. NEUROLOGIA"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                      CC=="CAE LAB. EEG NEUROLOGIA"~"269-PROCEDIMIENTOS DE NEUROLOGÍA",
                      CC=="CAE CONS. OTORRINOLARINGOLOGIA"~"319-CONSULTA OTORRINOLARINGOLOGÍA",
                      CC=="CENTRAL DE PROCEDIMIENTOS"~"473-QUIRÓFANOS MENOR AMBULATORIA",
                      CC=="CAE ODONTOLOGIA"~"356-CONSULTA ODONTOLOGÍA",
                      CC=="CAE SALUD MENTAL AMBULATORIO"~"280-CONSULTA PSIQUIATRÍA",
                      CC=="SALUD MENTAL HOSPITALIZADOS"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
                      CC=="IMAGENOLOGIA"~"542-IMAGENOLOGÍA",
                      CC=="UNIDAD DE EMERGENCIA"~"216-EMERGENCIAS PEDIÁTRICAS",
                      CC=="LABORATORIO CLINICO"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO HEMATOLOGIA"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO MICROBIOLOGIA"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO URGENCIA Y QCA"~"518-LABORATORIO CLÍNICO",
                      CC=="LAB.CITOMETRIA DE FLUJO"~"518-LABORATORIO CLÍNICO",
                      CC=="BANCO DE SANGRE"~"575-BANCO DE SANGRE",
                      CC=="PERSONAL"~"670-ADMINISTRACIÓN",
                      CC=="ABASTECIMIENTO"~"670-ADMINISTRACIÓN",
                      CC=="FARMACIA"~"593-SERVICIO FARMACEUTICO",
                      CC=="ESTERILIZACION"~"662-CENTRAL DE ESTERILIZACIÓN",
                      CC=="ALIMENTACION"~"652-SERVICIO DE ALIMENTACIÓN",
                      CC=="RECURSOS FISICOS"~"670-ADMINISTRACIÓN",
                      CC=="INFRAESTRUCTURA"~"670-ADMINISTRACIÓN",
                      CC=="HIGIENE HOSPITALARIA"~"648-ASEO",
                      CC=="TRANSPORTE Y COMUNICACIONES"~"664-TRANSPORTE GENERAL",
                      CC=="JARDIN INFANTIL DR. A. VIGNAU"~"670-ADMINISTRACIÓN",
                      CC=="SOME"~"670-ADMINISTRACIÓN",
                      CC=="INFORMATICA"~"670-ADMINISTRACIÓN",
                      CC=="RESIDENCIA MEDICA 4TO PISO"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="PABELLON HEMODINAMIA"~"240-PROCEDIMIENTO DE CARDIOLOGÍA",
                      CC=="CAE CENTRO HEMOFILICO"~"306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                      CC=="CAPACITACION"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPOS MEDICOS"~"665-MANTENIMIENTO",
                      CC=="CAE VIH"~"284-CONSULTA INFECTOLOGÍA",
                      CC=="UNIDAD PEDIATRIA GENERAL D"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="COMERCIALIZACION"~"670-ADMINISTRACIÓN",
                      CC=="GESTION INGRESO Y PERMANENCIA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD COORDINACION GES"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD DE GESTION DE DEMANDA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD DE REHABILITACION"~"567-REHABILITACIÓN",
                      CC=="EQUIPOS INDUSTRIALES"~"670-ADMINISTRACIÓN",
                      CC=="SERVICIOS GENERALES"~"664-TRANSPORTE GENERAL",
                      CC=="AUDITORIA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD CONTROL DEL GESTION"~"670-ADMINISTRACIÓN",
                      CC=="ADM QUIRURGICO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="CAE UROLOGIA"~"311-CONSULTA UROLOGÍA",
                      CC=="CAE CONS. OFTALMOLOGIA"~"317-CONSULTA OFTALMOLOGÍA",
                      CC=="SERVICIO SOCIAL PERSONAL"~"713-TRABAJO SOCIAL",
                      CC=="CONTABILIDAD Y PRESUPUESTO"~"670-ADMINISTRACIÓN",
                      CC=="SEGURIDAD"~"670-ADMINISTRACIÓN",
                      CC=="ASEO Y ORNATO PATIOS Y JARDINE"~"648-ASEO",
                      CC=="BIBLIOTECA"~"670-ADMINISTRACIÓN",
                      CC=="RESIDENCIA ENFERMERAS"~"670-ADMINISTRACIÓN",
                      CC=="ESTADISTICA"~"670-ADMINISTRACIÓN",
                      CC=="S.D.RR.HH"~"670-ADMINISTRACIÓN",
                      CC=="CHILE CRECE CONTIGO"~"713-TRABAJO SOCIAL",
                      CC=="UNIDAD ANALISIS REG.CLINICO"~"670-ADMINISTRACIÓN",
                      CC=="INFRAESTRUCTURA HOSPITAL"~"670-ADMINISTRACIÓN",
                      CC=="PREV.RIESGO Y S.OCUPACIONAL"~"670-ADMINISTRACIÓN",
                      CC=="SALA REAS"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPOS INDUSTRIALES(HOSPITAL)"~"670-ADMINISTRACIÓN",
                      CC=="I.A.A.S"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD ASISTENCIAL DOCENTE"~"670-ADMINISTRACIÓN",
                      CC=="LAB.BIOLOGIA MOLECULAR"~"518-LABORATORIO CLÍNICO",
                      CC=="CAE PREMATUROS"~"328-CONSULTA PEDIATRÍA GENERAL",
                      CC=="VACUNATORIO"~"328-CONSULTA PEDIATRÍA GENERAL",
                      CC=="OFICINA DE SUELDOS"~"670-ADMINISTRACIÓN",
                      CC=="SUBDIRECCION ADMINISTRATIVA"~"670-ADMINISTRACIÓN",
                      CC=="SUBDIRECCION MEDICA"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPAMIENTO HOSPITAL"~"670-ADMINISTRACIÓN",
                      CC=="BODEGAS ABASTECIMIENTO"~"670-ADMINISTRACIÓN",
                      CC=="CIRUGIA GENERAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="UNIDAD MEDICINA INTEGRATIVA"~"670-ADMINISTRACIÓN",
                      CC=="C.COSTO GLOBAL"~"670-ADMINISTRACIÓN",
                      CC=="GASTOS HOSPITAL"~"670-ADMINISTRACIÓN",
                      CC=="CAE QUEMADOS"~"316-CONSULTA CIRUGÍA PLÁSTICA",
                      CC=="CAE PROCED. NEFROLOGIA"~"285-CONSULTA NEFROLOGÍA",
                      CC=="GESTION DE USUARIOS"~"670-ADMINISTRACIÓN",
                      CC=="ADM CARDIOLOGIA"~"276-CONSULTA CARDIOLOGÍA",
                      CC=="UNIDAD PRE QUIRURGICA"~"471-QUIRÓFANOS MAYOR AMBULATORIA",
                      CC=="CAE ESPECIALIDADES 2"~"Cae Prorratear",
                      CC=="CAE ADMINISTRACION"~"Cae Prorratear",
                      CC=="PABELLONES"~"Pabellón Prorratear",
                      TRUE ~ "Asignar CC"
         )) %>% 
  select(item_pres, CC,ItemxCC, Total) %>% 
  group_by (item_pres, CC,ItemxCC,) %>% 
  summarise("Total" = sum(Total)) %>%
  ungroup()
#tengo que agarrar cada item de GG y multriplicarlo por SIGFE
# despues agarro los de insumos y lo mismo

# CxCC Historico ----------------------------------------------------------
CxCC_H <- read_excel(CxCC_H, range = "A3:M90000", na = "eliminar")
CxCC_H <- CxCC_H %>%  filter (`ITEM PRESUPUESTARIO` != "eliminar", PRECIO != 0) %>% 
  mutate(item_pres=`ITEM PRESUPUESTARIO`, Total=`CANTIDAD DESPACHADA`*PRECIO, CC=`CENTRO DE COSTO`) %>% 
  mutate(ItemxCC = case_when(item_pres ==	"4001000"	~	"24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
                             item_pres ==	"4007002"	~	"29-MATERIALES Y ELEMENTOS DE ASEO",
                             item_pres ==	"4008000"	~	"31-MENAJE PARA OFICINA, CASINO Y OTROS",
                             item_pres ==	"4005000"	~	"18-MATERIAL MEDICO QUIRURGICO",
                             item_pres ==	"4005003"	~	"18-MATERIAL MEDICO QUIRURGICO",
                             item_pres ==	"2001000"	~	"43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                             item_pres ==	"4003002"	~	"41-PRODUCTOS QUÍMICOS",
                             item_pres ==	"12999006"	~	"57-COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA",
                             item_pres ==	"29004000"	~	"No considerar",
                             item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                             item_pres ==	"2002002"	~	"43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                             item_pres ==	"2905001001"	~	"No considerar",
                             item_pres ==	"9005002"	~	"52-ARRENDAMIENTOS",
                             item_pres ==	"4010000"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                             item_pres ==	"4009000"	~	"27-MATERIALES INFORMATICOS",
                             item_pres ==	"4004004"	~	"16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
                             item_pres ==	"4004003"	~	"21-MATERIALES DE CURACIÓN",
                             item_pres ==	"12999002"	~	"177-SERVICIO DE LABORATORIO",
                             item_pres ==	"29051000"	~	"No considerar	",
                             item_pres ==	"4999000"	~	"35-OTROS INSUMOS Y MATERIALES",
                             item_pres ==	"9005000"	~	"52-ARRENDAMIENTOS",
                             item_pres ==	"12999003"	~	"65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO",
                             item_pres ==	"4005002"	~	"18-MATERIAL MEDICO QUIRURGICO",
                             item_pres ==	"4004001"	~	"30-MEDICAMENTOS",
                             item_pres ==	"29005002"	~	"No considerar",
                             item_pres ==	"8007000"	~	"151-PASAJES, FLETES Y BODEGAJE",
                             item_pres ==	"400400101"	~	"30-MEDICAMENTOS",
                             item_pres ==	"4004002"	~	"15-MATERIAL DE ODONTOLOGÍA",
                             item_pres ==	"8001000"	~	"170-SERVICIO DE ASEO",
                             item_pres ==	"1001000"	~	"46-VÍVERES",
                             item_pres ==	"04013.00"	~	"8-EQUIPOS MENORES",
                             item_pres ==	"6006000"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                             item_pres ==	"5003000"	~	"100-GAS PROPANO",
                             item_pres ==	"31.02.005"	~	"No considerar",
                             item_pres ==	"4010000"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                             item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                             item_pres ==	"2905001001"	~	"No considerar",
                             item_pres ==	"9006000"	~	"52-ARRENDAMIENTOS",
                             item_pres ==	"5002000"	~	"48-SERVICIO DE AGUA",
                             item_pres ==	"5001000"	~	"92-SERVICIO DE ENERGÍA",
                             item_pres ==	"31.02.004"	~	"No considerar",
                             item_pres ==	"12999014"	~	"59-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS CRÍTICAS",
                             item_pres ==	"4007002"	~	"29-MATERIALES Y ELEMENTOS DE ASEO	",
                             item_pres ==	"8001000"	~	"170-SERVICIO DE ASEO",
                             item_pres ==	"11002001.1"	~	"76-CURSOS DE CAPACITACIÓN",
                             item_pres ==	"9005002"	~	"52-ARRENDAMIENTOS",
                             item_pres ==	"6006001"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                             item_pres ==	"14001.00"	~	"28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                             item_pres ==	"29004000"	~	"No considerar",
                             item_pres ==	"5004000"	~	"179-SERVICIO DE MENSAJERIA Y/O CORREO",
                             item_pres ==	"31.02.005"	~	"No considerar",
                             item_pres ==	"31.02.006"	~	"No considerar",
                             item_pres ==	"6001000"	~	"133-MANTENIMIENTO PLANTA FÍSICA",
                             item_pres ==	"6006002"	~	"137-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO",
                             item_pres ==	"29005002"	~	"No considerar",
                             item_pres ==	"31.02.004"	~	"No considerar",
                             item_pres ==	"31.02.999"	~	"No considerar",
                             item_pres ==	"4012000"	~	"35-OTROS INSUMOS Y MATERIALES",
                             item_pres ==	"6006000"	~	"138-MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO",
                             item_pres ==	"2905001001"	~	"No considerar",
                             item_pres ==	"12999010"	~	"149-PASAJES Y TRASLADOS DE PACIENTES",
                             item_pres ==	"8002000"	~	"182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
                             item_pres ==	"6002000"	~	"135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
                             item_pres ==	"6007000"	~	"147-OTROS MANTENIMIENTOS",
                             item_pres ==	"29059000"	~	"No considerar",
                             item_pres ==	"11001000"	~	"76-CURSOS DE CAPACITACIÓN",
                             item_pres ==	"12999009"	~	"Agrupado",
                             item_pres ==	"7003000"	~	"Agrupado",
                             item_pres ==	"12999002"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"12.999.002"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"11003000"	~	"66-COMPRA DE OTROS SERVICIOS",
                             item_pres ==	"9999000"	~	"66-COMPRA DE OTROS SERVICIOS",
                             TRUE ~ "Asignar Item Presupuestario"),
         CC=case_when(CC=="DIRECCION HOSP. ROBERTO DEL RI"~"670-ADMINISTRACIÓN",
                      CC=="RELACIONES PUBLICAS"~"670-ADMINISTRACIÓN",
                      CC=="OIRS"~"670-ADMINISTRACIÓN",
                      CC=="SD.GESTION DEL CUIDADO"~"670-ADMINISTRACIÓN",
                      CC=="ANATOMIA PATOLOGICA"~"544-ANATOMÍA PATOLÓGICA",
                      CC=="SERVICIO SOCIAL PACIENTES"~"713-TRABAJO SOCIAL",
                      CC=="ADM PEDIATRIA"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL C (AISLA"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="UNIDAD PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      
                      
                      
                      CC=="UNIDAD DE CUIDADOS INTENSIVOS"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                      CC=="UNIDAD TRATAMIENTO INTERMEDIO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
                      CC=="SALA CUIDADO PROLONGADO"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                      
                      CC=="U.C.I. CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
                      CC=="UTI CARDIOVASCULAR"~"198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
                      
                      
                      CC=="UNIDAD ONCOLOGIA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
                      CC=="PABELLON CARDIOLOGIA"~"464-QUIRÓFANOS CARDIOVASCULAR",
                      CC=="CIRUGIA PLASTICA Y QUEMADOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="TRAUMATOLOGIA GENERAL"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                      CC=="CAE CONS. BRONCOPULMONAR"~"282-CONSULTA NEUMOLOGÍA",
                      CC=="CAE LAB. BRONCOPULMONAR"~"244-PROCEDIMIENTO DE NEUMOLOGÍA",
                      CC=="CAE CARDIOLOGIA"~"276-CONSULTA CARDIOLOGÍA",
                      CC=="CAE CIRUGIA GENERAL"~"351-CONSULTA CIRUGÍA PEDIÁTRICA",
                      CC=="CAE DERMATOLOGIA"~"277-CONSULTA DERMATOLOGÍA",
                      CC=="CAE ENDOCRINOLOGIA"~"281-CONSULTA ENDOCRINOLOGÍA",
                      CC=="CAE GASTROENTEROLOGIA"~"290-CONSULTA GASTROENTEROLOGÍA",
                      CC=="CAE ONCOLOGIA"~"306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                      CC=="CAE CONS. NEFROLOGIA"~"285-CONSULTA NEFROLOGÍA",
                      CC=="CAE CONS. NEUROLOGIA"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                      CC=="CAE LAB. EEG NEUROLOGIA"~"269-PROCEDIMIENTOS DE NEUROLOGÍA",
                      CC=="CAE CONS. OTORRINOLARINGOLOGIA"~"319-CONSULTA OTORRINOLARINGOLOGÍA",
                      CC=="CENTRAL DE PROCEDIMIENTOS"~"473-QUIRÓFANOS MENOR AMBULATORIA",
                      CC=="CAE ODONTOLOGIA"~"356-CONSULTA ODONTOLOGÍA",
                      CC=="CAE SALUD MENTAL AMBULATORIO"~"280-CONSULTA PSIQUIATRÍA",
                      CC=="SALUD MENTAL HOSPITALIZADOS"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
                      CC=="IMAGENOLOGIA"~"542-IMAGENOLOGÍA",
                      CC=="UNIDAD DE EMERGENCIA"~"216-EMERGENCIAS PEDIÁTRICAS",
                      CC=="LABORATORIO CLINICO"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO HEMATOLOGIA"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO MICROBIOLOGIA"~"518-LABORATORIO CLÍNICO",
                      CC=="LABORATORIO URGENCIA Y QCA"~"518-LABORATORIO CLÍNICO",
                      CC=="LAB.CITOMETRIA DE FLUJO"~"518-LABORATORIO CLÍNICO",
                      CC=="BANCO DE SANGRE"~"575-BANCO DE SANGRE",
                      CC=="PERSONAL"~"670-ADMINISTRACIÓN",
                      CC=="ABASTECIMIENTO"~"670-ADMINISTRACIÓN",
                      CC=="FARMACIA"~"593-SERVICIO FARMACEUTICO",
                      CC=="ESTERILIZACION"~"662-CENTRAL DE ESTERILIZACIÓN",
                      CC=="ALIMENTACION"~"652-SERVICIO DE ALIMENTACIÓN",
                      CC=="RECURSOS FISICOS"~"670-ADMINISTRACIÓN",
                      CC=="INFRAESTRUCTURA"~"670-ADMINISTRACIÓN",
                      CC=="HIGIENE HOSPITALARIA"~"648-ASEO",
                      CC=="TRANSPORTE Y COMUNICACIONES"~"664-TRANSPORTE GENERAL",
                      CC=="JARDIN INFANTIL DR. A. VIGNAU"~"670-ADMINISTRACIÓN",
                      CC=="SOME"~"670-ADMINISTRACIÓN",
                      CC=="INFORMATICA"~"670-ADMINISTRACIÓN",
                      CC=="RESIDENCIA MEDICA 4TO PISO"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="PABELLON HEMODINAMIA"~"240-PROCEDIMIENTO DE CARDIOLOGÍA",
                      CC=="CAE CENTRO HEMOFILICO"~"306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                      CC=="CAPACITACION"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPOS MEDICOS"~"665-MANTENIMIENTO",
                      CC=="CAE VIH"~"284-CONSULTA INFECTOLOGÍA",
                      CC=="UNIDAD PEDIATRIA GENERAL D"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                      CC=="COMERCIALIZACION"~"670-ADMINISTRACIÓN",
                      CC=="GESTION INGRESO Y PERMANENCIA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD COORDINACION GES"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD DE GESTION DE DEMANDA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD DE REHABILITACION"~"567-REHABILITACIÓN",
                      CC=="EQUIPOS INDUSTRIALES"~"670-ADMINISTRACIÓN",
                      CC=="SERVICIOS GENERALES"~"664-TRANSPORTE GENERAL",
                      CC=="AUDITORIA"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD CONTROL DEL GESTION"~"670-ADMINISTRACIÓN",
                      CC=="ADM QUIRURGICO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="CAE UROLOGIA"~"311-CONSULTA UROLOGÍA",
                      CC=="CAE CONS. OFTALMOLOGIA"~"317-CONSULTA OFTALMOLOGÍA",
                      CC=="SERVICIO SOCIAL PERSONAL"~"713-TRABAJO SOCIAL",
                      CC=="CONTABILIDAD Y PRESUPUESTO"~"670-ADMINISTRACIÓN",
                      CC=="SEGURIDAD"~"670-ADMINISTRACIÓN",
                      CC=="ASEO Y ORNATO PATIOS Y JARDINE"~"648-ASEO",
                      CC=="BIBLIOTECA"~"670-ADMINISTRACIÓN",
                      CC=="RESIDENCIA ENFERMERAS"~"670-ADMINISTRACIÓN",
                      CC=="ESTADISTICA"~"670-ADMINISTRACIÓN",
                      CC=="S.D.RR.HH"~"670-ADMINISTRACIÓN",
                      CC=="CHILE CRECE CONTIGO"~"713-TRABAJO SOCIAL",
                      CC=="UNIDAD ANALISIS REG.CLINICO"~"670-ADMINISTRACIÓN",
                      CC=="INFRAESTRUCTURA HOSPITAL"~"670-ADMINISTRACIÓN",
                      CC=="PREV.RIESGO Y S.OCUPACIONAL"~"670-ADMINISTRACIÓN",
                      CC=="SALA REAS"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPOS INDUSTRIALES(HOSPITAL)"~"670-ADMINISTRACIÓN",
                      CC=="I.A.A.S"~"670-ADMINISTRACIÓN",
                      CC=="UNIDAD ASISTENCIAL DOCENTE"~"670-ADMINISTRACIÓN",
                      CC=="LAB.BIOLOGIA MOLECULAR"~"518-LABORATORIO CLÍNICO",
                      CC=="CAE PREMATUROS"~"328-CONSULTA PEDIATRÍA GENERAL",
                      CC=="VACUNATORIO"~"328-CONSULTA PEDIATRÍA GENERAL",
                      CC=="OFICINA DE SUELDOS"~"670-ADMINISTRACIÓN",
                      CC=="SUBDIRECCION ADMINISTRATIVA"~"670-ADMINISTRACIÓN",
                      CC=="SUBDIRECCION MEDICA"~"670-ADMINISTRACIÓN",
                      CC=="EQUIPAMIENTO HOSPITAL"~"670-ADMINISTRACIÓN",
                      CC=="BODEGAS ABASTECIMIENTO"~"670-ADMINISTRACIÓN",
                      CC=="CIRUGIA GENERAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                      CC=="UNIDAD MEDICINA INTEGRATIVA"~"670-ADMINISTRACIÓN",
                      CC=="C.COSTO GLOBAL"~"670-ADMINISTRACIÓN",
                      CC=="GASTOS HOSPITAL"~"670-ADMINISTRACIÓN",
                      
                      CC=="CAE QUEMADOS"~"316-CONSULTA CIRUGÍA PLÁSTICA",
                      CC=="CAE PROCED. NEFROLOGIA"~"285-CONSULTA NEFROLOGÍA",
                      CC=="GESTION DE USUARIOS"~"670-ADMINISTRACIÓN",
                      CC=="ADM CARDIOLOGIA"~"276-CONSULTA CARDIOLOGÍA",
                      CC=="UNIDAD PRE QUIRURGICA"~"471-QUIRÓFANOS MAYOR AMBULATORIA",
                      
                      CC=="CAE ESPECIALIDADES 2"~"Cae Prorratear",
                      CC=="CAE ADMINISTRACION"~"Cae Prorratear",
                      CC=="PABELLONES"~"Pabellón Prorratear",
                      TRUE ~ "Asignar CC"
         )) %>% 
  select(item_pres, CC,ItemxCC, Total) %>% 
  group_by (item_pres, CC,ItemxCC,) %>% 
  summarise("Total" = sum(Total)) %>%
  ungroup()

# Prorrateos GG x CxCC -------------------------------------------------------

cuentas <- c("52-ARRENDAMIENTOS",
             "60-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS NO CRÍTICAS",
             "61-COMPRA DE CONSULTAS MÉDICAS",
             "62-COMPRA DE CONSULTAS NO MÉDICAS",
             "63-COMPRA DE INTERVENCIONES QUIRÚRGICAS CLÍNICAS",
             "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO",
             "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO",
             "66-COMPRA DE OTROS SERVICIOS",
             "129-MANTENIMIENTO EQUIPO DE CÓMPUTO",
             "131-MANTENIMIENTO MAQUINARIA Y EQUIPO",
             "132-MANTENIMIENTO MUEBLES Y ENSERES",
             "135-MANTENIMIENTO Y REPARACION DE VEHICULOS", 
             "147-OTROS MANTENIMIENTOS",
             "151-PASAJES, FLETES Y BODEGAJE",
             "149-PASAJES Y TRASLADOS DE PACIENTES",
             "178-SERVICIO DE LAVANDERÍA",
             "3-COMBUSTIBLES Y LUBRICANTES", 
             "8-EQUIPOS MENORES", 
             "9-GASES MEDICINALES",
             "11-LIBROS, TEXTOS, UTILES DE ENSEÑANZA Y PUBLICACIONES",
             "15-MATERIAL DE ODONTOLOGÍA",
             "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
             "18-MATERIAL MEDICO QUIRURGICO",
             "21-MATERIALES DE CURACIÓN",
             "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
             "25-MATERIALES DE USO O CONSUMO",
             "27-MATERIALES INFORMATICOS",
             "28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
             "29-MATERIALES Y ELEMENTOS DE ASEO",
             "31-MENAJE PARA OFICINA, CASINO Y OTROS",
             "35-OTROS INSUMOS Y MATERIALES",
             "41-PRODUCTOS QUÍMICOS",
             "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
             "44-REPUESTOS Y ACCESORIOS PARA MANTENIMIENTO Y REPARACIONES DE VEHICULOS",
             "46-VÍVERES")

cuentas_total <- c("52-ARRENDAMIENTOS", 
                   "129-MANTENIMIENTO EQUIPO DE CÓMPUTO",
                   "131-MANTENIMIENTO MAQUINARIA Y EQUIPO",
                   "132-MANTENIMIENTO MUEBLES Y ENSERES",
                   "135-MANTENIMIENTO Y REPARACION DE VEHICULOS",
                   "147-OTROS MANTENIMIENTOS",
                   "151-PASAJES, FLETES Y BODEGAJE",
                   
                   "3-COMBUSTIBLES Y LUBRICANTES", 
                   "8-EQUIPOS MENORES", 
                   "9-GASES MEDICINALES",
                   "11-LIBROS, TEXTOS, UTILES DE ENSEÑANZA Y PUBLICACIONES",
                   "15-MATERIAL DE ODONTOLOGÍA",
                   "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
                   "18-MATERIAL MEDICO QUIRURGICO",
                   "21-MATERIALES DE CURACIÓN",
                   "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
                   "25-MATERIALES DE USO O CONSUMO",
                   "27-MATERIALES INFORMATICOS",
                   "28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                   "29-MATERIALES Y ELEMENTOS DE ASEO",
                   "31-MENAJE PARA OFICINA, CASINO Y OTROS",
                   "35-OTROS INSUMOS Y MATERIALES",
                   "41-PRODUCTOS QUÍMICOS",
                   "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                   "44-REPUESTOS Y ACCESORIOS PARA MANTENIMIENTO Y REPARACIONES DE VEHICULOS",
                   "46-VÍVERES")

cuentas_clinico <- c("149-PASAJES Y TRASLADOS DE PACIENTES",
                     "178-SERVICIO DE LAVANDERÍA",
                     "15-MATERIAL DE ODONTOLOGÍA",
                     "16-MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS",
                     "18-MATERIAL MEDICO QUIRURGICO",
                     "21-MATERIALES DE CURACIÓN",
                     "9-GASES MEDICINALES")

cuentas_qx <- c("63-COMPRA DE INTERVENCIONES QUIRÚRGICAS CLÍNICAS",
             "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO",
             "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO")

cuentas_cae <- c("61-COMPRA DE CONSULTAS MÉDICAS",
             "62-COMPRA DE CONSULTAS NO MÉDICAS")

cuentas_no_critico <- c("60-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS NO CRÍTICAS")

cuenta_insumos <- c("3-COMBUSTIBLES Y LUBRICANTES", 
                    "8-EQUIPOS MENORES", 
                    "11-LIBROS, TEXTOS, UTILES DE ENSEÑANZA Y PUBLICACIONES",
                    "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
                    "25-MATERIALES DE USO O CONSUMO",
                    "27-MATERIALES INFORMATICOS",
                    "28-MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES",
                    "29-MATERIALES Y ELEMENTOS DE ASEO",
                    "31-MENAJE PARA OFICINA, CASINO Y OTROS",
                    "35-OTROS INSUMOS Y MATERIALES",
                    "41-PRODUCTOS QUÍMICOS",
                    "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
                    "44-REPUESTOS Y ACCESORIOS PARA MANTENIMIENTO Y REPARACIONES DE VEHICULOS",
                    "46-VÍVERES")
 

for (i in cuentas) {
  
  if(i %in% SIGFE$SIGCOM & i %in% CxCC$ItemxCC){
  CCC <- CxCC %>% filter(ItemxCC == i) %>% 
    select(CC, Total) %>% 
    group_by (CC) %>% 
    summarise(Total =sum(Total)) %>%
    mutate("prop" = Total/sum(Total))
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == i)
  GG2 <- GG2 %>% summarise("Centro de Costo" = CCC$CC, 
                           Devengado = Devengado*CCC$prop, 
                           "Cuenta"=i, "Tipo" = 2) 
  GG1 <- rbind(GG1,GG2)}
  
  else if (i %in% SIGFE$SIGCOM & i %in% CxCC_H$ItemxCC){
      CCC <- CxCC_H %>% filter(ItemxCC == i) %>% 
        select(CC, Total) %>% 
        group_by (CC) %>% 
        summarise(Total =sum(Total)) %>%
        mutate("prop" = Total/sum(Total))
      GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
        summarise(Devengado = sum(Devengado)) %>% 
        filter(SIGCOM == i)
      GG2 <- GG2 %>% summarise("Centro de Costo" = CCC$CC, 
                               Devengado = Devengado*CCC$prop, 
                               "Cuenta"=i, "Tipo" = 2) 
      GG1 <- rbind(GG1,GG2)} 
  
  else if (i %in% SIGFE$SIGCOM){
    proporcion_exacta <- ifelse(i %in% cuentas_cae, "prorrateo_cae",
                                ifelse(i %in% cuentas_clinico, "prorrateo_clinico",
                                       ifelse(i %in% cuentas_qx, "prorrateo_qx", 
                                              ifelse(i %in% cuentas_no_critico, "prorrateo_no_critico", "todos"))))
    
    if (proporcion_exacta == "prorrateo_cae"){M2_exacto <- M2 %>% filter(Area == "Consultas")} 
    else if (proporcion_exacta == "prorrateo_clinico"){
      M2_exacto <- M2 %>% filter(Area != "Apoyo")}
    else if (proporcion_exacta == "prorrateo_qx"){
      M2_exacto <- M2 %>% filter(Area == "Quirofanos")}
    else if (proporcion_exacta == "prorrateo_no_critico"){
      M2_exacto <- M2 %>% filter(Area == "Hospitalización")}
    else{
      M2_exacto <- M2 %>% filter(Area!="No_existe")}
    
    M2_exacto$prop <- M2_exacto$M2/sum(M2_exacto$M2)
    
    GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    GG2 <- GG2 %>% summarise("Centro de Costo" = M2_exacto$CC, 
                             Devengado = Devengado*M2_exacto$prop, 
                             "Cuenta"=i, "Tipo" = 2)
    GG1 <- rbind(GG1,GG2)}
  
  else  {GG2 <- GG1_nulo
  GG1 <- rbind(GG1,GG2) %>% filter(Cuenta!="eliminar")}
  }


# Centros de Costo Globales -----------------------------------------------

Compras_Servicios <- GG1 %>% filter (Cuenta == "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO" |
                                       Cuenta == "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO")
sum(Compras_Servicios$Devengado)

GG1 <- GG1 %>% filter (Cuenta != "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO" &
                         Cuenta != "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO")

GG4 <- GG1 %>% filter (`Centro de Costo`== "Pabellón Prorratear")
GG3 <- GG1 %>% filter (`Centro de Costo`== "Cae Prorratear")

GG1 <- GG1 %>% filter(`Centro de Costo`!="Pabellón Prorratear" & 
                        `Centro de Costo`!="Cae Prorratear")

#PABELLON

qx <- c("464-QUIRÓFANOS CARDIOVASCULAR",
        "467-QUIRÓFANOS DIGESTIVA", 
        "475-QUIRÓFANOS NEUROCIRUGÍA",
        "478-QUIRÓFANOS OFTALMOLOGÍA",
        "480-QUIRÓFANOS OTORRINOLARINGOLOGÍA",
        "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
        "486-QUIRÓFANOS UROLOGÍA",
        "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
        "495-QUIRÓFANOS CIRUGÍA VASCULAR",
        "473-QUIRÓFANOS MENOR AMBULATORIA",
        "471-QUIRÓFANOS MAYOR AMBULATORIA")


for (i in qx) {
  # qx <- "464-QUIRÓFANOS CARDIOVASCULAR"
  q <- sum(ifelse(M2Pab$CC == i, M2Pab$prop, 0))
  GG2 <- GG4 %>% filter(`Centro de Costo`=="Pabellón Prorratear") %>% 
    summarise("Centro de Costo" = i,
              Devengado = Devengado*q,
              "Cuenta"= Cuenta,"Tipo" = 2)
  GG44 <- rbind(GG44, GG2) %>% filter(Cuenta!="eliminar")
}


am <- c("240-PROCEDIMIENTO DE CARDIOLOGÍA",
        "244-PROCEDIMIENTO DE NEUMOLOGÍA",
        "249-PROCEDIMIENTOS DE DERMATOLOGÍA",
        "250-PROCEDIMIENTOS DE GASTROENTEROLOGÍA",
        "261-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA",
        "262-PROCEDIMIENTOS DE TRAUMATOLOGÍA",
        "269-PROCEDIMIENTOS DE NEUROLOGÍA",
        "351-CONSULTA CIRUGÍA PEDIÁTRICA",
        "230-CONSULTA NUTRICIÓN",
        "275-CONSULTA REUMATOLOGÍA",
        "276-CONSULTA CARDIOLOGÍA",
        "277-CONSULTA DERMATOLOGÍA",
        "280-CONSULTA PSIQUIATRÍA",
        "281-CONSULTA ENDOCRINOLOGÍA",
        "282-CONSULTA NEUMOLOGÍA",
        "284-CONSULTA INFECTOLOGÍA",
        "285-CONSULTA NEFROLOGÍA",
        "286-CONSULTA GENÉTICA",
        "289-CONSULTA FISIATRÍA",
        "290-CONSULTA GASTROENTEROLOGÍA",
        "292-CONSULTA NEUROCIRUGÍA",
        "296-CONSULTA ANESTESIOLOGIA",
        "306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
        "311-CONSULTA UROLOGÍA",
        "316-CONSULTA CIRUGÍA PLÁSTICA",
        "317-CONSULTA OFTALMOLOGÍA",
        "319-CONSULTA OTORRINOLARINGOLOGÍA",
        "328-CONSULTA PEDIATRÍA GENERAL",
        "331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
        "342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
        "353-CONSULTA GINECOLOGICA",
        "356-CONSULTA ODONTOLOGÍA",
        "359-TELEMEDICINA")


for (i in am) {

  a <- sum(ifelse(CAE_prorratear$CC == i, CAE_prorratear$prop, 0))
  GG2 <- GG3 %>% filter(`Centro de Costo`=="Cae Prorratear") %>% 
    summarise("Centro de Costo" = i,
              Devengado = Devengado*a,
              "Cuenta"= Cuenta,"Tipo" = 2)
  GG33 <- rbind(GG33, GG2) %>% filter(Cuenta!="eliminar")
}

GG1 <- rbind(GG33,GG44,GG1)

  
#Redondeo el Devengado 
GG1 <- GG1 %>%  filter (Devengado != 0) %>% 
  summarise("Centro de Costo"= `Centro de Costo`,"Devengado" = round(Devengado),
            "Cuenta"=Cuenta,"Tipo"=Tipo) %>%
  ungroup()

# Asigna CC actualizados al 2022 ------------------------------------------
GG1 <- GG1 %>% mutate(`Centro de Costo` = 
                        case_when(
                          `Centro de Costo` ==	"478-QUIRÓFANOS OFTALMOLOGÍA"	~	"471-QUIRÓFANOS MAYOR AMBULATORIA",
                          `Centro de Costo` ==	"480-QUIRÓFANOS OTORRINOLARINGOLOGÍA"	~	"471-QUIRÓFANOS MAYOR AMBULATORIA",
                          `Centro de Costo` == "273-CONSULTA MEDICINA INTERNA"~"15102-CONSULTA MEDICINA INTERNA",
                          `Centro de Costo` == "274-CONSULTA NEUROLOGÍA"~"15103-CONSULTA NEUROLOGÍA",
                          `Centro de Costo` == "275-CONSULTA REUMATOLOGÍA"~"15104-CONSULTA REUMATOLOGÍA",
                          `Centro de Costo` == "276-CONSULTA CARDIOLOGÍA"~"15105-CONSULTA CARDIOLOGÍA",
                          `Centro de Costo` == "277-CONSULTA DERMATOLOGÍA"~"15106-CONSULTA DERMATOLOGÍA",
                          `Centro de Costo` == "278-CONSULTA ONCOLOGÍA"~"15107-CONSULTA ONCOLOGÍA",
                          `Centro de Costo` == "279-PROGRAMA VIH"~"15108-PROGRAMA VIH",
                          `Centro de Costo` == "280-CONSULTA PSIQUIATRÍA"~"15109-CONSULTA PSIQUIATRÍA",
                          `Centro de Costo` == "281-CONSULTA ENDOCRINOLOGÍA"~"15110-CONSULTA ENDOCRINOLOGÍA",
                          `Centro de Costo` == "282-CONSULTA NEUMOLOGÍA"~"15111-CONSULTA NEUMOLOGÍA",
                          `Centro de Costo` == "284-CONSULTA INFECTOLOGÍA"~"15113-CONSULTA INFECTOLOGÍA",
                          `Centro de Costo` == "285-CONSULTA NEFROLOGÍA"~"15114-CONSULTA NEFROLOGÍA",
                          `Centro de Costo` == "286-CONSULTA GENÉTICA"~"15115-CONSULTA GENÉTICA",
                          `Centro de Costo` == "287-CONSULTA HEMATOLOGÍA"~"15116-CONSULTA HEMATOLOGÍA",
                          `Centro de Costo` == "288-CONSULTA GERIATRÍA"~"15117-CONSULTA GERIATRÍA",
                          `Centro de Costo` == "289-CONSULTA FISIATRÍA"~"15118-CONSULTA FISIATRÍA",
                          `Centro de Costo` == "290-CONSULTA GASTROENTEROLOGÍA"~"15119-CONSULTA GASTROENTEROLOGÍA",
                          `Centro de Costo` == "292-CONSULTA NEUROCIRUGÍA"~"15121-CONSULTA NEUROCIRUGÍA",
                          `Centro de Costo` == "294-PROGRAMA MANEJO DEL DOLOR"~"15123-PROGRAMA MANEJO DEL DOLOR",
                          `Centro de Costo` == "295-CONSULTA SALUD OCUPACIONAL"~"15124-CONSULTA SALUD OCUPACIONAL",
                          `Centro de Costo` == "296-CONSULTA ANESTESIOLOGIA"~"15125-CONSULTA ANESTESIOLOGIA",
                                                    `Centro de Costo` == "302-PROGRAMA ENFERMEDADES DE TRANSMISIÓN SEXUAL"~"15131-PROGRAMA ENFERMEDADES DE TRANSMISIÓN SEXUAL",
                                                    `Centro de Costo` == "306-CONSULTA HEMATOLOGÍA ONCOLÓGICA"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                                                    `Centro de Costo` == "307-CONSULTA DE INMUNOLOGÍA"~"15136-CONSULTA DE INMUNOLOGÍA",
                                                    `Centro de Costo` == "309-CONSULTA CIRUGÍA GENERAL"~"15201-CONSULTA CIRUGÍA GENERAL",
                                                    `Centro de Costo` == "311-CONSULTA UROLOGÍA"~"15203-CONSULTA UROLOGÍA",
                                                    `Centro de Costo` == "316-CONSULTA CIRUGÍA PLÁSTICA"~"15208-CONSULTA CIRUGÍA PLÁSTICA",
                                                    `Centro de Costo` == "317-CONSULTA OFTALMOLOGÍA"~"15209-CONSULTA OFTALMOLOGÍA",
                                                    `Centro de Costo` == "318-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA"~"15210-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA",
                                                    `Centro de Costo` == "319-CONSULTA OTORRINOLARINGOLOGÍA"~"15211-CONSULTA OTORRINOLARINGOLOGÍA",
                                                    `Centro de Costo` == "323-CONSULTA CIRUGÍA MAXILOFACIAL"~"15215-CONSULTA CIRUGÍA MAXILOFACIAL",
                                                    `Centro de Costo` == "326-CONSULTA DE TRAUMATOLOGÍA"~"15218-CONSULTA DE TRAUMATOLOGÍA",
                                                    `Centro de Costo` == "328-CONSULTA PEDIATRÍA GENERAL"~"15302-CONSULTA PEDIATRÍA GENERAL",
                                                    `Centro de Costo` == "329-CONSULTA NEONATOLOGÍA"~"15303-CONSULTA NEONATOLOGÍA",
                                                    `Centro de Costo` == "331-CONSULTA NEUROLOGÍA PEDIÁTRICA"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                                    `Centro de Costo` == "342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA"~"15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
                                                    `Centro de Costo` == "351-CONSULTA CIRUGÍA PEDIÁTRICA"~"15409-CONSULTA CIRUGÍA PEDIÁTRICA",
                                                    `Centro de Costo` == "353-CONSULTA GINECOLOGICA"~"15502-CONSULTA GINECOLOGICA",
                                                    `Centro de Costo` == "354-CONSULTA OBSTETRICIA"~"15503-CONSULTA OBSTETRICIA",
                                                    `Centro de Costo` == "230-CONSULTA NUTRICIÓN"~"15008-CONSULTA NUTRICIÓN",
                                                    `Centro de Costo` == "232-CONSULTA OTROS PROFESIONALES"~"15010-CONSULTA OTROS PROFESIONALES",
                                                    `Centro de Costo` == "356-CONSULTA ODONTOLOGÍA"~"15602-CONSULTA ODONTOLOGÍA",
                                                    `Centro de Costo` == "152-HOSPITALIZACIÓN EN CASA"~"2002-HOSPITALIZACIÓN EN CASA",
                                                    `Centro de Costo` == "159-HOSPITALIZACIÓN DE DIA"~"2009-HOSPITALIZACIÓN DE DIA",
                                                    `Centro de Costo` == "244-PROCEDIMIENTO DE NEUMOLOGÍA"~"15022-PROCEDIMIENTO DE NEUMOLOGÍA",
                                                    `Centro de Costo` == "249-PROCEDIMIENTOS DE DERMATOLOGÍA"~"15027-PROCEDIMIENTOS DE DERMATOLOGÍA",
                                                    `Centro de Costo` == "250-PROCEDIMIENTOS DE GASTROENTEROLOGÍA"~"15028-PROCEDIMIENTOS DE GASTROENTEROLOGÍA",
                                                    `Centro de Costo` == "251-PROCEDIMIENTOS DE GINECOLOGÍA"~"15029-PROCEDIMIENTOS DE GINECOLOGÍA",
                                                    `Centro de Costo` == "258-PROCEDIMIENTOS DE OFTALMOLOGÍA"~"15036-PROCEDIMIENTOS DE OFTALMOLOGÍA",
                                                    `Centro de Costo` == "261-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA"~"15039-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA",
                                                    `Centro de Costo` == "263-PROCEDIMIENTOS DE UROLOGÍA"~"15041-PROCEDIMIENTOS DE UROLOGÍA",
                                                    `Centro de Costo` == "269-PROCEDIMIENTOS DE NEUROLOGÍA"~"15047-PROCEDIMIENTOS DE NEUROLOGÍA",
                                                    `Centro de Costo` == "542-IMAGENOLOGÍA"~"41108-IMAGENOLOGÍA",
                                                    `Centro de Costo` == "575-BANCO DE SANGRE"~"51001-BANCO DE SANGRE",
                                                    `Centro de Costo` == "593-SERVICIO FARMACEUTICO"~"55101-SERVICIO FARMACEUTICO",
                                                    `Centro de Costo` == "662-CENTRAL DE ESTERILIZACIÓN"~"95301-CENTRAL DE ESTERILIZACIÓN",
                                                    `Centro de Costo` == "657-LAVANDERIA Y ROPERIA"~"95201-LAVANDERIA Y ROPERIA",
                                                    `Centro de Costo` == "664-TRANSPORTE GENERAL"~"95401-TRANSPORTE GENERAL",
                                                    `Centro de Costo` == "665-MANTENIMIENTO"~"95501-MANTENIMIENTO",
                                                    `Centro de Costo` == "713-TRABAJO SOCIAL"~"99544-TRABAJO SOCIAL",
                                                    TRUE ~ `Centro de Costo`))



# Asigna proporcion uti/uci cardio ----------------------------------------

ucicv <- GG1 %>% filter(`Centro de Costo`=="198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS") %>%
  mutate(`Centro de Costo`= "177-UNIDAD DE CUIDADOS CORONARIOS", Devengado=Devengado*0.44, Cuenta=Cuenta, Tipo=Tipo)

uticv <- GG1 %>% filter(`Centro de Costo`=="198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS") %>%
  mutate(`Centro de Costo`=  `Centro de Costo`, Devengado=Devengado*0.56, Cuenta=Cuenta, Tipo=Tipo)

ucicv <- rbind(ucicv,uticv)

GG1 <- GG1 %>% filter(`Centro de Costo` != "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" )

GG1 <- rbind(GG1, ucicv)



# #Asigna costos a Urgencia Odontologica ----------------------------------


urg_odo <- GG1 %>% filter(`Centro de Costo`=="216-EMERGENCIAS PEDIÁTRICAS") %>%
  mutate(`Centro de Costo`= "357-EMERGENCIAS ODONTOLOGICAS", Devengado=Devengado*0.1, Cuenta=Cuenta, Tipo=Tipo)

urg  <- GG1 %>% filter(`Centro de Costo`=="216-EMERGENCIAS PEDIÁTRICAS") %>%
  mutate(`Centro de Costo`=  `Centro de Costo`, Devengado=Devengado*0.9, Cuenta=Cuenta, Tipo=Tipo)

urg_odo <- rbind(urg_odo,urg)

GG1 <- GG1 %>% filter(`Centro de Costo` != "216-EMERGENCIAS PEDIÁTRICAS" )

GG1 <- rbind(GG1, urg_odo)


# Elimina cuentas que no deben ir en Administración -----------------------

GG1$`Centro de Costo` <- ifelse(GG1$`Centro de Costo`=="670-ADMINISTRACIÓN" & 
                                  (GG1$Cuenta == "21-MATERIALES DE CURACIÓN" |
                                     GG1$Cuenta == "18-MATERIAL MEDICO QUIRURGICO" |
                                     GG1$Cuenta == "30-MEDICAMENTOS" ), "116-HOSPITALIZACIÓN PEDIATRÍA", GG1$`Centro de Costo`)


# Valores -----------------------------------------------------------------

sum(SIGFE$Devengado)
  
SIGFE %>%  filter(Tipo != "Insumos") %>%
  summarise(sum(Devengado))

sum(GG1$Devengado)

diferencia <- sum(SIGFE$Devengado)-sum(GG1$Devengado)-sum(Compras_Servicios$Devengado)
diferencia

medicamentos <- SIGFE %>% filter(SIGCOM == "30-MEDICAMENTOS") %>% summarise(devengo_medicamentos = sum(Devengado))


openxlsx::write.xlsx(GG1, graba, colNames = TRUE, sheetName = "SIGFE", overwrite = TRUE)

rm(`471-QUIRÓFANOS MAYOR AMBULATORIA`, `473-QUIRÓFANOS MENOR AMBULATORIA`,a, am, b,
   Cant_RRHH, ConsumoxCC, cuenta_insumos, cuentas, cuentas_cae, cuentas_clinico,
   cuentas_qx, cuentas_total, Farmacia, ggenerales, graba, i, insumos, M2_Pab_EqMed,
   mes_archivo, Metros_pabellon, proporcion_exacta, q, qx, resto, RRHH_sigfe, ruta_base,
   CAE_prorratear, cant_RRHH, CCC, CxCC, CxCC_H, df, EqMed, EqMedCorrec,
   EqMedPrev, Farm, GG1_nulo, GG2, GG3, GG33, GG4, GG44, M2, M2_exacto, M2Pab, SIGFE2, cuentas_no_critico)

sum(Compras_Servicios$Devengado)
ifelse(medicamentos$devengo_medicamentos<=0, toupper("No existe devengo de Medicamentos"),tolower("Medicamentos correctos"))
rm(medicamentos)
