library(readxl)
library(tidyverse)
library(dplyr)

# BBDD --------------------------------------------------------------------
mes_archivo <- "02 Febrero"
mes_ruta_registros <- "2023-02"



# Rutas -------------------------------------------------------------------
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2023/"
resto_ruta_registro_a <- "BBDD Produccion/REM/Serie A/2023/" #solo cambia 1 vez al año
cola_ruta_registro_a <- " REM serie A.xlsx"
resto_ruta_registro_b <- "BBDD Produccion/REM/Serie BS/2023/" #solo cambia 1 vez al año
cola_ruta_registro_b <- " REM serie BS.xlsx"
CC_autorizado <- read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC 2023/Insumos de info anual/Centros de costos autorizados.xlsx")

graba <- paste0(ruta_base,resto,mes_archivo,"//Insumos de Informacion/960_Indirectos.xlsx")

rehabilitacion_perc <- read_excel(paste0(ruta_base,resto_ruta_registro_a,mes_ruta_registros,cola_ruta_registro_a), 
                                  sheet = "A28", range = "A150:B175", col_names = FALSE)

cmenor_perc <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                          sheet = "B17", range = "B176:K194", col_names = FALSE, na = "0")

farmacia_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/901_Farmacia.xlsx"))

aseo_perc <- read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/03 M2.xlsx")) %>% 
                          mutate(`PERC ASOCIADO`=CC, Cantidad = M2) %>% 
                          filter(`PERC ASOCIADO`!="648-ASEO") %>% 
                          select(`PERC ASOCIADO`, Cantidad) %>% 
                          mutate(Item ="648_1-ASEO | Metro cuadrado") %>% 
  filter(`PERC ASOCIADO` != "Pabellón Prorratear")

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
                               range = "C2:I80") %>% 
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

# Procedimientos ----------------------------------------------------------

p_neurologia <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                          sheet = "B", range = "C1328:C1328", col_names = FALSE, na = "0") %>% 
 mutate(`PERC ASOCIADO`="15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
         Cantidad = `...1`,
        Item = "15047_1-PROCEDIMIENTOS DE NEUROLOGÍA | Procedimiento") %>% select(-`...1`)

p_oto <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                           sheet = "B", range = "C1617:C1617", col_names = FALSE, na = "0") %>% 
  mutate(`PERC ASOCIADO`="15211-CONSULTA OTORRINOLARINGOLOGÍA",
         Cantidad = `...1`,
         Item = "15039_1-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA | Procedimiento") %>% select(-`...1`)


p_dermato <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                    sheet = "B", range = "C1882:C1882", col_names = FALSE, na = "0") %>% 
  mutate(`PERC ASOCIADO`="15106-CONSULTA DERMATOLOGÍA",
         Cantidad = `...1`,
         Item = "15027_1-PROCEDIMIENTOS DE DERMATOLOGÍA | Procedimiento") %>% select(-`...1`)

p_neumo <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                        sheet = "B", range = "C2211:C2211", col_names = FALSE, na = "0") %>% 
  mutate(`PERC ASOCIADO`="15111-CONSULTA NEUMOLOGÍA",
         Cantidad = `...1`,
         Item = "15022_1-PROCEDIMIENTO DE NEUMOLOGÍA | Procedimiento") %>% select(-`...1`)

p_cardio <- read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
                      sheet = "B", range = "C1982:C1982", col_names = FALSE, na = "0") %>% 
  mutate(`PERC ASOCIADO`="15105-CONSULTA CARDIOLOGÍA",
         Cantidad = `...1`,
         Item = "240_1-PROCEDIMIENTO DE CARDIOLOGÍA | Procedimiento") %>% select(-`...1`)

p_gastro <- 
  read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b), 
             sheet = "B", range = "C2281:C2281", col_names = FALSE, na = "0") %>% 
  mutate(`PERC ASOCIADO`="15119-CONSULTA GASTROENTEROLOGÍA",
         Cantidad = `...1`,
         Item = "15028_1-PROCEDIMIENTOS DE GASTROENTEROLOGÍA | Procedimiento") %>% select(-`...1`)

