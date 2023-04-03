library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)

# SIGFE listas-------------------------------------------------------------------
anio <- "2023"
mes_archivo <- "02"
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2023/"
mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes_archivo)]

options(scipen=999)
SIGFE <- read_excel(paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/01 Ejecucion Presupuestaria.xlsx"), skip = 6)
ConsumoxCC <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/02 Consumo x CC del mes.xlsx")
Cant_RRHH <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/912_SIRH_R.xlsx")
Farmacia <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/900_gasto_farmacia.xlsx")
graba <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/920_SIGFE_R.xlsx")
grabaM2 <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/03 M2.xlsx")
CxCC_H <- paste0(ruta_base,resto,"/Insumos de info anual/CxCC_historico.xlsx")
Asignaciones <- paste0(ruta_base,resto,"Insumos de info anual/Asignaciones.xlsx")
M2 <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/03 M2.xlsx")
M2Pab <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/89_Pabellon.xlsx")
EqMed <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/99_Equipos_Medicos.xlsx")
item <- paste0(ruta_base,resto,"/Insumos de info anual/item_presupuestarios_centros_de_costo.xlsx")
produccion_cae <- paste0(ruta_base,resto,mes_archivo," ",mes_completo,"/Insumos de Informacion/950_Produccion.xlsx")

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
             "46-VÍVERES",
             
             "100-GAS PROPANO",
             "48-SERVICIO DE AGUA",
             "92-SERVICIO DE ENERGÍA",
             "170-SERVICIO DE ASEO",
             "182-SERVICIO DE VIGILANCIA Y SEGURIDAD"
             
             
             )

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



# Consumo por CC ----------------------------------------------------------
#Agrupa las cuentas de SIGFE
SIGFE_agrupado <- SIGFE %>% 
  group_by ("Item" = SIGCOM) %>% 
  summarise("Devengado" = sum(Devengado)) %>%
  ungroup()

CxCC <- read_excel(ConsumoxCC, range = "A3:M5000", na = "eliminar")
item_pres_int <- read_excel(item, sheet = "item_presupuestario")
item_pres_int$cod_sigfe <- as.character(item_pres_int$cod_sigfe)

#Verifican que esten todos los CC y los item presupuestarios
CxCC_no_asignado <- CxCC
CxCC_no_asignado$no_asignado <- ifelse(CxCC$`ITEM PRESUPUESTARIO` %in% item_pres_int$item_presupuestario, "esta", "no esta") 
CxCC_no_asignado <- CxCC_no_asignado %>% filter(`ITEM PRESUPUESTARIO` != "NA" & no_asignado == "no esta")

consumo_interno <- read_excel(item, sheet = "centros_de_costos")
Cent_Cost_no_asignado <- CxCC
Cent_Cost_no_asignado$no_asignado <- ifelse(Cent_Cost_no_asignado$`CENTRO DE COSTO` %in% consumo_interno$cc_hospital, "esta", "no esta") 
Cent_Cost_no_asignado <- Cent_Cost_no_asignado %>% filter(`ITEM PRESUPUESTARIO` != "NA" & no_asignado == "no esta")

SIGFE <- SIGFE %>% inner_join(item_pres_int, by = "cod_sigfe") %>% select(-item_sigcom)
SIGFE$consumido <- ifelse(SIGFE$item_presupuestario %in% as.character(CxCC$`ITEM PRESUPUESTARIO`), "esta", "no esta")

CxCC$item_presupuestario <- as.character(CxCC$`ITEM PRESUPUESTARIO`)
CxCC <- CxCC %>% inner_join(SIGFE, by = "item_presupuestario") %>% select(-consumido, -Devengado, -`ITEM PRESUPUESTARIO`, -COD.PRODUCTO, -`COD. CENTRO COSTO`, -RUBRO, -BODEGA) %>% mutate(pxq = PRECIO*`CANTIDAD DESPACHADA`)
CxCC <- CxCC %>% inner_join(consumo_interno, by = c(`CENTRO DE COSTO` = "cc_hospital"))

