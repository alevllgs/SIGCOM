library(readxl)
library(tidyverse)
library(dplyr)


# BBDD --------------------------------------------------------------------
mes_archivo <- "01 Enero"
mes_ruta_registros <- "2022-01"

#Nocambian
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2021/"
resto_ruta_registro_a <- "BBDD Produccion/REM/Serie A/2022/" #solo cambia 1 vez al año
cola_ruta_registro_a <- " REM serie A.xlsx"
resto_ruta_registro_b <- "BBDD Produccion/REM/Serie BS/2022/" #solo cambia 1 vez al año
cola_ruta_registro_b <- " REM serie BS.xlsx"



graba <- paste0(ruta_base,resto,mes_archivo,"/01, 02, 03, 04 , 05, 06 y 07/06_COSTOS_INDIRECTOS.xlsx")

rehabilitacion_perc <- read_excel(paste0(ruta_base,resto_ruta_registro_a,mes_ruta_registros,cola_ruta_registro_a), 
                                  sheet = "A28", range = "A168:B191", col_names = FALSE)

cmenor_perc <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                          sheet = "B17", range = "B344:K363", col_names = FALSE, na = "0")

farmacia_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/95_Farmacia.xlsx"))



aseo_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/03 M2.xlsx"), 
                               sheet = "M2") %>% 
                          mutate(`PERC ASOCIADO`=CC, Cantidad = M2) %>% 
                          filter(`PERC ASOCIADO`!="648-ASEO") %>% 
                          select(`PERC ASOCIADO`, Cantidad) %>% 
                          mutate(Item ="648_1-ASEO | Metro cuadrado")

anatomia_patologica_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/96_Anatomia_Patologica.xlsx"),
                                       range = "C4:D80") %>% 
                                         mutate(Cantidad = `544_1-ANATOMÍA PATOLÓGICA | Estudio`) %>% 
                                         filter(`PERC ASOCIADO`!="544-ANATOMÍA PATOLÓGICA" & Cantidad>0) %>% 
                                         select(`PERC ASOCIADO`, Cantidad) %>% mutate(Item ="544_1-ANATOMÍA PATOLÓGICA | Estudio")

imagenologia_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/92_Imagenologia.xlsx"), 
                                       range = "C1:D79")  %>% 
                                  mutate(Cantidad = `541_1-TOMOGRAFÍA | Estudio`) %>% 
                                  filter(`PERC ASOCIADO`!="542-IMAGENOLOGÍA" & Cantidad>0) %>% 
                                  select(`PERC ASOCIADO`, Cantidad) %>% 
                                  mutate(Item ="542_1-IMAGENOLOGÍA | Estudio")

laboratorio_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/93_Laboratorio.xlsx"), 
                                      range = "C1:I79") %>% 
                                 mutate(Cantidad = Totales) %>% 
                                 filter(`PERC ASOCIADO`!="518-LABORATORIO CLÍNICO" & Cantidad>0) %>% 
                                 select(`PERC ASOCIADO`, Cantidad) %>% mutate(Item ="518_1-LABORATORIO CLÍNICO | Exámen")

UMT_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/91_UMT.xlsx"), 
                       range = "C1:E78", na = "0") %>% 
                         mutate_all(., ~replace(., is.na(.), 0))

esterilizacion_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/90_Esterilizacion.xlsx"), 
                                  range = "C1:F77")

transporte_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/97_Transporte.xlsx"), 
                       range = "C1:F82", na = "0") %>% 
                         mutate_all(., ~replace(., is.na(.), 0))

psicosocial_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/94_Psicosocial.xlsx"), 
                               range = "C1:D77")  %>% 
                                 mutate(Cantidad = Total) %>% 
                                 filter(`PERC ASOCIADO`!="99544-TRABAJO SOCIAL" & Cantidad>0) %>% 
                                 select(`PERC ASOCIADO`, Cantidad) %>% 
                                 mutate(Item ="99544_1-TRABAJO SOCIAL | Atención")