p_tmt <- 
  read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b),
             sheet = "B", range = "C2673:C2673", col_names = FALSE) +
  read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b),
             sheet = "B", range = "C2893:C2893", col_names = FALSE) +
  read_excel(paste0(ruta_base,resto_ruta_registro_b,mes_ruta_registros,cola_ruta_registro_b),
             sheet = "B", range = "C2905:C2905", col_names = FALSE)
p_tmt <- p_tmt %>%   mutate(`PERC ASOCIADO`="15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
         Cantidad = `...1`,
         Item = "262_1-PROCEDIMIENTOS DE TRAUMATOLOGÍA | Procedimiento") %>% select(-`...1`)

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

farmacia_perc <- farmacia_perc  %>% 
  mutate(Cantidad =`593_2-SERVICIO FARMACEUTICO | Prescripción`) %>% select(`PERC ASOCIADO`, Cantidad)
farmacia_perc$Item <- "593_2-SERVICIO FARMACEUTICO | Prescripción"

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
  ))


 if(sum(rehabilitacion_perc$Cantidad)==0)
 {
   a <- c(0.04,0.28,0.04,0.14,0.14,0.19,0.04,0.14)
   b <- c("87-HOSPITALIZACIÓN ONCOLOGÍA",
          "90-HOSPITALIZACIÓN QUIRÚRGICA",
          "177-UNIDAD DE CUIDADOS CORONARIOS",
          "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
          "15111-CONSULTA NEUMOLOGÍA",
          "15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
          "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
          "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA")
   
   c <- read_excel(paste0(ruta_base,resto_ruta_registro_a,mes_ruta_registros,cola_ruta_registro_a), 
                 sheet = "A28", range = "B194:B194", col_names = FALSE)
   d <- read_excel(paste0(ruta_base,resto_ruta_registro_a,mes_ruta_registros,cola_ruta_registro_a), 
                 sheet = "A28", range = "B214:B214", col_names = FALSE)
   rehabilitacion_perc <- data.frame(`PERC ASOCIADO`=b, "Cantidad"=round(a*c$...1), "Item"="567_1-REHABILITACIÓN | Sesión")
   }

colnames(rehabilitacion_perc)[1] <- "PERC ASOCIADO"

# Cirugias Menores --------------------------------------------------------

colnames(cmenor_perc)[1] <- "PERC ASOCIADO"
colnames(cmenor_perc)[10] <- "Cantidad"
cmenor_perc <- cmenor_perc %>% select(`PERC ASOCIADO`, Cantidad) %>% filter(Cantidad != "NA")

cmenor_perc$Item <- "473_1-QUIRÓFANOS MENOR AMBULATORIA | Intervencion quirurgica"

cmenor_perc <- cmenor_perc %>% 
  mutate("PERC ASOCIADO" = case_when(`PERC ASOCIADO` == "CIRUGIA OFTALMOLOGICA"~"462-QUIRÓFANOS CABEZA Y CUELLO",
                                     `PERC ASOCIADO` == "CIRUGIA OTORRINOLOGICA"~"462-QUIRÓFANOS CABEZA Y CUELLO",
                                     `PERC ASOCIADO` == "CIRUGIA DE CABEZA Y CUELLO"~"462-QUIRÓFANOS CABEZA Y CUELLO",
                                     `PERC ASOCIADO` == "NEUROLÓGICOS DISRAFIA"~"475-QUIRÓFANOS NEUROCIRUGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA OBSTETRICA"~"484-QUIRÓFANOS TORACICA",
                                     `PERC ASOCIADO` == "CIRUGIA ABDOMINAL"~"484-QUIRÓFANOS TORACICA",
                                     `PERC ASOCIADO` == "CIRUGIA PROCTOLOGICA"~"484-QUIRÓFANOS TORACICA",
                                     `PERC ASOCIADO` == "CIRUGIA DE TORAX"~"484-QUIRÓFANOS TORACICA",
                                     `PERC ASOCIADO` == "CIRUGIA DE LA MAMA"~"484-QUIRÓFANOS TORACICA",
                                     `PERC ASOCIADO` == "RETIRO ELEMENTOS OSTEOSINTESIS"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                                     `PERC ASOCIADO` == "RETIRO ELEMENTOS OSTEOSINTESIS"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                                     `PERC ASOCIADO` == "TRAUMATOLOGIA"~"485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
                                     `PERC ASOCIADO` == "CIRUGIA PLASTICA Y REPARADORA"~"493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
                                     `PERC ASOCIADO` == "TEGUMENTOS"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "DERMATOLOGÍA Y TEGUMENTOS"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA GINECOLOGICA"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA UROLOGICA Y SUPRARRENAL"~"486-QUIRÓFANOS UROLOGÍA",
                                     `PERC ASOCIADO` == "CIRUGIA CARDIOVASCULAR"~"464-QUIRÓFANOS CARDIOVASCULAR",
                                     `PERC ASOCIADO` == "ODONTOLOGIA (COD 27-03) Aranc.Fonasa"~"462-QUIRÓFANOS CABEZA Y CUELLO",
                                     `PERC ASOCIADO` == "ODONTOLOGIA"~"462-QUIRÓFANOS CABEZA Y CUELLO",
                                     TRUE ~ "Asignar Centro de Costo"))