consumido <- SIGFE %>% filter(consumido == "esta")
consumido <- consumido %>% 
  group_by ("SIGCOM" = SIGCOM) %>% 
  summarise("Devengado" = sum(Devengado)) %>%
  ungroup()

no_considera_consumo <- consumido %>% filter(SIGCOM == "30-MEDICAMENTOS" | SIGCOM == "100-GAS PROPANO" | SIGCOM == "48-SERVICIO DE AGUA" | SIGCOM == "92-SERVICIO DE ENERGÍA" | SIGCOM == "170-SERVICIO DE ASEO") %>% mutate("SIGCOM" = SIGCOM) %>% select(SIGCOM, Devengado)

consumido <- consumido %>% filter(SIGCOM != "30-MEDICAMENTOS" & SIGCOM != "100-GAS PROPANO" & SIGCOM != "48-SERVICIO DE AGUA" & SIGCOM != "92-SERVICIO DE ENERGÍA" & SIGCOM != "170-SERVICIO DE ASEO")

no_consumido <- SIGFE %>% filter(consumido == "no esta")
no_consumido <- no_consumido %>% 
  group_by ("SIGCOM" = SIGCOM) %>% 
  summarise("Devengado" = sum(Devengado)) %>%
  ungroup()

no_consumido <- rbind(no_considera_consumo, no_consumido)

consolidado <- data.frame(
  "Centro de Costo" = "eliminar", 
  "Devengado" = 0, 
  "Cuenta" = "eliminar",
  "Tipo" = 1)
colnames(consolidado)[1] <- "Centro de Costo"

for (i in unique(CxCC$SIGCOM)) {
  if(i %in% consumido$SIGCOM){
    aux_prorrateo <- CxCC %>% filter(SIGCOM == i)
    aux_prorrateo$prop <- prop.table(aux_prorrateo$pxq)
    aux_prorrateo <- aux_prorrateo %>% 
      group_by ("cc_sigcom" = cc_sigcom) %>% 
      summarise("prop" = sum(prop)) %>%
      ungroup()
    valor_sigfe <- sum(ifelse(consumido$SIGCOM == i, consumido$Devengado, 0))
    tabla_prorrateo <- aux_prorrateo %>% 
      mutate("Centro de Costo" = cc_sigcom , "Devengado" = prop*valor_sigfe, "Cuenta" = i,
             "Tipo" = 2) %>% select(-cc_sigcom, -prop)
    consolidado <- rbind(consolidado, tabla_prorrateo) %>%  filter(Cuenta != "eliminar")
  }
}



# Prorrateo Gastos Generales por M2 ---------------------------------------

#Crea dataframe esqueleto para añadir datos
GG1 <- data.frame(
  "Centro de Costo" = "eliminar", 
  "Devengado" = 0, 
  "Cuenta" = "eliminar",
  "Tipo" = 1)
colnames(GG1)[1] <- "Centro de Costo"
GG1_nulo <- GG1
GG44 <- GG1_nulo
GG33 <- GG1_nulo


# Distribucion por M2 -----------------------------------------------------

asignaciones <- read_excel(Asignaciones)
M2 <- read_excel(M2)
colnames(asignaciones)[1] <- "SIGCOM"
asignacion_m2 <- read_excel(Asignaciones) %>% filter(Prorrateo == "metros_totales")

aux_asignacion = asignacion_m2
aux_distribucion = M2
tipo = 1

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                             Devengado = Devengado*aux_distribucion$prop, 
                             "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}


# Distribución por asignacion directa -------------------------------------
asignacion_directa <- read_excel(Asignaciones) %>% filter(Prorrateo == "asignacion_directa")
asignacion_directa <- asignacion_directa %>% full_join(no_consumido, by="SIGCOM") %>% 
  filter(Prorrateo == "asignacion_directa", Devengado != "NA") %>% 
  select("Centro de Costo" = `Centro de costo`, Devengado, "Cuenta"=SIGCOM) %>% mutate("Tipo" = 4)

GG1 <- rbind(GG1, asignacion_directa)
rm(asignacion_directa, asignacion_m2, variable_efimera)