alimentacion_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/98_Alimentacion.xlsx"), 
                                range = "A06:D21") %>% 
                                mutate(Cantidad = `652_1-SERVICIO DE ALIMENTACIÓN | Ración paciente (Desayuno, almuerzo, once y cena)`+ `654_1-SERVICIO DIETÉTICOS DE LECHE | Ración paciente (Mamaderas y matraces)`, Item = "652_1-SERVICIO DE ALIMENTACIÓN | Ración paciente") %>% 
                                select(`PERC ASOCIADO`, Cantidad, Item) %>% filter(Cantidad>0 & `PERC ASOCIADO`!="652-SERVICIO DE ALIMENTACIÓN
")

equipos_medicos_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/99_Equipos_Medicos.xlsx"), 
                                   range = "C1:D77") %>% 
  mutate(Cantidad = Total, Item = "665_1-MANTENIMIENTO | Órden") %>% 
  filter(Cantidad>0 & `PERC ASOCIADO`!="665-MANTENIMIENTO") %>% 
  select(`PERC ASOCIADO`, Cantidad, Item)


procedimientos_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Complemento Subir/05.xlsx")) %>% 
  filter(`Unidades de Producción` == "2__Procedimiento") %>% 
  mutate(Cantidad = Valor, 
         "Variable" = `Centro de Producción`,
         Item = case_when(
           Variable == "276__15105 - CONSULTA CARDIOLOGÍA" ~"240_1-PROCEDIMIENTO DE CARDIOLOGÍA | Procedimiento", 
           Variable == "282__15111 - CONSULTA NEUMOLOGÍA" ~"244_1-PROCEDIMIENTO DE NEUMOLOGÍA | Procedimiento",
           Variable == "277__15106 - CONSULTA DERMATOLOGÍA" ~"249_1-PROCEDIMIENTOS DE DERMATOLOGÍA | Procedimiento",
           Variable == "290__15119 - CONSULTA GASTROENTEROLOGÍA" ~"250_1-PROCEDIMIENTOS DE GASTROENTEROLOGÍA | Procedimiento",
           Variable == "306__15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA"  ~"260_1-PROCEDIMIENTO ONCOLOGÍA | Procedimiento",
           Variable == "319__15211 - CONSULTA OTORRINOLARINGOLOGÍA"  ~"261_1-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA | Procedimiento",
           Variable == "342__15316 - CONSULTA TRAUMATOLOGÍA PEDIÁTRICA"  ~"262_1-PROCEDIMIENTOS DE TRAUMATOLOGÍA | Procedimiento",
           Variable == "331__15305 - CONSULTA NEUROLOGÍA PEDIÁTRICA"  ~"269_1-PROCEDIMIENTOS DE NEUROLOGÍA | Procedimiento",
           Variable == "317__15209 - CONSULTA OFTALMOLOGÍA"  ~"258_1-PROCEDIMIENTOS DE OFTALMOLOGÍA | Procedimiento",
           Variable == "353__15502 - CONSULTA GINECOLOGICA"  ~"251_1-PROCEDIMIENTOS DE GINECOLOGÍA | Procedimiento",
           Variable == "311__15203 - CONSULTA UROLOGÍA"  ~"263_1-PROCEDIMIENTOS DE UROLOGÍA | Procedimiento",
           TRUE ~ "Identificar donde tributa"
         ), "PERC ASOCIADO" = case_when(
           Item == "240_1-PROCEDIMIENTO DE CARDIOLOGÍA | Procedimiento" ~ "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS", 
           Item == "244_1-PROCEDIMIENTO DE NEUMOLOGÍA | Procedimiento" ~ "282-CONSULTA NEUMOLOGÍA",
           Item == "249_1-PROCEDIMIENTOS DE DERMATOLOGÍA | Procedimiento" ~ "277-CONSULTA DERMATOLOGÍA",
           Item == "250_1-PROCEDIMIENTOS DE GASTROENTEROLOGÍA | Procedimiento" ~ "290-CONSULTA GASTROENTEROLOGÍA",
           Item == "260_1-PROCEDIMIENTO ONCOLOGÍA | Procedimiento" ~ "87-HOSPITALIZACIÓN ONCOLOGÍA",
           Item == "261_1-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA | Procedimiento" ~ "319-CONSULTA OTORRINOLARINGOLOGÍA",
           Item == "262_1-PROCEDIMIENTOS DE TRAUMATOLOGÍA | Procedimiento" ~ "342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
           Item == "269_1-PROCEDIMIENTOS DE NEUROLOGÍA | Procedimiento" ~ "331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
           Item == "258_1-PROCEDIMIENTOS DE OFTALMOLOGÍA | Procedimiento" ~ "317-CONSULTA OFTALMOLOGÍA",
           Item == "251_1-PROCEDIMIENTOS DE GINECOLOGÍA | Procedimiento" ~ "353-CONSULTA GINECOLOGICA",
           Item == "263_1-PROCEDIMIENTOS DE UROLOGÍA | Procedimiento" ~ "311-CONSULTA UROLOGÍA",
           TRUE ~ "Identificar donde tributa")) %>% 
  select(`PERC ASOCIADO`, Cantidad, Item) %>% filter(`PERC ASOCIADO` != "Identificar donde tributa")