# Transporte --------------------------------------------------------------

t1 <- transporte_perc  %>% mutate(Cantidad =`664_1-TRANSPORTE GENERAL | Traslado`) %>% select(`PERC ASOCIADO`, Cantidad)
t1$Item <- "664_1-TRANSPORTE GENERAL | Traslado"

t2 <- transporte_perc %>% mutate(Cantidad =`664_2-TRANSPORTE GENERAL | Kilómetro`) %>% select(`PERC ASOCIADO`, Cantidad)
t2$Item <- "664_2-TRANSPORTE GENERAL | Kilómetro"

t3 <- transporte_perc  %>% mutate(Cantidad =`664_3-TRANSPORTE GENERAL | Viajes`) %>% select(`PERC ASOCIADO`, Cantidad)
t3$Item <- "664_3-TRANSPORTE GENERAL | Viajes"

transporte_perc <- rbind(t1, t2, t3) %>% filter(Cantidad>0 & `PERC ASOCIADO`!="664-TRANSPORTE GENERAL")

# Juntar ------------------------------------------------------------------

unidades <- rbind(cmenor_perc, farmacia_perc, rehabilitacion_perc, aseo_perc, anatomia_patologica_perc, imagenologia_perc, laboratorio_perc, UMT_perc, esterilizacion_perc, psicosocial_perc, transporte_perc, alimentacion_perc, equipos_medicos_perc, p_cardio, p_dermato, p_gastro, p_neumo, p_neurologia, p_oto, p_tmt)

unidades <- unidades %>% mutate(`PERC ASOCIADO` = case_when(
  `PERC ASOCIADO`=="713-TRABAJO SOCIAL" ~ "99544-TRABAJO SOCIAL",
  `PERC ASOCIADO`=="478-QUIRÓFANOS OFTALMOLOGÍA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
  `PERC ASOCIADO`=="480-QUIRÓFANOS OTORRINOLARINGOLOGÍA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
  TRUE ~ `PERC ASOCIADO`), Cantidad = round(Cantidad))

# crea un prorrateo de UCI y UTI ------------------------------------------


uti <- unidades %>% filter(`PERC ASOCIADO`=="170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA") %>% 
  mutate(`PERC ASOCIADO`="196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA", Cantidad=Cantidad*0.57,Item=Item)

uci <- unidades %>% filter(`PERC ASOCIADO`=="170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA") %>% 
  mutate(`PERC ASOCIADO`=`PERC ASOCIADO`, Cantidad=Cantidad*0.43,Item=Item)


ucicv <- unidades %>% filter(`PERC ASOCIADO`=="198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS") %>% 
  mutate(`PERC ASOCIADO`="177-UNIDAD DE CUIDADOS CORONARIOS", Cantidad=Cantidad*0.44,Item=Item)