# Distribución clinica -------------------------------------
asignacion_clinica <- read_excel(Asignaciones) %>% filter(Prorrateo == "clinicos")
M2clinicos <- M2 %>% filter(Area != "Apoyo" & Area != "Administración")
M2clinicos$prop <- prop.table(M2clinicos$M2)

aux_asignacion = asignacion_clinica
aux_distribucion = M2clinicos
tipo = 2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución Pabellón sin cardio -------------------------------------
asignacion_pab_sin_car <- read_excel(Asignaciones) %>% filter(Prorrateo == "pabellon_sin_cardio")
M2Pab_sin_Card <- M2 %>% filter(Area == "Quirofanos") %>% filter(Area != "464-QUIRÓFANOS CARDIOVASCULAR")
M2Pab_sin_Card$prop <- prop.table(M2Pab_sin_Card$M2)

aux_asignacion = asignacion_pab_sin_car
aux_distribucion = M2Pab_sin_Card
tipo = 2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución CAE prorratear -------------------------------------
asignacion_cae <- read_excel(Asignaciones) %>% filter(Prorrateo == "cae_prorratear")
M2_cae <- M2 %>% filter(Area == "Ambulatorio" | Area == "Procedimientos")
M2_cae$prop <- prop.table(M2_cae$M2)

aux_asignacion <-  asignacion_cae
aux_distribucion <-  M2_cae
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}


# Distribución UPC --------------------------------------------------------

asignacion_upc <- read_excel(Asignaciones) %>% filter(Prorrateo == "upc")
M2_upc <- M2 %>% filter(Area == "UPC")
M2_upc$prop <- prop.table(M2_upc$M2)

aux_asignacion <-  asignacion_upc
aux_distribucion <-  M2_upc
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución por costo Farmacia --------------------------------------------------------------


M2_farmacia <- read_excel(Farmacia) %>% mutate("CC" = perc, "prop" = gasto) %>% select(-perc, -gasto)

asignacion_farmacia <- read_excel(Asignaciones) %>% filter(Prorrateo == "farmacia")

aux_asignacion <-  asignacion_farmacia
aux_distribucion <-  M2_farmacia
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución por Equipos Medicos ---------------------------------------------------------

#PREVENTIVOS
M2_EqMed_prev <- read_excel(EqMed) %>% 
  filter("Área" != "Total" & `Mantención Preventiva` != "NA") %>% 
  mutate("CC" = `PERC ASOCIADO`, "prop" = prop.table(`Mantención Preventiva`)) %>% 
  select(CC, prop)

asignacion_EqMed_prev <- read_excel(Asignaciones) %>% filter(Prorrateo == "equipos_medicos_prev")

aux_asignacion <-  asignacion_EqMed_prev
aux_distribucion <-  M2_EqMed_prev
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

#CORRECTIVOS
M2_EqMed_correc <- read_excel(EqMed) %>% 
  filter("Área" != "Total" & `Mantención Correctiva` != "NA") %>% 
  mutate("CC" = `PERC ASOCIADO`, "prop" = prop.table(`Mantención Correctiva`)) %>% 
  select(CC, prop)

asignacion_EqMed_correc <- read_excel(Asignaciones) %>% filter(Prorrateo == "equipos_medicos_correc")

aux_asignacion <-  asignacion_EqMed_correc
aux_distribucion <-  M2_EqMed_correc
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución por Cant_RRHH ----------------------------------------------
M2_Cant_RRHH <- read_excel(Cant_RRHH) %>% mutate("CC" = perc, "prop" = horas_mensuales) %>% 
  select(CC, prop) %>% 
  group_by(CC) %>% 
  summarise(prop = sum(prop)) %>% 
  ungroup()
M2_Cant_RRHH$prop <- prop.table(M2_Cant_RRHH$prop)

asignacion_RRHH <- read_excel(Asignaciones) %>% filter(Prorrateo == "cantidad_rrhh")

aux_asignacion <-  asignacion_RRHH
aux_distribucion <-  M2_Cant_RRHH
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}