# UMT ---------------------------------------------------------------------

UMT1 <- UMT_perc  %>% mutate(Cantidad =`575_1-BANCO DE SANGRE | Transfusión`) %>% 
  select(`PERC ASOCIADO`, Cantidad)
UMT1$Item <- "575_1-BANCO DE SANGRE | Unidad"


UMT2 <- UMT_perc  %>% mutate(Cantidad =`575_2-BANCO DE SANGRE | Exámen`) %>% 
  select(`PERC ASOCIADO`, Cantidad)
UMT2$Item <- "575_2-BANCO DE SANGRE | Exámen"

UMT_perc <- rbind(UMT1, UMT2) %>% 
  filter(`PERC ASOCIADO`!="575-BANCO DE SANGRE" & Cantidad>0)


# Esterilizacion ----------------------------------------------------------

esterilizacion <- esterilizacion_perc  %>% 
  mutate(Cantidad =`662_2-CENTRAL DE ESTERILIZACIÓN | Metro cúbico`) %>% 
  select(`PERC ASOCIADO`, Cantidad)
esterilizacion$Item <- "662_2-CENTRAL DE ESTERILIZACIÓN | Metro cúbico"


lavanderia <- esterilizacion_perc  %>% 
  mutate(Cantidad =`657_1-LAVANDERIA Y ROPERIA | Kilo`) %>% 
  select(`PERC ASOCIADO`, Cantidad)
lavanderia$Item <- "657_1-LAVANDERIA Y ROPERIA | Kilo"

esterilizacion_perc <- esterilizacion %>% 
  filter(`PERC ASOCIADO`!="662-CENTRAL DE ESTERILIZACIÓN" & `PERC ASOCIADO`!="657-LAVANDERIA Y ROPERIA" & Cantidad>0) #no esta conectada lavanderia xq no es un CC 

  

# Farmacia ----------------------------------------------------------------

farmacia1 <- farmacia_perc  %>% 
  mutate(Cantidad =`593_2-SERVICIO FARMACEUTICO | Prescripción`) %>% select(`PERC ASOCIADO`, Cantidad)
farmacia1$Item <- "593_2-SERVICIO FARMACEUTICO | Prescripción"


farmacia2 <- farmacia_perc  %>% 
  mutate(Cantidad =`593_1-SERVICIO FARMACEUTICO | Receta`) %>% 
  select(`PERC ASOCIADO`, Cantidad)
farmacia2$Item <- "593_1-SERVICIO FARMACEUTICO | Receta"

farmacia_perc <- rbind(farmacia1, farmacia2)


# Rehabilitacion ----------------------------------------------------------


colnames(rehabilitacion_perc)[1] <- "PERC ASOCIADO"
colnames(rehabilitacion_perc)[2] <- "Cantidad"
rehabilitacion_perc$Item <- "567_1-REHABILITACIÓN | Sesión"


rehabilitacion_perc <- rehabilitacion_perc %>% 
  mutate("PERC ASOCIADO" = case_when(`PERC ASOCIADO` == "NEUROLÓGICOS TRAUMATISMO ENCÉFALO CRANEANO (TEC)"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "NEUROLÓGICOS LESIÓN MEDULAR"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "NEUROLÓGICOS ACCIDENTE CEREBRO VASCULAR (ACV)"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "NEUROLÓGICOS DISRAFIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "NEUROLÓGICAS TUMORES"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "PARÁLISIS CEREBRAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "QUEMADOS (NO GES)"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "GRAN QUEMADO (GES)"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "SENSORIALES AUDITIVOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "SENSORIALES VISUALES"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "TRAUMATOLÓGICOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "AMPUTADOS POR OTRAS CAUSAS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "AMPUTADOS POR DIABETES"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     `PERC ASOCIADO` == "ENFERMEDADES DEL CORAZÓN"~"198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
                                     `PERC ASOCIADO` == "RESPIRATORIO"~"282-CONSULTA NEUMOLOGÍA",
                                     `PERC ASOCIADO` == "NEUROMUSCULARES AGUDAS"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                     `PERC ASOCIADO` == "NEUROMUSCULARES CRÓNICAS"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                     `PERC ASOCIADO` == "REUMATOLÓGICAS"~"275-CONSULTA REUMATOLOGÍA",
                                     `PERC ASOCIADO` == "NEUROLÓGICAS ESCLEROSIS LATERAL AMIOTRÓFICA (ELA)"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                     `PERC ASOCIADO` == "RETRASO EN EL DESARROLLO PSICOMOTOR"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                     `PERC ASOCIADO` == "ONCOLÓGICOS"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
                                     `PERC ASOCIADO` == "SINDROME DE INMOVILIZACIÓN"~"331-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                                     `PERC ASOCIADO` == "CUIDADOS PALIATIVOS"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGÍA MAYOR ABDOMINAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
                                     TRUE ~ "Asignar Centro de Costo"
  )) %>% filter(Cantidad>0)