uticv <- unidades %>% filter(`PERC ASOCIADO`=="198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS") %>% 
  mutate(`PERC ASOCIADO`=`PERC ASOCIADO`, Cantidad=Cantidad*0.56,Item=Item)

uti <- rbind(uti, uci, ucicv, uticv)

unidades <- unidades %>% filter(`PERC ASOCIADO` != "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" |
                                  `PERC ASOCIADO` != "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS")

unidades <- rbind(unidades, uti)

# Separar Odonto Urgencia -------------------------------------------------

ODOURG1 <- unidades %>% filter(`PERC ASOCIADO`== "216-EMERGENCIAS PEDIÁTRICAS") %>% 
  mutate(`PERC ASOCIADO` ="357-EMERGENCIAS ODONTOLOGICAS", Cantidad = round(Cantidad*0.1))

URG <- unidades %>% filter(`PERC ASOCIADO`== "216-EMERGENCIAS PEDIÁTRICAS") %>% 
  mutate(Cantidad = round(Cantidad*0.9))

unidades <- unidades %>% filter(`PERC ASOCIADO`!= "216-EMERGENCIAS PEDIÁTRICAS")
unidades <- rbind(ODOURG1, URG, unidades)


# Elimino parametros que no se ocuparan en 2023 ---------------------------

unidades <- unidades %>% filter(
  Item != "593_1-SERVICIO FARMACEUTICO | Receta" &
    Item != "575_1-BANCO DE SANGRE | Unidad"   &
    Item != "664_1-TRANSPORTE GENERAL | Traslado" &
    Item != "664_3-TRANSPORTE GENERAL | Viajes") %>% 
  mutate(Item = 
           case_when(Item == "665_1-MANTENIMIENTO | Órden"~"95501_1-MANTENIMIENTO | Órden",
                     Item == "662_2-CENTRAL DE ESTERILIZACIÓN | Metro cúbico"~"95301_1-CENTRAL DE ESTERILIZACIÓN | Metro cúbico",
                     Item == "593_2-SERVICIO FARMACEUTICO | Prescripción"~"55101_1-SERVICIO FARMACEUTICO | Prescripción",
                     Item == "542_1-IMAGENOLOGÍA | Estudio"~"41108_1-IMAGENOLOGÍA | Exámen",
                     Item == "657_1-LAVANDERIA Y ROPERIA | Kilo"~"95201_1-LAVANDERIA Y ROPERIA | Kilo",
                     Item == "664_2-TRANSPORTE GENERAL | Kilómetro"~"95401_1-TRANSPORTE GENERAL | Kilómetro",
                     Item == "575_2-BANCO DE SANGRE | Exámen"~"51001_1-BANCO DE SANGRE | Exámen",
                     TRUE ~ Item))
                     
