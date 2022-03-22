# Librerias ---------------------------------------------------------------
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)


# Cubo 09 -----------------------------------------------------------------

fecha_mes <- "2021-12-01"
PM_GRD <- c(1.3239,	1.1900,	1.2501,	1.3399,	1.3454,	1.3679,	1.3505,	1.3420,	1.1704,	1.2395,	1.1703,1.2219)


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


ambulatorio <- c(
"274-CONSULTA NEUROLOGÍA",
"275-CONSULTA REUMATOLOGÍA",
"276-CONSULTA CARDIOLOGÍA",
"277-CONSULTA DERMATOLOGÍA",                      
"278-CONSULTA ONCOLOGÍA",
"280-CONSULTA PSIQUIATRÍA",
"281-CONSULTA ENDOCRINOLOGÍA",                    
"282-CONSULTA NEUMOLOGÍA",
"284-CONSULTA INFECTOLOGÍA",                      
"285-CONSULTA NEFROLOGÍA",
"286-CONSULTA GENÉTICA",                          
"287-CONSULTA HEMATOLOGÍA",
"288-CONSULTA GERIATRÍA",                         
"289-CONSULTA FISIATRÍA",
"290-CONSULTA GASTROENTEROLOGÍA",                 
"292-CONSULTA NEUROCIRUGÍA",
"294-PROGRAMA MANEJO DEL DOLOR",                  
"295-CONSULTA SALUD OCUPACIONAL",
"296-CONSULTA ANESTESIOLOGIA",                    
"306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",            
"307-CONSULTA DE INMUNOLOGÍA",
"309-CONSULTA CIRUGÍA GENERAL",                   
"311-CONSULTA UROLOGÍA",
"316-CONSULTA CIRUGÍA PLÁSTICA",                  
"317-CONSULTA OFTALMOLOGÍA",
"318-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA",       
"319-CONSULTA OTORRINOLARINGOLOGÍA",
"323-CONSULTA CIRUGÍA MAXILOFACIAL",              
"326-CONSULTA DE TRAUMATOLOGÍA",
"328-CONSULTA PEDIATRÍA GENERAL",                 
"329-CONSULTA NEONATOLOGÍA",
"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",             
"342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
"351-CONSULTA CIRUGÍA PEDIÁTRICA",                
"353-CONSULTA GINECOLOGICA",
"354-CONSULTA OBSTETRICIA",                       
"230-CONSULTA NUTRICIÓN",
"232-CONSULTA OTROS PROFESIONALES")

cma <- c("465-QUIRÓFANO AMBULATORIO DE EMERGENCIA",
         "471-QUIRÓFANOS MAYOR AMBULATORIA")


hospitalizacion <- c(
"65-HOSPITALIZACIÓN PENSIONADOS",
"66-HOSPITALIZACIÓN MEDICINA INTERNA",            
"72-HOSPITALIZACIÓN NEUROLOGÍA",
"87-HOSPITALIZACIÓN ONCOLOGÍA",                   
"90-HOSPITALIZACIÓN QUIRÚRGICA",
"96-HOSPITALIZACIÓN UROLOGÍA",                    
"98-HOSPITALIZACIÓN NEUROCIRUGÍA",
"99-HOSPITALIZACIÓN OFTALMOLOGÍA",                
"100-HOSPITALIZACIÓN OTORRINOLARINGOLOGÍA",
"111-HOSPITALIZACIÓN TRAUMATOLOGÍA",              
"113-HOSPITALIZACIÓN OBSTETRICIA",
"114-HOSPITALIZACIÓN GINECOLOGÍA",                
"116-HOSPITALIZACIÓN PEDIATRÍA",
"130-HOSPITALIZACIÓN TRAUMATOLOGÍA PEDIÁTRICA",   
"136-HOSPITALIZACIÓN NEUROCIRUGÍA PEDIÁTRICA",
"149-HOSPITALIZACIÓN PSIQUIATRÍA")