# Cirugias Menores --------------------------------------------------------

colnames(cmenor_perc)[1] <- "PERC ASOCIADO"
colnames(cmenor_perc)[10] <- "Cantidad"
cmenor_perc <- cmenor_perc %>% select(`PERC ASOCIADO`, Cantidad) %>% filter(Cantidad != "NA")

cmenor_perc$Item <- "473_1-QUIRÓFANOS MENOR AMBULATORIA | Intervencion quirurgica"

cmenor_perc <- cmenor_perc %>% 
  mutate("PERC ASOCIADO" = case_when(`PERC ASOCIADO` == "CIRUGIA OFTALMOLOGICA"~"475-QUIRÓFANOS NEUROCIRUGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA OTORRINOLOGICA"~"471-QUIRÓFANOS MAYOR AMBULATORIA",
                                     `PERC ASOCIADO` == "CIRUGIA DE CABEZA Y CUELLO"~"471-QUIRÓFANOS MAYOR AMBULATORIA",
                                     `PERC ASOCIADO` == "NEUROLÓGICOS DISRAFIA"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA PLASTICA Y REPARADORA"~"493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
                                     `PERC ASOCIADO` == "TEGUMENTOS"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA CARDIOVASCULAR"~"464-QUIRÓFANOS CARDIOVASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA DE TORAX"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA ABDOMINAL"~"467-QUIRÓFANOS DIGESTIVA",
                                     `PERC ASOCIADO` == "CIRUGIA PROCTOLOGICA"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA UROLOGICA Y SUPRARRENAL"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA DE LA MAMA"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "CIRUGIA GINECOLOGICA"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA OBSTETRICA"~"495-QUIRÓFANOS CIRUGÍA VASCULAR",
                                     `PERC ASOCIADO` == "TRAUMATOLOGIA"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                                     `PERC ASOCIADO` == "ODONTOLOGIA (COD 27-03) Aranc.Fonasa"~"356-CONSULTA ODONTOLOGÍA",
                                     `PERC ASOCIADO` == "RETIRO ELEMENTOS OSTEOSINTESIS"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                                     TRUE ~ "Asignar Centro de Costo"
  ))



# Transporte --------------------------------------------------------------

t1 <- transporte_perc  %>% mutate(Cantidad =`664_1-TRANSPORTE GENERAL | Traslado`) %>% select(`PERC ASOCIADO`, Cantidad)
t1$Item <- "664_1-TRANSPORTE GENERAL | Traslado"

t2 <- transporte_perc %>% mutate(Cantidad =`664_2-TRANSPORTE GENERAL | Kilómetro`) %>% select(`PERC ASOCIADO`, Cantidad)
t2$Item <- "664_2-TRANSPORTE GENERAL | Kilómetro"

t3 <- transporte_perc  %>% mutate(Cantidad =`664_3-TRANSPORTE GENERAL | Viajes`) %>% select(`PERC ASOCIADO`, Cantidad)
t3$Item <- "664_3-TRANSPORTE GENERAL | Viajes"

transporte_perc <- rbind(t1, t2, t3) %>% filter(Cantidad>0 & `PERC ASOCIADO`!="664-TRANSPORTE GENERAL")



# Juntar ------------------------------------------------------------------

unidades <- rbind(cmenor_perc, farmacia_perc, rehabilitacion_perc, aseo_perc, anatomia_patologica_perc, imagenologia_perc, laboratorio_perc, UMT_perc, esterilizacion_perc, psicosocial_perc, procedimientos_perc, transporte_perc, alimentacion_perc, equipos_medicos_perc)