# Asigna CC actualizados al 2023 ------------------------------------------
unidades <- unidades %>% mutate(`PERC ASOCIADO` = 
                        case_when(
                          `PERC ASOCIADO` ==	"478-QUIRÓFANOS OFTALMOLOGÍA"	~	"471-QUIRÓFANOS MAYOR AMBULATORIA",
                          `PERC ASOCIADO` ==	"480-QUIRÓFANOS OTORRINOLARINGOLOGÍA"	~	"471-QUIRÓFANOS MAYOR AMBULATORIA",
                          `PERC ASOCIADO` == "273-CONSULTA MEDICINA INTERNA"~"15102-CONSULTA MEDICINA INTERNA",
                          `PERC ASOCIADO` == "274-CONSULTA NEUROLOGÍA"~"15103-CONSULTA NEUROLOGÍA",
                          `PERC ASOCIADO` == "275-CONSULTA REUMATOLOGÍA"~"15104-CONSULTA REUMATOLOGÍA",
                          `PERC ASOCIADO` == "276-CONSULTA CARDIOLOGÍA"~"15105-CONSULTA CARDIOLOGÍA",
                          `PERC ASOCIADO` == "277-CONSULTA DERMATOLOGÍA"~"15106-CONSULTA DERMATOLOGÍA",
                          `PERC ASOCIADO` == "278-CONSULTA ONCOLOGÍA"~"15107-CONSULTA ONCOLOGÍA",
                          `PERC ASOCIADO` == "279-PROGRAMA VIH"~"15108-PROGRAMA VIH",
                          `PERC ASOCIADO` == "280-CONSULTA PSIQUIATRÍA"~"15109-CONSULTA PSIQUIATRÍA",
                          `PERC ASOCIADO` == "281-CONSULTA ENDOCRINOLOGÍA"~"15110-CONSULTA ENDOCRINOLOGÍA",
                          `PERC ASOCIADO` == "282-CONSULTA NEUMOLOGÍA"~"15111-CONSULTA NEUMOLOGÍA",
                          `PERC ASOCIADO` == "284-CONSULTA INFECTOLOGÍA"~"15113-CONSULTA INFECTOLOGÍA",
                          `PERC ASOCIADO` == "285-CONSULTA NEFROLOGÍA"~"15114-CONSULTA NEFROLOGÍA",
                          `PERC ASOCIADO` == "286-CONSULTA GENÉTICA"~"15115-CONSULTA GENÉTICA",
                          `PERC ASOCIADO` == "287-CONSULTA HEMATOLOGÍA"~"15116-CONSULTA HEMATOLOGÍA",
                          `PERC ASOCIADO` == "288-CONSULTA GERIATRÍA"~"15117-CONSULTA GERIATRÍA",
                          `PERC ASOCIADO` == "289-CONSULTA FISIATRÍA"~"15118-CONSULTA FISIATRÍA",
                          `PERC ASOCIADO` == "290-CONSULTA GASTROENTEROLOGÍA"~"15119-CONSULTA GASTROENTEROLOGÍA",
                          `PERC ASOCIADO` == "292-CONSULTA NEUROCIRUGÍA"~"15121-CONSULTA NEUROCIRUGÍA",
                          `PERC ASOCIADO` == "294-PROGRAMA MANEJO DEL DOLOR"~"15123-PROGRAMA MANEJO DEL DOLOR",
                          `PERC ASOCIADO` == "295-CONSULTA SALUD OCUPACIONAL"~"15124-CONSULTA SALUD OCUPACIONAL",
                          `PERC ASOCIADO` == "296-CONSULTA ANESTESIOLOGIA"~"15125-CONSULTA ANESTESIOLOGIA",
                          `PERC ASOCIADO` == "302-PROGRAMA ENFERMEDADES DE TRANSMISIÓN SEXUAL"~"15131-PROGRAMA ENFERMEDADES DE TRANSMISIÓN SEXUAL",
                          `PERC ASOCIADO` == "306-CONSULTA HEMATOLOGÍA ONCOLÓGICA"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
                          `PERC ASOCIADO` == "307-CONSULTA DE INMUNOLOGÍA"~"15136-CONSULTA DE INMUNOLOGÍA",
                          `PERC ASOCIADO` == "309-CONSULTA CIRUGÍA GENERAL"~"15201-CONSULTA CIRUGÍA GENERAL",
                          `PERC ASOCIADO` == "311-CONSULTA UROLOGÍA"~"15203-CONSULTA UROLOGÍA",
                          `PERC ASOCIADO` == "316-CONSULTA CIRUGÍA PLÁSTICA"~"15208-CONSULTA CIRUGÍA PLÁSTICA",
                          `PERC ASOCIADO` == "317-CONSULTA OFTALMOLOGÍA"~"15209-CONSULTA OFTALMOLOGÍA",
                          `PERC ASOCIADO` == "318-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA"~"15210-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA",
                          `PERC ASOCIADO` == "319-CONSULTA OTORRINOLARINGOLOGÍA"~"15211-CONSULTA OTORRINOLARINGOLOGÍA",
                          `PERC ASOCIADO` == "323-CONSULTA CIRUGÍA MAXILOFACIAL"~"15215-CONSULTA CIRUGÍA MAXILOFACIAL",
                          `PERC ASOCIADO` == "326-CONSULTA DE TRAUMATOLOGÍA"~"15218-CONSULTA DE TRAUMATOLOGÍA",
                          `PERC ASOCIADO` == "328-CONSULTA PEDIATRÍA GENERAL"~"15302-CONSULTA PEDIATRÍA GENERAL",
                          `PERC ASOCIADO` == "329-CONSULTA NEONATOLOGÍA"~"15303-CONSULTA NEONATOLOGÍA",
                          `PERC ASOCIADO` == "331-CONSULTA NEUROLOGÍA PEDIÁTRICA"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
                          `PERC ASOCIADO` == "342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA"~"15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
                          `PERC ASOCIADO` == "351-CONSULTA CIRUGÍA PEDIÁTRICA"~"15409-CONSULTA CIRUGÍA PEDIÁTRICA",
                          `PERC ASOCIADO` == "353-CONSULTA GINECOLOGICA"~"15502-CONSULTA GINECOLOGICA",
                          `PERC ASOCIADO` == "354-CONSULTA OBSTETRICIA"~"15503-CONSULTA OBSTETRICIA",
                          `PERC ASOCIADO` == "230-CONSULTA NUTRICIÓN"~"15008-CONSULTA NUTRICIÓN",
                          `PERC ASOCIADO` == "232-CONSULTA OTROS PROFESIONALES"~"15010-CONSULTA OTROS PROFESIONALES",
                          `PERC ASOCIADO` == "356-CONSULTA ODONTOLOGÍA"~"15602-CONSULTA ODONTOLOGÍA",
                          `PERC ASOCIADO` == "152-HOSPITALIZACIÓN EN CASA"~"2002-HOSPITALIZACIÓN EN CASA",
                          `PERC ASOCIADO` == "159-HOSPITALIZACIÓN DE DIA"~"2009-HOSPITALIZACIÓN DE DIA",
                          `PERC ASOCIADO` == "244-PROCEDIMIENTO DE NEUMOLOGÍA"~"15022-PROCEDIMIENTO DE NEUMOLOGÍA",
                          `PERC ASOCIADO` == "249-PROCEDIMIENTOS DE DERMATOLOGÍA"~"15027-PROCEDIMIENTOS DE DERMATOLOGÍA",
                          `PERC ASOCIADO` == "250-PROCEDIMIENTOS DE GASTROENTEROLOGÍA"~"15028-PROCEDIMIENTOS DE GASTROENTEROLOGÍA",
                          `PERC ASOCIADO` == "251-PROCEDIMIENTOS DE GINECOLOGÍA"~"15029-PROCEDIMIENTOS DE GINECOLOGÍA",
                          `PERC ASOCIADO` == "258-PROCEDIMIENTOS DE OFTALMOLOGÍA"~"15036-PROCEDIMIENTOS DE OFTALMOLOGÍA",
                          `PERC ASOCIADO` == "261-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA"~"15039-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA",
                          `PERC ASOCIADO` == "263-PROCEDIMIENTOS DE UROLOGÍA"~"15041-PROCEDIMIENTOS DE UROLOGÍA",
                          `PERC ASOCIADO` == "269-PROCEDIMIENTOS DE NEUROLOGÍA"~"15047-PROCEDIMIENTOS DE NEUROLOGÍA",
                          `PERC ASOCIADO` == "542-IMAGENOLOGÍA"~"41108-IMAGENOLOGÍA",
                          `PERC ASOCIADO` == "575-BANCO DE SANGRE"~"51001-BANCO DE SANGRE",
                          `PERC ASOCIADO` == "593-SERVICIO FARMACEUTICO"~"55101-SERVICIO FARMACEUTICO",
                          `PERC ASOCIADO` == "662-CENTRAL DE ESTERILIZACIÓN"~"95301-CENTRAL DE ESTERILIZACIÓN",
                          `PERC ASOCIADO` == "657-LAVANDERIA Y ROPERIA"~"95201-LAVANDERIA Y ROPERIA",
                          `PERC ASOCIADO` == "664-TRANSPORTE GENERAL"~"95401-TRANSPORTE GENERAL",
                          `PERC ASOCIADO` == "665-MANTENIMIENTO"~"95501-MANTENIMIENTO",
                          `PERC ASOCIADO` == "713-TRABAJO SOCIAL"~"99544-TRABAJO SOCIAL",
                          
                          `PERC ASOCIADO` == "586-DIALISIS PERITONEAL"~"116-HOSPITALIZACIÓN PEDIATRÍA",
                          `PERC ASOCIADO` == "260-PROCEDIMIENTO ONCOLOGÍA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
                          TRUE ~ `PERC ASOCIADO`))