hospitalizacion_uci <- c("166-UNIDAD DE CUIDADOS INTENSIVOS",
                         "169-UNIDAD DE CUIDADOS INTENSIVOS NEONATOS",     
                         "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                         "180-UNIDAD DE CUIDADOS INTERMEDIOS ADULTOS",     
                         "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS")

hospitalizacion_qx <- c(
  "462-QUIRÓFANOS CABEZA Y CUELLO",
  "464-QUIRÓFANOS CARDIOVASCULAR",                  
  "467-QUIRÓFANOS DIGESTIVA",
  "470-QUIRÓFANOS GINECOLOGÍA",                     
  "475-QUIRÓFANOS NEUROCIRUGÍA",
  "476-QUIRÓFANOS OBSTETRICIA",                     
  "477-QUIRÓFANOS ODONTOLOGICA",
  "478-QUIRÓFANOS OFTALMOLOGÍA",                    
  "480-QUIRÓFANOS OTORRINOLARINGOLOGÍA",
  "483-QUIRÓFANOS PROCTOLOGÍA",                     
  "484-QUIRÓFANOS TORACICA",
  "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",       
  "486-QUIRÓFANOS UROLOGÍA",
  "487-QUIRÓFANOS VASCULAR",                        
  "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
  "494-QUIRÓFANOS CIRUGÍA TORACICA",                
  "495-QUIRÓFANOS CIRUGÍA VASCULAR",
  "797-QUIROFANOS CIRUGIA CARDIACA")

emergencias <- c("216-EMERGENCIAS PEDIÁTRICAS",
         "357-EMERGENCIAS ODONTOLOGICAS")


# Urgencia ----------------------------------------------------------------
i4 <- Cubo_9 %>% filter(CC %in% emergencias & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p4 <- Cubo_9 %>% filter(CC %in% emergencias & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))  
i4 <- inner_join(i4,p4) %>% 
  mutate("Cod"=4, "Trazadora"="Atenciones de Emergencia", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
                                   "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,"Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021` )
  

# Ambulatorio -------------------------------------------------------------
i3 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p3 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p33 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="p3")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p3 <- data.frame(Fecha=p3$Fecha, "Producción 2021"= p3$`Producción 2021`+p33$`Producción 2021`)
colnames(p3)[2] <- "Producción 2021"
i3 <- inner_join(i3,p3) %>% 
  mutate("Cod"=3, "Trazadora"="Consultas de Especialidad", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)


# CMA ---------------------------------------------------------------------
i2 <- Cubo_9 %>% filter(CC %in% cma & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p2 <- Cubo_9 %>% filter(CC %in% cma & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
i2 <- inner_join(i2,p2) %>% 
  mutate("Cod"=2, "Trazadora"="Cirugía Mayor Ambulatoria", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)


# Hospitalizado -----------------------------------------------------------
i1 <- Cubo_9 %>% filter((CC %in% hospitalizacion | CC %in% hospitalizacion_qx | CC %in% hospitalizacion_uci) & Item=="Total RRHH")  %>% 
  group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p1 <- Cubo_9 %>% filter(CC %in% hospitalizacion & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p11 <-  Cubo_9 %>% filter(CC %in% hospitalizacion_uci & Item=="p3")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p1 <- data.frame(Fecha=p1$Fecha, "Producción 2021"= p1$`Producción 2021`+p11$`Producción 2021`)
colnames(p1)[2] <- "Producción 2021"
i1 <- inner_join(i1,p1) %>% 
  mutate("Cod"=1, "Trazadora"="Hospitalización", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"= PM_GRD, "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round((`Gasto RRHH 2021`/(`Producción 2021`*PM_GRD)))) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)

informe <- rbind(i1, i3, i2, i4)

openxlsx::write.xlsx(informe,paste0(ruta_base,"BBDD Produccion/PERC/PERC 2021/informe_mensual.xlsx"), 
                     colNames = TRUE, sheetName = "Informe", overwrite = TRUE)




# rm(i1, i2, i3, i4, p1,p11, p2, p3, p33, p4, Cubo_9, informe)