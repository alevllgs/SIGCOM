# Librerias ---------------------------------------------------------------
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)


# Cubo 09 -----------------------------------------------------------------

fecha_mes <- "2022-06-01"
PM_GRD <- c(1.3239,	1.1900,	1.2501,	1.3399,	1.3454,	1.3679,	1.3505,	1.3420,	1.1704,	1.2395,	1.1703,1.2219,
            1.2734,1.3280, 1.1678, 1.2583, 1.1628, 1.2618)

fecha_solo_mes <- str_sub(fecha_mes,1,7)
ruta_base <- "C:/Users/control.gestion3/OneDrive/"

Arch_cubo9 <- paste0(ruta_base,"BBDD Produccion/PERC/Cubos 9/Cubo_9 ",fecha_solo_mes,".xlsx")
C9_BBDD <- paste0(ruta_base,"BBDD Produccion/PERC/Cubos 9/Cubo_9 BBDD.xlsx")

Cubo_9M <- read_xlsx(Arch_cubo9, na = " ",col_names = TRUE)
Cubo_9 <- read_xlsx(C9_BBDD, na = " ",col_names = TRUE)
colnames(Cubo_9M)[1] <- "Variable"
Cubo_9$Fecha=as.character(Cubo_9$Fecha)

Cubo_9M <- Cubo_9M %>% mutate("Item" = case_when(
Variable=="Recursos Humanos"~"Total RRHH",
Variable=="Salario"~"Detalle RRHH",
Variable=="Bonificaciones"~"Detalle RRHH",
Variable=="Beneficios"~"Detalle RRHH",
Variable=="Gastos Generales"~"Total Gastos Generales",
Variable=="SERVICIO DE AGUA"~"Detalle Gastos Generales",
Variable=="ARRENDAMIENTOS"~"Detalle Gastos Generales",
Variable=="COLOCACIÓN FAMILIAR DE MENORES Y EXTRAHOSPITALARIA"~"Detalle Gastos Generales",
Variable=="COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS CRÍTICAS"~"Detalle Gastos Generales",
Variable=="COMPRA DE CAMAS AL EXTRA SISTEMA CAMAS NO CRÍTICAS"~"Detalle Gastos Generales",
Variable=="COMPRA DE CONSULTAS MÉDICAS"~"Detalle Gastos Generales",
Variable=="COMPRA DE CONSULTAS NO MÉDICAS"~"Detalle Gastos Generales",
Variable=="COMPRA DE INTERVENCIONES QUIRÚRGICAS CLÍNICAS"~"Detalle Gastos Generales",
Variable=="COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL EXTERNO"~"Detalle Gastos Generales",
Variable=="COMPRA DE INTERVENCIONES QUIRÚRGICAS INTRAHOSPITALARIAS CON PERSONAL INTERNO"~"Detalle Gastos Generales",
Variable=="COMPRA DE OTROS SERVICIOS"~"Detalle Gastos Generales",
Variable=="CURSOS DE CAPACITACIÓN"~"Detalle Gastos Generales",
Variable=="SERVICIO DE ENERGÍA"~"Detalle Gastos Generales",
Variable=="ENLACES DE TELECOMUNICACIONES"~"Detalle Gastos Generales",
Variable=="GAS PROPANO"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO DE PRADOS Y JARDINES"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO EQUIPO DE CÓMPUTO"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO MAQUINARIA Y EQUIPO"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO MUEBLES Y ENSERES"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO PLANTA FÍSICA"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO Y REPARACION DE VEHICULOS"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO CORRECTIVO"~"Detalle Gastos Generales",
Variable=="MANTENIMIENTO Y REPARACIÓN MÁQUINA Y EQUIPO PREVENTIVO"~"Detalle Gastos Generales",
Variable=="OTROS GASTOS GENERALES"~"Detalle Gastos Generales",
Variable=="OTROS MANTENIMIENTOS"~"Detalle Gastos Generales",
Variable=="PASAJES Y TRASLADOS DE PACIENTES"~"Detalle Gastos Generales",
Variable=="PASAJES, FLETES Y BODEGAJE"~"Detalle Gastos Generales",
Variable=="PUBLICIDAD Y PROPAGANDA"~"Detalle Gastos Generales",
Variable=="SALA CUNAS Y/O SERVICIOS INFANTILES"~"Detalle Gastos Generales",
Variable=="SEGUROS GENERALES"~"Detalle Gastos Generales",
Variable=="SERVICIO DE ASEO"~"Detalle Gastos Generales",
Variable=="SERVICIO DE INTERMEDIACIÓN CENABAST"~"Detalle Gastos Generales",
Variable=="SERVICIO DE LABORATORIO"~"Detalle Gastos Generales",
Variable=="SERVICIO DE LAVANDERÍA"~"Detalle Gastos Generales",
Variable=="SERVICIO DE MENSAJERIA Y/O CORREO"~"Detalle Gastos Generales",
Variable=="SERVICIO DE TRANSPORTE"~"Detalle Gastos Generales",
Variable=="SERVICIO DE VIGILANCIA Y SEGURIDAD"~"Detalle Gastos Generales",
Variable=="SERVICIOS GENERALES"~"Detalle Gastos Generales",
Variable=="SERVICIO DE TELECOMUNICACIONES"~"Detalle Gastos Generales",
Variable=="Insumos"~"Total Insumos",
Variable=="COMBUSTIBLES Y LUBRICANTES"~"Detalle Insumos",
Variable=="EQUIPOS MENORES"~"Detalle Insumos",
Variable=="GASES MEDICINALES"~"Detalle Insumos",
Variable=="LIBROS, TEXTOS, UTILES DE ENSEÑANZA Y PUBLICACIONES"~"Detalle Insumos",
Variable=="MATERIAL DE ODONTOLOGÍA"~"Detalle Insumos",
Variable=="MATERIAL DE OSTEOSÍNTESIS Y PRÓTESIS"~"Detalle Insumos",
Variable=="MATERIAL MEDICO QUIRURGICO"~"Detalle Insumos",
Variable=="MATERIALES DE CURACIÓN"~"Detalle Insumos",
Variable=="MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS"~"Detalle Insumos",
Variable=="MATERIALES DE USO O CONSUMO"~"Detalle Insumos",
Variable=="MATERIALES INFORMATICOS"~"Detalle Insumos",
Variable=="MATERIALES PARA MANTENIMIENTO Y REPARACIONES DE INMUEBLES"~"Detalle Insumos",
Variable=="MATERIALES Y ELEMENTOS DE ASEO"~"Detalle Insumos",
Variable=="MEDICAMENTOS"~"Detalle Insumos",
Variable=="MENAJE PARA OFICINA, CASINO Y OTROS"~"Detalle Insumos",
Variable=="OTROS INSUMOS Y MATERIALES"~"Detalle Insumos",
Variable=="PRODUCTOS QUÍMICOS"~"Detalle Insumos",
Variable=="PRODUCTOS TEXTILES, VESTUARIO Y CALZADO"~"Detalle Insumos",
Variable=="REPUESTOS Y ACCESORIOS PARA MANTENIMIENTO Y REPARACIONES DE VEHICULOS"~"Detalle Insumos",
Variable=="VÍVERES"~"Detalle Insumos",
Variable=="Total Directos"~"Total Directos",
Variable=="Total Indirectos"~"Total Indirectos",
Variable=="TRABAJO SOCIAL"~"Detalle Indirectos",
Variable=="MANTENIMIENTO"~"Detalle Indirectos",
Variable=="TRANSPORTE GENERAL"~"Detalle Indirectos",
Variable=="CENTRAL DE ESTERILIZACIÓN"~"Detalle Indirectos",
Variable=="SERVICIO DE ALIMENTACIÓN"~"Detalle Indirectos",
Variable=="ASEO"~"Detalle Indirectos",
Variable=="SERVICIO FARMACEUTICO"~"Detalle Indirectos",
Variable=="BANCO DE SANGRE"~"Detalle Indirectos",
Variable=="REHABILITACIÓN"~"Detalle Indirectos",
Variable=="ANATOMÍA PATOLÓGICA"~"Detalle Indirectos",
Variable=="IMAGENOLOGÍA"~"Detalle Indirectos",
Variable=="LABORATORIO CLÍNICO"~"Detalle Indirectos",
Variable=="QUIRÓFANOS MENOR AMBULATORIA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE NEUROLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE TRAUMATOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTO ONCOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE GASTROENTEROLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE DERMATOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTO DE NEUMOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTO DE CARDIOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE GINECOLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE UROLOGÍA"~"Detalle Indirectos",
Variable=="PROCEDIMIENTOS DE OFTALMOLOGÍA"~"Detalle Indirectos",
Variable=="ADMINISTRACIÓN"~"Detalle Indirectos",
Variable=="Total General"~"Total General",
Variable=="Total Produccion 1"~"p1",
Variable=="Costo por Produccion 1"~"c1",
Variable=="Total Produccion 2"~"p2",
Variable=="Costo por Produccion 2"~"c2",
Variable=="Total Produccion 3"~"p3",
Variable=="Costo por Produccion 3"~"c3",
Variable=="Total Produccion 4"~"p4",
Variable=="Costo por Produccion 4"~"c4",
Variable=="Total Produccion 5"~"p5",
Variable=="Costo por Produccion 5"~"c5",
Variable=="Numero de Camas"~"Numero de camas",
Variable=="Costo por Número de Camas"~"Costo por camas",
Variable=="QUIRÓFANOS MAYOR AMBULATORIA"~"Detalle Indirectos",
TRUE ~ "Asignar Variable"))

Cubo_9M <- mutate_all(Cubo_9M, ~replace(., is.na(.), 0))
Cubo_9M$TOTAL <- NULL
Item <- Cubo_9M
Cubo_9M$Item <- NULL
Item$Variable <- NULL
Cubo_9M <- Cubo_9M %>% 
  pivot_longer(-Variable,
               names_to = "CC", 
               values_to = "total")
Item <- Item %>% 
  pivot_longer(-Item,
               names_to = "CC", 
               values_to = "total")
Item$CC <- NULL
Item$total <- NULL
Item$Fecha <- fecha_mes
Item <- select(Item, Fecha, Item)
Cubo_9M <- cbind(Item, Cubo_9M)
Cubo_9 <- rbind(Cubo_9M, Cubo_9)

Cubo_9$Fecha=as.Date(Cubo_9$Fecha)
openxlsx::write.xlsx(Cubo_9, C9_BBDD, colNames = TRUE, 
                     sheetName = "Cubo9", overwrite = T)
rm(Item, C9_BBDD, Cubo_9M, Arch_cubo9, fecha_mes)