#CONTRALORIA
unid_reportar <- c(     
"473_1-QUIRÓFANOS MENOR AMBULATORIA | Intervencion quirurgica",        
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
"261_1-PROCEDIMIENTOS DE OTORRINOLARINGOLOGÍA | Procedimiento",
"262_1-PROCEDIMIENTOS DE TRAUMATOLOGÍA | Procedimiento",
"240_1-PROCEDIMIENTO DE CARDIOLOGÍA | Procedimiento",               
"244_1-PROCEDIMIENTO DE NEUMOLOGÍA | Procedimiento",             
"269_1-PROCEDIMIENTOS DE NEUROLOGÍA | Procedimiento")


contraloria <- data.frame(
  "reportar" = as.character(c(unid_reportar)), 
  "capturado" = as.character(c(unid_reportar %in% unidades$Item))
)


errores_en_reportes <- data.frame("PERC ASOCIADO"= "Gato", "Cantidad"=0, "Item"="Gato", "reporte"= "Gato")
colnames(errores_en_reportes)[1] <- "PERC ASOCIADO"

i=1
while(i < 13) {

  if (i == 1) {z = anatomia_patologica_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 2) {z = alimentacion_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 3) {z = aseo_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 4) {z = cmenor_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 5) {z = esterilizacion_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 6) {z = farmacia_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 7) {z = imagenologia_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 8) {z = laboratorio_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 9) {z = psicosocial_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 10) {z = rehabilitacion_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 11) {z = transporte_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1}
  if (i == 12) {z = UMT_perc
  z$reporte <- z$`PERC ASOCIADO` %in% CC_autorizado$CC | z$`PERC ASOCIADO` %in% CC_autorizado$CC_antiguo
  errores_en_reportes <- rbind(errores_en_reportes, z)
  i = i+1
  errores_en_reportes <- errores_en_reportes %>% filter(reporte == FALSE)}
}