unidades <- unidades %>% mutate(`PERC ASOCIADO` = case_when(
  `PERC ASOCIADO`=="713-TRABAJO SOCIAL" ~ "99544-TRABAJO SOCIAL",
  `PERC ASOCIADO`=="478-QUIRÓFANOS OFTALMOLOGÍA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
  `PERC ASOCIADO`=="480-QUIRÓFANOS OTORRINOLARINGOLOGÍA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
  TRUE ~ `PERC ASOCIADO`), Cantidad = round(Cantidad))



# Separar Odonto Urgencia -------------------------------------------------


ODOURG1 <- unidades %>% filter(`PERC ASOCIADO`== "216-EMERGENCIAS PEDIÁTRICAS") %>% 
  mutate(`PERC ASOCIADO` ="357-EMERGENCIAS ODONTOLOGICAS", Cantidad = round(Cantidad*0.1))

URG <- unidades %>% filter(`PERC ASOCIADO`== "216-EMERGENCIAS PEDIÁTRICAS") %>% 
  mutate(Cantidad = round(Cantidad*0.9))

unidades <- unidades %>% filter(`PERC ASOCIADO`!= "216-EMERGENCIAS PEDIÁTRICAS")
unidades <- rbind(ODOURG1, URG, unidades)


#CONTRALORIA


unid_reportar <- c(     
"473_1-QUIRÓFANOS MENOR AMBULATORIA | Intervencion quirurgica",        
"593_1-SERVICIO FARMACEUTICO | Receta",         
"593_2-SERVICIO FARMACEUTICO | Prescripción",
"648_1-ASEO | Metro cuadrado",                                                  
"542_1-IMAGENOLOGÍA | Estudio",                                                    
"575_1-BANCO DE SANGRE | Unidad",
"575_2-BANCO DE SANGRE | Exámen",
"662_2-CENTRAL DE ESTERILIZACIÓN | Metro cúbico",                                     
"664_2-TRANSPORTE GENERAL | Kilómetro",
"664_1-TRANSPORTE GENERAL | Traslado",
"664_3-TRANSPORTE GENERAL | Viajes",
"665_1-MANTENIMIENTO | Órden",
"652_1-SERVICIO DE ALIMENTACIÓN | Ración paciente",              
"567_1-REHABILITACIÓN | Sesión",
"544_1-ANATOMÍA PATOLÓGICA | Estudio",
"518_1-LABORATORIO CLÍNICO | Exámen",
"99544_1-TRABAJO SOCIAL | Atención",
"249_1-PROCEDIMIENTOS DE DERMATOLOGÍA | Procedimiento",
"250_1-PROCEDIMIENTOS DE GASTROENTEROLOGÍA | Procedimiento",
"263_1-PROCEDIMIENTOS DE UROLOGÍA | Procedimiento",
"261_1-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA | Procedimiento",
"262_1-PROCEDIMIENTOS DE TRAUMATOLOGÍA | Procedimiento",
"240_1-PROCEDIMIENTO DE CARDIOLOGÍA | Procedimiento",               
"244_1-PROCEDIMIENTO DE NEUMOLOGÍA | Procedimiento",             
"260_1-PROCEDIMIENTO ONCOLOGÍA | Procedimiento",                       
"258_1-PROCEDIMIENTOS DE OFTALMOLOGÍA | Procedimiento",    
"269_1-PROCEDIMIENTOS DE NEUROLOGÍA | Procedimiento",                  
"251_1-PROCEDIMIENTOS DE GINECOLOGÍA | Procedimiento")


contraloria <- data.frame(
  "reportar" = as.character(c(unid_reportar)), 
  "capturado" = as.character(c(unid_reportar %in% unidades$Item))
)


openxlsx::write.xlsx(unidades, graba, colNames = TRUE, sheetName = "indirectos", overwrite = TRUE)



# Borrar Data -------------------------------------------------------------

rm(alimentacion_perc, anatomia_patologica_perc, aseo_perc, cmenor_perc, equipos_medicos_perc, esterilizacion, esterilizacion_perc, farmacia_perc, imagenologia_perc, laboratorio_perc, lavanderia, procedimientos_perc, rehabilitacion_perc, t1, t2, t3, transporte_perc, UMT_perc, unid_reportar, psicosocial_perc, farmacia1, farmacia2, UMT1, UMT2, graba, cola_ruta_registro_a, cola_ruta_registro_b, resto_ruta_registro_a, resto_ruta_registro_b, ODOURG1, URG)