# Distribucion Lab, Anat y Farmacia ---------------------------------------

M2_Ap_Lab_Farm <- data.frame("CC" = c("518-LABORATORIO CLÍNICO",
                                      "544-ANATOMÍA PATOLÓGICA",
                                      "55101-SERVICIO FARMACEUTICO"), "prop" = c(1/3, 1/3, 1/3))

asignacion_Ap_Lab_Farm <- read_excel(Asignaciones) %>% filter(Prorrateo == "lab_ap_farm")

aux_asignacion <-  asignacion_Ap_Lab_Farm
aux_distribucion <-  M2_Ap_Lab_Farm
tipo <-  2

for (i in aux_asignacion$SIGCOM) {
  if(i %in% no_consumido$SIGCOM){
    variable_efimera <-  no_consumido %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Cuadratura Devengado versus prorrateado ---------------------------------

GG1_agrupado <- GG1 %>% 
  group_by ("SIGCOM" = Cuenta) %>% 
  summarise("Prorrateado" = sum(Devengado)) %>%
  ungroup()

asignaciones <- asignaciones %>% full_join(no_consumido, by="SIGCOM")
asignaciones <- asignaciones %>% full_join(GG1_agrupado, by="SIGCOM") %>% filter(Devengado != "NA")
asignaciones$diferencia <- asignaciones$Devengado - asignaciones$Prorrateado
#rm(no_consumido, GG1_agrupado)



consolidado <- rbind(consolidado, GG1)

# Distribución Pabellón sin cardio -------------------------------------

GG1 <- GG1 %>% filter(Cuenta == "gatito")

asignacion_pab_sin_car <- consolidado %>% filter(`Centro de Costo` == "Pabellón Prorratear")


if ("15-MATERIAL DE ODONTOLOGÍA" %in% asignacion_pab_sin_car$Cuenta){
  GG1 <- asignacion_pab_sin_car %>% filter(Cuenta == "15-MATERIAL DE ODONTOLOGÍA")
  GG1$`Centro de Costo` <- "462-QUIRÓFANOS CABEZA Y CUELLO"
  asignacion_pab_sin_car <- asignacion_pab_sin_car %>% filter(Cuenta != "15-MATERIAL DE ODONTOLOGÍA")
  }

aux_asignacion = asignacion_pab_sin_car
aux_distribucion = M2Pab_sin_Card
tipo = 2

for (i in aux_asignacion$Cuenta) {
  if(i %in% aux_asignacion$Cuenta){
    variable_efimera <-  aux_asignacion %>% group_by(Cuenta) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(Cuenta == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

# Distribución CAE prorratear -------------------------------------
asignacion_cae <- consolidado %>% filter(`Centro de Costo` == "Cae Prorratear") 

aux_asignacion <-  asignacion_cae
aux_distribucion <-  M2_cae
tipo <-  2

for (i in aux_asignacion$Cuenta) {
  if(i %in% aux_asignacion$Cuenta){
    variable_efimera <-  aux_asignacion %>% group_by(Cuenta) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(Cuenta == i)
    variable_efimera <- variable_efimera %>% summarise("Centro de Costo" = aux_distribucion$CC, 
                                                       Devengado = Devengado*aux_distribucion$prop, 
                                                       "Cuenta"=i, "Tipo" = tipo) 
    GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
  else {variable_efimera <- GG1_nulo
  GG1 <- rbind(GG1,variable_efimera) %>% filter(Cuenta!="eliminar")}
}

consolidado <- consolidado %>% filter(`Centro de Costo` != "Cae Prorratear" & `Centro de Costo` != "Pabellón Prorratear")
consolidado <- rbind(consolidado, GG1)



# Asigna CC actualizados al 2023 ------------------------------------------
consolidado <- consolidado %>% mutate(`Centro de Costo` = 
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




# #Asigna costos a Urgencia Odontologica ----------------------------------


urg_odo <- consolidado %>% filter(`Centro de Costo`=="216-EMERGENCIAS PEDIÁTRICAS") %>%
  mutate(`Centro de Costo`= "357-EMERGENCIAS ODONTOLOGICAS", Devengado=Devengado*0.1, Cuenta=Cuenta, Tipo=Tipo)

urg  <- consolidado %>% filter(`Centro de Costo`=="216-EMERGENCIAS PEDIÁTRICAS") %>%
  mutate(`Centro de Costo`=  `Centro de Costo`, Devengado=Devengado*0.9, Cuenta=Cuenta, Tipo=Tipo)

urg_odo <- rbind(urg_odo,urg)

consolidado <- consolidado %>% filter(`Centro de Costo` != "216-EMERGENCIAS PEDIÁTRICAS" )

consolidado <- rbind(consolidado, urg_odo)


# Cambia cuentas que no deben ir en Administración a Hospi Pediatria-----------------------

consolidado$`Centro de Costo` <- ifelse(consolidado$`Centro de Costo`=="670-ADMINISTRACIÓN" & 
                                  (consolidado$Cuenta == "21-MATERIALES DE CURACIÓN" |
                                     consolidado$Cuenta == "18-MATERIAL MEDICO QUIRURGICO" |
                                     consolidado$Cuenta == "30-MEDICAMENTOS" ), "116-HOSPITALIZACIÓN PEDIATRÍA", consolidado$`Centro de Costo`)


# Valores -----------------------------------------------------------------

Compras <- consolidado %>% filter(Cuenta == "60-COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS NO CRÍTICAS" |
                                    Cuenta == "61-COMPRA DE CONSULTAS MÉDICAS" |
                                    Cuenta == "62-COMPRA DE CONSULTAS NO MÉDICAS" |
                                    Cuenta == "63-COMPRA DE INTERVENCIONES QUIRÚRGICAS CLÍNICAS" |
                                    Cuenta == "64-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO" |
                                    Cuenta == "65-COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO" |
                                    Cuenta == "66-COMPRA DE OTROS SERVICIOS")

if(sum(Compras$Devengado)  > 0){
  beepr::beep(sound = 9)
  Alerta_compras <- "Existen compras que justificar"}


Alerta_medicamentos <- consolidado %>% filter(Cuenta == "30-MEDICAMENTOS")
Alerta_medicamentos <- ifelse(sum(Alerta_medicamentos$Devengado) <= 0, toupper("No existe devengo de Medicamentos"),tolower("Medicamentos correctos"))

if(Alerta_medicamentos == "medicamentos correctos"){
  beepr::beep(sound = 3)}


if(sum(SIGFE$Devengado) == sum(consolidado$Devengado)){
  beepr::beep(sound = 3)
  Alerta_cuadratura <- "SIGFE esta cuadrado"
}


openxlsx::write.xlsx(consolidado, graba, colNames = TRUE, sheetName = "SIGFE", overwrite = TRUE)

##### Alarmas
 

rm(M2_Ap_Lab_Farm, M2_cae, M2_Cant_RRHH, M2_EqMed_correc, M2_EqMed_prev, M2_farmacia, M2_upc, M2clinicos, no_considera_consumo, no_consumido)
rm(SIGFE_agrupado, SIGFE, asignacion_Ap_Lab_Farm, asignacion_cae, asignacion_directa, asignacion_clinica, asignacion_EqMed_correc, asignacion_EqMed_prev, asignacion_farmacia, asignacion_pab_sin_car, asignacion_RRHH, asignacion_upc, asignaciones, Asignaciones)

rm(tipo, valor_sigfe, produccion_cae, aux_asignacion, aux_distribucion, aux_prorrateo, Cent_Cost_no_asignado, Compras, consumido, consumo_interno, CxCC, CxCC_no_asignado, GG1, GG1_agrupado, GG1_nulo, GG33, GG44, item_pres_int, M2, M2Pab_sin_Card, prod_cae, tabla_prorrateo, urg, urg_odo, variable_efimera)
rm(Cant_RRHH, ConsumoxCC, cuentas, CxCC_H, EqMed, Farmacia, ggenerales, graba, i, insumos, item, mes_archivo, resto, RRHH_sigfe, ruta_base)