errores_en_reportes <- errores_en_reportes %>% filter(`PERC ASOCIADO` != "586-DIALISIS PERITONEAL" &
                                                       `PERC ASOCIADO` != "260-PROCEDIMIENTO ONCOLOGÍA")

unidades$`PERC ASOCIADO` <-  ifelse(unidades$`PERC ASOCIADO` == "467-QUIRÓFANOS DIGESTIVA", "484-QUIRÓFANOS TORACICA", unidades$`PERC ASOCIADO`)

openxlsx::write.xlsx(unidades, graba, colNames = TRUE, sheetName = "indirectos", overwrite = TRUE)

# Borrar Data -------------------------------------------------------------

rm(alimentacion_perc, anatomia_patologica_perc, aseo_perc, cmenor_perc, equipos_medicos_perc, esterilizacion, esterilizacion_perc, farmacia_perc, imagenologia_perc, laboratorio_perc, lavanderia, rehabilitacion_perc, t1, t2, t3, transporte_perc, UMT_perc, unid_reportar, psicosocial_perc, farmacia1, farmacia2, UMT1, UMT2, graba, cola_ruta_registro_a, cola_ruta_registro_b, resto_ruta_registro_a, resto_ruta_registro_b, ODOURG1, URG, uti, uci, uticv, ucicv, p_cardio, p_dermato, p_gastro, p_neumo, p_neurologia, p_oto, p_tmt, c, d, z, CC_autorizado, contraloria, a, b, i, mes_archivo,
   mes_ruta_registros, ruta_base, resto)
